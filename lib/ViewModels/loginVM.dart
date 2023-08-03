import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Models/user_model.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/providers/current_user_provider.dart';

class LoginVM {
  Future<String> logIn(String name, String password) async {
    try {
      UserModel currentUser = await UsersLocal().get(name, password);

      SharedPreferences sherPre = await SharedPreferences.getInstance();
      sherPre.setInt('id', currentUser.id!);

      sherPre.setString('userName', currentUser.userName!);

      sherPre.setString('password', currentUser.password!);
      return "Welcome";
    } catch (e) {
      return e.toString();
    }
  }
}
