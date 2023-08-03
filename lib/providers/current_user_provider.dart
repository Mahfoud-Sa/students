import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user_model.dart';

class CurrentUserProvider with ChangeNotifier {
  UserModel CurrentUser = UserModel();
  late bool _isLoging = false; //'//CurrentUser.userName.isEmpty ? false : true;
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

  //CurrentUser=getCurrentUser();
  Future<UserModel> getCurrentUser() async {
    //return CurrentUser;
    //UserModel CurrentUser = UserModel();

    SharedPreferences sherPre = await SharedPreferences.getInstance();
    int id = int.parse(sherPre.getInt('id').toString());

    String userName = sherPre.getString('userName').toString();

    String userPassword = sherPre.getString('password').toString();

    CurrentUser.id = id;
    CurrentUser.userName = userName;
    CurrentUser.password = userPassword;

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
}
