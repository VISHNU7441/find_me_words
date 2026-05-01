import 'dart:async';
import 'package:find_me_words/feature/home/presentation/states/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

@riverpod
class HomePageController extends _$HomePageController {
  Timer? _debounce;

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
      final hasInternet = await _checkInternet();

      List<String> results;

      if (hasInternet) {
        results = await _fetchFromApi(query);
      } else {
        results = await _fetchFromLocal(query);
      }

      state = state.copyWith(
        suggestions: results,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> _checkInternet() async {
    // implement using connectivity package
    return true;
  }

  Future<List<String>> _fetchFromApi(String query) async {
    // call backend
    return ["Apple", "Application", "Apply"];
  }

  Future<List<String>> _fetchFromLocal(String query) async {
    // local DB / cache
    return ["Offline Result 1", "Offline Result 2"];
  }

}
