import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper extends ChangeNotifier {
  sql.Database? db;
  DBHelper() {
    init();
  }

  init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(path.join(dbPath, 'favorite_games.db'),
        onCreate: (db, version) {
      final stmt = '''CREATE TABLE IF NOT EXISTS Favorite_games (
            index NOT NULL AUTO_INCREMENT,
            game_id TEXT PRIMARY KEY
          
        )'''
          .trim()
          .replaceAll(RegExp(r'[\s]{2,}'), ' ');
      return db.execute(stmt);
    }, version: 1);
    notifyListeners();
  }

  Future insertGame(Map<String, dynamic> gameData) async {
    await db!.insert('Favorite_games', gameData,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future deleteGame(String flag) async {
    await db!.delete('Favorite_games', where: 'game_id = ?', whereArgs: [flag]);
  }

  Future<List<Map<String, dynamic>>> getFavoriteGames() async {
    String query = "SELECT * FROM Favorite_games";
    return await db!.rawQuery(
      query,
    );
  }

  Future<bool> isFavorite(String gameId) async {
    print("Game Id is$gameId");
    String query = "SELECT 1 FROM Favorite_games WHERE game_id=$gameId";
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);
    print("The data is $maps");
    
    return maps.isNotEmpty;
  }
}
