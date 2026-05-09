import 'package:find_me_words/core/models/remote/word_model.dart';

class HomeState {
  final String query;
  final List<String> suggestions;
  final WordModel? wordDetails;
  final bool hasInternet;
  final bool isLoading;

  HomeState({
    required this.query,
    required this.suggestions,
    required this.wordDetails,
    required this.hasInternet,
    required this.isLoading,
  });

  factory HomeState.initial() {
    return HomeState(
      query: '',
      suggestions: [],
      wordDetails: null,
      hasInternet: false,
      isLoading: false,
    );
  }

  HomeState copyWith({
    String? query,
    List<String>? suggestions,
    WordModel? wordDetails,
    bool? hasInternet,
    bool? isLoading,
  }) {
    return HomeState(
      query: query ?? this.query,
      suggestions: suggestions ?? this.suggestions,
      wordDetails: wordDetails ?? this.wordDetails,
      hasInternet: hasInternet ?? this.hasInternet,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}