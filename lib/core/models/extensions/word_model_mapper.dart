import 'dart:convert';

import '../local/word_cache_model.dart';
import '../remote/word_model.dart';

extension WordModelMapper on WordModel {

  WordCacheModel toCacheModel() {

    return WordCacheModel(
      word: word,
      meaning: _extractMeaning(),
      json: jsonEncode(
        toJson(),
      ),
      hasFullData: true,
    );
  }

  String _extractMeaning() {

    try {

      return meanings
          .first
          .definitions
          .first
          .definition;

    } catch (_) {

      return '';
    }
  }
}