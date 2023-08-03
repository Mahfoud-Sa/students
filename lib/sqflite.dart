import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user_model.dart';

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
  
  CREATE TABLE "users" ( 
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "name" TEXT NOT NULL unique,
    "password" TEXT NOT NULL
    )
 ''');
  }

  readData(String query) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(query);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String query) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(query);
    //print(response);
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
