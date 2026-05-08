import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._internal();
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  static Database? _database;

  /// Public getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /// Initialize DB
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create all tables
  Future<void> _onCreate(Database db, int version) async {
    await _createWordsTable(db);
    await _createIndexes(db);

    // future tables:
    // await _createHistoryTable(db);
    // await _createFavoritesTable(db);
  }

  /// Handle DB migrations
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Example for future:
    if (oldVersion < 2) {
      // await db.execute('ALTER TABLE words ADD COLUMN something TEXT');
    }
  }

  /// Words table
  Future<void> _createWordsTable(Database db) async {
    await db.execute('''
      CREATE TABLE words (
        word TEXT PRIMARY KEY,
        meaning TEXT NOT NULL,
        json TEXT,
        hasFullData INTEGER NOT NULL DEFAULT 0,
        updatedAt INTEGER
      )
    ''');
  }

  /// Indexes (VERY IMPORTANT for performance)
  Future<void> _createIndexes(Database db) async {
    await db.execute('CREATE INDEX idx_word ON words(word)');
  }

  /// Optional: Clear DB (useful during dev)
  Future<void> clearAllTables() async {
    final db = await database;
    await db.delete('words');
  }

  /// Optional: Close DB
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
