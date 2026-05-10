import 'dart:async';
import 'dart:convert';
import 'package:find_me_words/core/database/app_database.dart';
import 'package:find_me_words/core/database/services/dictionary_query_service.dart';
import 'package:find_me_words/core/models/extensions/word_model_mapper.dart';
import 'package:find_me_words/core/models/remote/word_model.dart';
import 'package:find_me_words/core/network/api_client.dart';
import 'package:find_me_words/core/network/api_exceptions.dart';
import 'package:find_me_words/core/network/dio_provider.dart';
import 'package:find_me_words/feature/home/presentation/states/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

@riverpod
class HomePageController extends _$HomePageController {
  Timer? _debounce;

  final AppDatabase _database = AppDatabase();
  late final DictionaryQueryService _queryService = DictionaryQueryService(
    _database,
  );

  final dio = DioProvider.createDio();
  late final apiClient = ApiClient(dio);

  @override
  HomeState build() {
    ref.keepAlive();

    ref.onDispose(() {
      _debounce?.cancel();
    });

    return HomeState.initial();
  }

  // update the state on every text change
  void onQueryChanged(String value) {
    state = state.copyWith(query: value);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _fetchSuggestions(
        value,
      ); // call the function when the user stopped typing for 5 sec.
    });
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(suggestions: []);
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      List<String> results;

      results = await _queryService.searchSuggestions(query);

      state = state.copyWith(suggestions: results, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> searchFor(String word) async {
    final isPresent = await _queryService.isWordPresent(word);
    final isFullExplanationPresent = await _queryService
        .isWordHasFullExplanation(word);

    if (isPresent && isFullExplanationPresent) {
      // get full json and parse it
      state = state.copyWith(
        wordDetails: null,
        isLoading: true
      );

      // get the data from the local DB
      final cachedData = await _queryService.getFullExplanationForWord(word);
      final decodedData = jsonDecode(cachedData!);
      final wordDetails = WordModel.fromJson(decodedData);

      state = state.copyWith(
        wordDetails: wordDetails,
        isLoading: false
      );

    } else if (isPresent) {
      // call the api with the hasBasicMeaning flag = true
      // after successful api, update the full meaning on the local db
       await _searchWordDetails(word);
       await _updateDataOnDataBase(word, state.wordDetails!);

    } else {
      // call the api with the hasBasicMeaning flag = false
      await _searchWordDetails(word);

      // if the new text has meaning on the backend, the api will success and update that data on local db.
      final localDBModel = state.wordDetails?.toCacheModel();
      await _queryService.createNewWordWithFullExplanation(localDBModel!); 
    }
  }

  Future<void> _searchWordDetails(String word) async {
    try {
      state = state.copyWith(
        wordDetails: null,
        isLoading: true
      );

      final result = await _fetchWordDetails(word);

      state = state.copyWith(
        wordDetails: result.first,
        isLoading: false
      );

    } on NoInternetException {
      state = state.copyWith(
        hasInternet: false,
        isLoading: false
      );
    } on TimeoutException {
      state = state.copyWith(
        isLoading: false
      );
    } on ServerException {
      state = state.copyWith(
        isLoading: false
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false
      );
    }
  }

  // API Call
  Future<List<WordModel>> _fetchWordDetails(String word) async {
    return await apiClient.getWordDetails(word);
  }

  // Save the data on Database
  Future<void> _updateDataOnDataBase(String word, WordModel wordDetails)async {
    final jsonModel = jsonEncode(wordDetails.toJson());
    await _queryService.updateFullExplanationForWord(word: word,json: jsonModel);
  }

  // bookmark helper functions
  Future<void> getBookmarkedItems() async {
    state = state.copyWith(
      isLoading: true
    );

    final result = await _queryService.getBookmarkedWords();

    state = state.copyWith(
      bookmarkItems: result,
      isLoading: false
    );
  }

  Future<void> updateTheBookmarkState(String word) async {
    await _queryService.toggleBookmark(word);

    await getBookmarkedItems();
  }
}
