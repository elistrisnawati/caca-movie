import 'dart:async';

import 'package:module_generic/common/constants.dart';
import 'package:module_tv/data/models/tv/tv_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperTv {
  static DatabaseHelperTv? _databaseHelper;

  DatabaseHelperTv._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelperTv() => _databaseHelper ?? DatabaseHelperTv._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblTvWatchlist = 'tvWatchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/$DATABASE';

    var db = await openDatabase(databasePath, version: 1, onOpen: _onOpen);
    return db;
  }

  void _onOpen(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tblTvWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertTvWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.insert(_tblTvWatchlist, tv.toJson());
  }

  Future<int> removeTvWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblTvWatchlist,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTvWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvs() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTvWatchlist);

    return results;
  }
}
