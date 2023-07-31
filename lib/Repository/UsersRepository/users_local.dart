import 'dart:convert';
import 'dart:typed_data';

import 'package:students/Models/user_model.dart';
import 'package:students/Repository/UsersRepository/users_repository.dart';
import 'package:students/sqflite.dart';

class UsersLocal extends UserRepository {
  SqlDb db = SqlDb();
  @override
  Future<bool> create(UserModel user) async {
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
  Future<UserModel> get(String name, String password) async {
    var response = await db.readData(
        "SELECT * FROM users where name='$name' and password='$password'");
    if (!response.isEmpty) {
      var data = response.first;
      //print(data['name']);
      //print(data.first.runtimeType);

      return UserModel(
          id: data['id'], userName: data['name'], password: data['password']);
    } else {
      throw 'Error in username or password';
    }
  }

  @override
  Future<UserModel> put(int id, UserModel user) async {
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
}
