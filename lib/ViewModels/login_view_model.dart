import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/utiles/navigations_utiles.dart';

import '../Views/personal_detailes_edit_page.dart';
import '../Views/personal_detailes_page.dart';

class LoginViewModel with ChangeNotifier {
  Future<bool> IsLoging(BuildContext context) async {
    try {
      SharedPreferences sherPre = await SharedPreferences.getInstance();
      sherPre.getBool('isLogin');
      String name = sherPre.getString('name')!;
      String password = sherPre.getString('password')!;

      logIn(name, password, context);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> logIn(
      String name, String password, BuildContext context) async {
    try {
      User currentUser = await UsersLocal().logIn(name, password);

      SharedPreferences sherPre = await SharedPreferences.getInstance();
      sherPre.setBool('isLogin', true);
      sherPre.setString('name', name);
      sherPre.setString('password', password);

      var usersViewModel = Provider.of<UsersViewModel>(context, listen: false);
      usersViewModel.CurrentUser = currentUser;
      usersViewModel.getusers();
      return "Welcome";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> Singin(
    String f_Fname,
    String Sname,
    String country,
    String city,
    String neighborhood,
    DateTime birthDay,
    int gender,
    String username,
    String password,
  ) async {
    User user = User(
        fullName: f_Fname,
        lastName: Sname,
        country: country,
        city: city,
        neighborhood: neighborhood,
        borthDay: birthDay,
        gender: gender,
        userName: username,
        password: password);
    try {
      await UsersLocal().create(user);
      return "Singin Successfully";
    } catch (e) {
      return e.toString();
    }
  }
}
