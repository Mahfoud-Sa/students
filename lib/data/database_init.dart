import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user.dart';
import 'package:students/main.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'School.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {}

  _onCreate(Database db, int version) async {
    await db.execute('''
  
  CREATE TABLE "students" ( 
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "fullName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "neighborhood" TEXT NOT NULL,
    "borthDay" TEXT NOT NULL,
    "gender" INTEGER NOT NULL,
    "userName" TEXT NOT NULL unique,
    "password" TEXT NOT NULL 

    )
 ''');
  }

  get(String userName, String password) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.query('students',
        columns: [
          "id",
          "fullName",
          "lastName",
          "country",
          "city",
          "neighborhood",
          "borthDay",
          "gender",
          "userName",
          "password"
        ],
        where: "userName=? and password=?",
        whereArgs: [userName, password]);
    return response;
  }

  getById(int id) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.query('students',
        columns: [
          "id",
          "fullName",
          "lastName",
          "country",
          "city",
          "neighborhood",
          "borthDay",
          "gender",
          "userName",
          "password"
        ],
        where: "id=? ",
        whereArgs: [id]);
    return response;
  }

  create(User user) async {
    Database? mydb = await db;
    int response = await mydb!.insert('students', user.toJson());
    return response;
  }

  getAll(String query) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(query);
    return response;
  }

  update(int id, User user) async {
    Database? mydb = await db;
    int response = await mydb!
        .update("students", user.toJson(), where: "id=?", whereArgs: [id]);
    return response;
  }

  deleteData(int id) async {
    Database? mydb = await db;
    int response =
        await mydb!.delete("students", where: "id=?", whereArgs: [id]);

    return response;
  }
}

class AppProbider with ChangeNotifier {
  //UserModel CurrentUser = UserModel();

  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}

class DarkThemePreference {
  static const THEME_STATE = "THEMESTATE";
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATE, value);
  }

  Future<bool> getThene() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATE) ?? false;
  }
}
