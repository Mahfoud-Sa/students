import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/utiles/navigations_utiles.dart';

import '../Views/personal_detailes_edit_page.dart';
import '../Views/personal_detailes_page.dart';

class LoginViewModel with ChangeNotifier {
  Future<String> logIn(String name, String password) async {
    try {
      User currentUser = await UsersLocal().logIn(name, password);

      SharedPreferences sherPre = await SharedPreferences.getInstance();
      sherPre.setInt('id', currentUser.id!);

      sherPre.setString('userName', currentUser.userName!);

      sherPre.setString('password', currentUser.password!);

      return "Welcome";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> Singin(String name, String password) async {
    User use = User(userName: name, password: password);
    try {
      await UsersLocal().create(use);
      return "Singin Successfully";
    } catch (e) {
      return e.toString();
    }
  }
}
