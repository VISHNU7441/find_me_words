import 'dart:convert';

import 'package:find_me_words/core/database/app_database.dart';
import 'package:find_me_words/core/models/local/word_cache_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';


class DictionaryPreloadService {
  final AppDatabase appDatabase;

  DictionaryPreloadService(this.appDatabase);

  Future<void> preloadDictionary() async {
    final db = await appDatabase.database;

    /// Prevent duplicate preload
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM words',
    );

    final count = Sqflite.firstIntValue(countResult) ?? 0;

    if (count > 0) {
      return;
    }

    /// Load JSON from assets
    final jsonString = await rootBundle.loadString(
      'assets/dictionary.json',
    );

    final Map<String, dynamic> decodedJson =
        jsonDecode(jsonString);

    /// Batch insert for performance
    final batch = db.batch();

    for (final entry in decodedJson.entries) {
      final word = WordCacheModel.fromAssetEntry(entry);

      batch.insert(
        'words',
        word.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    /// Commit batch
    await batch.commit(
      noResult: true,
      continueOnError: false,
    );
  }
}