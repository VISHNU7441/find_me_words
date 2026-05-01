class HomeState {
  final String query;
  final List<String> suggestions;
  final bool isLoading;

  HomeState({
    required this.query,
    required this.suggestions,
    required this.isLoading,
  });

  factory HomeState.initial() {
    return HomeState(
      query: '',
      suggestions: [],
      isLoading: false,
    );
  }

  HomeState copyWith({
    String? query,
    List<String>? suggestions,
    bool? isLoading,
  }) {
    return HomeState(
      query: query ?? this.query,
      suggestions: suggestions ?? this.suggestions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}