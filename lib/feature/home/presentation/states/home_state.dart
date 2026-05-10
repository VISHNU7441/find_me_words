import 'package:find_me_words/core/models/remote/word_model.dart';
import 'package:flutter/material.dart';

class HomeState {
  final String query;
  final List<String> suggestions;
  final List<String> bookmarkItems;
  final WordModel? wordDetails;
  final bool hasInternet;
  final bool isLoading;
  final ThemeMode themeMode;
  final bool shouldShowNoDataScreen;

  HomeState({
    required this.query,
    required this.suggestions,
    required this.bookmarkItems,
    required this.wordDetails,
    required this.hasInternet,
    required this.isLoading,
    required this.themeMode,
    required this.shouldShowNoDataScreen
  });

  factory HomeState.initial() {
    return HomeState(
      query: '',
      suggestions: [],
      bookmarkItems: [],
      wordDetails: null,
      hasInternet: false,
      isLoading: false,
      themeMode: ThemeMode.system,
      shouldShowNoDataScreen: false
    );
  }

  HomeState copyWith({
    String? query,
    List<String>? suggestions,
    List<String>? bookmarkItems,
    ValueGetter<WordModel?>? wordDetails,
    bool? hasInternet,
    bool? isLoading,
    ThemeMode? themeMode,
    bool? shouldShowNoDataScreen,
  }) {
    return HomeState(
      query: query ?? this.query,
      suggestions: suggestions ?? this.suggestions,
      bookmarkItems: bookmarkItems ?? this.bookmarkItems,
      wordDetails: wordDetails != null ? wordDetails() : this.wordDetails,
      hasInternet: hasInternet ?? this.hasInternet,
      isLoading: isLoading ?? this.isLoading,
      themeMode: themeMode ?? this.themeMode,
      shouldShowNoDataScreen:
          shouldShowNoDataScreen ?? this.shouldShowNoDataScreen,
    );
  }
}