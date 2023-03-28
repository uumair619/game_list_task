import 'dart:io';


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../repository/model/GameModel.dart';


class DatabaseHelper
{
  static final String DB_NAME = "Games.db";
  static String GAME_TABLE = "Games";
  late Database _database;


  static Future<DatabaseHelper> initDB() async {
    var database = DatabaseHelper();
    database._database = await openDatabase(
        join(await getDatabasesPath(), DB_NAME),
        version: 1,
        onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $GAME_TABLE ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "location TEXT,"
          "playerCount INTEGER,"
          "date TEXT,"
          "image TEXT" ")"
        );
      },
    );
    return database;
  }

  Future<List<GameModel>> getAllGames() async {
    return getList("id ASC");
  }
  Future<List<GameModel>> getTimeSortedGameList() async {
    return getList("date ASC");
  }
  Future<List<GameModel>> getNameSortedGameList() async {
    return getList("title ASC");
  }
  Future<List<GameModel>> getList(String sort)async{
    List<Map> results = await _database.query(
        "$GAME_TABLE", columns: GameModel.columns, orderBy: sort
    );
    List<GameModel> games = List.empty(growable: true);
    results.forEach((result) {
      GameModel item = GameModel.fromMap(result);
      games.add(item);
    });
    return games;
  }

  insertGame(GameModel item) async
  {
    var maxIdResult = await _database.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM $GAME_TABLE");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await _database.rawInsert(
        "INSERT Into $GAME_TABLE (id, title, description, playerCount, date)"
            " VALUES (?, ?, ?, ?, ?)",
        [id, item.title, item.description, item.playerCount, item.date]
    );
    return result;

  }

  updateGame(GameModel item) async {
    var result = await _database.update(
        "$GAME_TABLE", item.toMap(), where: "id = ?", whereArgs: [item.id]
    );
    return result;
  }
  deleteGame(int id) async {
    _database.delete("$GAME_TABLE", where: "id = ?", whereArgs: [id]);
  }

  Future<bool> deleteDb() async {
    bool databaseDeleted = false;

    try {
      String path = join(await getDatabasesPath(), DB_NAME);
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        databaseDeleted = false;
      });
    } on DatabaseException catch (error) {
      print(error);
    } catch (error) {
      print(error);
    }

    return databaseDeleted;
  }

}