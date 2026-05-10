import 'package:find_me_words/core/database/app_database.dart';
import 'package:find_me_words/core/models/local/word_cache_model.dart';
import 'package:sqflite/sqflite.dart';

class DictionaryQueryService {
  final AppDatabase appDatabase;

  const DictionaryQueryService(this.appDatabase);

  Future<bool> isWordPresent(String word) async {
    final db = await appDatabase.database;

    final result = await db.query(
      'words',
      columns: ['word'],
      where: 'word = ?',
      whereArgs: [word],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<bool> isWordHasFullExplanation(String word) async {
    final db = await appDatabase.database;

    final result = await db.query(
      'words',
      columns: ['hasFullData'],
      where: 'word = ?',
      whereArgs: [word],
      limit: 1,
    );

    if (result.isEmpty) {
      return false;
    }

    return result.first['hasFullData'] == 1;
  }

  Future<String?> getFullExplanationForWord(String word) async {
    final db = await appDatabase.database;

    final result = await db.query(
      'words',
      columns: ['json'],
      where: 'word = ?',
      whereArgs: [word],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first['json'] as String?;
  }

  Future<String?> getMeaningForWord(String word) async {
    final db = await appDatabase.database;

    final result = await db.query(
      'words',
      columns: ['meaning'],
      where: 'word = ?',
      whereArgs: [word],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first['meaning'] as String?;
  }

  Future<void> updateFullExplanationForWord({
    required String word,
    required String json,
  }) async {
    final db = await appDatabase.database;

    await db.update(
      'words',
      {
        'json': json,
        'hasFullData': 1,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'word = ?',
      whereArgs: [word],
    );
  }

  Future<void> createNewWordWithFullExplanation(WordCacheModel word) async {
    final db = await appDatabase.database;

    await db.insert(
      'words',
      word.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> searchSuggestions(String query) async {
    final db = await appDatabase.database;

    final result = await db.query(
      'words',
      columns: ['word'],
      where: 'word LIKE ?',
      whereArgs: ['$query%'],
      limit: 20,
    );

    return result.map((e) => e['word'] as String).toList();
  }
}
