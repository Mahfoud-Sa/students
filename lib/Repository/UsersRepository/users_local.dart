import 'dart:convert';
import 'dart:typed_data';

import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_repository.dart';
import 'package:students/sqflite.dart';

class UsersLocal extends UserRepository {
  SqlDb db = SqlDb();
  @override
  Future<bool> create(User user) async {
    int response = await db.insertData('''
                          INSERT INTO "users" ('name', 'password')
                          VALUES ("${user.userName}","${user.password}")
                          ''');
    if (response != 0) {
      return true;
    } else {
      throw "User name is allready used try to use another";
    }
  }

  @override
  Future<User> logIn(String name, String password) async {
    var response = await db.readData(
        "SELECT * FROM users where name='$name' and password='$password'");
    if (!response.isEmpty) {
      var data = response.first;
      //print(data['name']);
      //print(data.first.runtimeType);

      return User(
          id: data['id'], userName: data['name'], password: data['password']);
    } else {
      throw 'Error in username or password';
    }
  }

  @override
  Future<User> put(int id, User user) async {
    var response = await db.updateData(
        "update users set name='${user.userName}',password='${user.password}' where id=$id");
    if (response == 1) {
      return user;
    } else {
      throw 'Error while Processing';
    }
  }

  @override
  Future<bool> delete(int id) async {
    var response = await db.deleteData("delete from users where id=$id");
    //if(response.)
    //print(data['name']);
    //print(data.first.runtimeType);

    return true;
  }

  @override
  getAll() async {
    List<Map<String, Object?>> response = await db.query("users");
    List<User> users = response.map((json) => User.fromJson(json)).toList();
    return users;
  }

  @override
  Future<User> get(int id) async {
    var response = await db.readData("SELECT * FROM users where id='$id'");
    if (!response.isEmpty) {
      var data = response.first;
      //print(data['name']);
      //print(data.first.runtimeType);

      return User(
          id: data['id'], userName: data['name'], password: data['password']);
    } else {
      throw 'error while loading';
    }
  }
}
