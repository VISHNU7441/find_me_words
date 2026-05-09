import 'dart:async';
import 'package:find_me_words/core/database/app_database.dart';
import 'package:find_me_words/core/database/services/dictionary_query_service.dart';
import 'package:find_me_words/feature/home/presentation/states/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

@riverpod
class HomePageController extends _$HomePageController {
  Timer? _debounce;

  final AppDatabase _database = AppDatabase();
  late final DictionaryQueryService _queryService = DictionaryQueryService(_database);

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
      _fetchSuggestions(value);         // call the function when the user stopped typing for 5 sec.
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

      results =  await _queryService.searchSuggestions(query);

      state = state.copyWith(
        suggestions: results,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> searchFor(String word) async {
      final isPresent = await _queryService.isWordPresent(word);
      final isFullExplanationPresent = await _queryService.isWordHasFullExplanation(word);

      if (isPresent && isFullExplanationPresent) {
        // get full json and parse it
      } else if (isPresent) {
        // call the api with the hasBasicMeaning flag = true
      } else {
        // call the api with the hasBasicMeaning flag = false
      }
  }
}
