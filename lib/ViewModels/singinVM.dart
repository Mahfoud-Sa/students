import 'package:flutter/material.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';

class SinginVM {
  Future<String> Singin(String name, String password) async {
    User use = User(userName: name, password: password);
    try {
      await UsersLocal().create(use);
      return "singInSuccefully";
    } catch (e) {
      return e.toString();
    }
  }
}
