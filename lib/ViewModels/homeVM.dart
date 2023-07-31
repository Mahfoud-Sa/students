import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user_model.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';

class HomeVM {
  getUserName() async {
    SharedPreferences sherPre = await SharedPreferences.getInstance();

    return sherPre.getString('userName');
  }
}
