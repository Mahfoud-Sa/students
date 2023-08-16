import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';

import '../Views/personal_detailes_edit_page.dart';

class UsersViewModel with ChangeNotifier {
  List<User> users = [];
  User CurrentUser = User();

  Future<List<User>> getusers() async {
    var _users = await UsersLocal().getAll();
    users = _users;
    notifyListeners();
    return users;
  }

  logOut() async {
    SharedPreferences sherPre = await SharedPreferences.getInstance();
    sherPre.clear();
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
    // var user2 = users.elementAt(id);
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
