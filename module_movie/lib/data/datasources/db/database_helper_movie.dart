import 'dart:async';

import 'package:module_generic/common/constants.dart';
import 'package:module_movie/data/models/movie/movie_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperMovie {
  static DatabaseHelperMovie? _databaseHelper;

  DatabaseHelperMovie._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelperMovie() =>
      _databaseHelper ?? DatabaseHelperMovie._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblMovieWatchlist = 'movieWatchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/$DATABASE';

    var db = await openDatabase(databasePath, version: 1, onOpen: _onOpen);
    return db;
  }

  void _onOpen(Database db) async {
    print("OPEN DB $_tblMovieWatchlist");
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tblMovieWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movie.toJson());
  }

  Future<int> removeMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMovieWatchlist);

    return results;
  }
}
