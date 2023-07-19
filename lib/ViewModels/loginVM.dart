import 'package:flutter/material.dart';
import 'package:students/Models/user_model.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';

class LoginVM {
  Future<String> logIn(String name, String password) async {
    try {
      await UsersLocal().get(name, password);
      return "Welcome";
    } catch (e) {
      return e.toString();
    }
  }
}
