
import 'dart:convert';

import 'package:find_me_words/core/models/remote/word_model.dart';

class WordCacheModel {
  final String word;
  final String meaning;
  final String? json;
  final bool hasFullData;
  final bool isBookmarked;

  const WordCacheModel({
    required this.word,
    required this.meaning,
    this.json,
    required this.hasFullData,
    required this.isBookmarked
  });

  /// Asset JSON preload
  factory WordCacheModel.fromAssetEntry(
    MapEntry<String, dynamic> entry,
  ) {
    return WordCacheModel(
      word: entry.key,
      meaning: entry.value.toString(),
      json: null,
      hasFullData: false,
      isBookmarked: false
    );
  }

  /// After API response, store the response to DB
  factory WordCacheModel.fromApiResponse(
    List<WordModel> response,
  ) {
    final word = response.first;

    return WordCacheModel(
      word: word.word,
      meaning: _extractMeaning(word),
      json: jsonEncode(
        response.map((e) => e.toJson()).toList(),
      ),
      hasFullData: true,
      isBookmarked: false
    );
  }

  /// DB map -> model
  factory WordCacheModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return WordCacheModel(
      word: map['word'],
      meaning: map['meaning'],
      json: map['json'],
      hasFullData: map['hasFullData'] == 1,
      isBookmarked: map['isBookmarked'] == 1
    );
  }

  /// model -> DB map
  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'meaning': meaning,
      'json': json,
      'hasFullData': hasFullData ? 1 : 0,
    };
  }

  /// Parse stored JSON back to API model
  List<WordModel>? toWordModels() {
    if (json == null) return null;

    final decoded = jsonDecode(json!);

    return (decoded as List)
        .map((e) => WordModel.fromJson(e))
        .toList();
  }

  static String _extractMeaning(
    WordModel model,
  ) {
    try {
      return model
          .meanings
          .first
          .definitions
          .first
          .definition;
    } catch (_) {
      return '';
    }
  }

}