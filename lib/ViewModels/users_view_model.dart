import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';

import '../Views/personal_detailes_edit_page.dart';
import '../Views/personal_detailes_page.dart';

class UsersViewModel with ChangeNotifier {
  List<User> users = [];
  User CurrentUser = User();
  Future<List<User>> getusers() async {
    var _users = await UsersLocal().getAll();
    users = _users;
    notifyListeners();
    return users;
  }

  late bool _isLoging = false; //'//CurrentUser.userName.isEmpty ? false : true;

  //login() {}

  logOut() async {
    SharedPreferences sherPre = await SharedPreferences.getInstance();
    sherPre.clear();
    _isLoging = !_isLoging;
  }

  Future<bool> IsLoging() async {
    SharedPreferences sherPre = await SharedPreferences.getInstance();
    var isLoging = sherPre.getBool('isLoging') ?? false;
    _isLoging = isLoging;
    if (isLoging) {
      getCurrentUser();
    }
    return _isLoging;
  }

  Future<User> getCurrentUser() async {
    //return CurrentUser;
    //UserModel CurrentUser = UserModel();

    SharedPreferences sherPre = await SharedPreferences.getInstance();
    int id = int.parse(sherPre.getInt('id').toString());

    String userName = sherPre.getString('userName').toString();

    String userPassword = sherPre.getString('password').toString();

    CurrentUser.id = id;
    CurrentUser.userName = userName;
    CurrentUser.password = userPassword;
    //User _user = User();
    return CurrentUser;
  }

  Future<bool> SetCurrentUser() async {
    SharedPreferences sherPre = await SharedPreferences.getInstance();

    int id = int.parse(sherPre.getInt('id').toString());
    String userName = sherPre.getString('userName').toString();
    String userPassword = sherPre.getString('password').toString();
    sherPre.setBool('isLoging', true);

    CurrentUser.id = id;
    CurrentUser.userName = userName;
    CurrentUser.password = userPassword;
    _isLoging = true;
    notifyListeners();
    return true;
  }

  navigateToUserDetailesEdit(BuildContext context, int id) {
    getUser(id).then((user) => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => PersonalDetailesEdit(
                    user: user,
                  )),
        ));
  }

  Future<String> addUser(String name, String password) async {
    User use = User(userName: name, password: password);
    try {
      await UsersLocal().create(use);
      users.add(use);
      notifyListeners();
      return "Done";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateUser(int id, User user) async {
    User use = await UsersLocal().put(id, user);
    notifyListeners();
    return "Done";
  }

  Future<User> getUser(int id) async {
    return await UsersLocal().get(id);
  }

  Future<String> deletetUser(int id, String text) async {
    if (await getUser(id).then((value) => value.password == text)) {
      if (await UsersLocal().delete(id)) {
        return "Done";
      } else {
        return "Error";
      }
    } else {
      return "password Does not Match ";
    }
  }
}
