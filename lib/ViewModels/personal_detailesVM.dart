import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';

class PersonalDetailesVM {
  //SharedPreferences sherPre = await SharedPreferences.getInstance();

  getUserName() async {
    SharedPreferences sherPre = await SharedPreferences.getInstance();

    return sherPre.getString('userName');
  }

  getPasswordName() async {
    SharedPreferences sherPre = await SharedPreferences.getInstance();

    return sherPre.getString('password');
  }

  delete(String oldPassword) async {
    SharedPreferences sherPre = await SharedPreferences.getInstance();
    if (sherPre.getString('password') == oldPassword) {
      int id = sherPre.getInt('id')!;
      await UsersLocal().delete(id);

      return "Done";
    } else {
      return "Your password incorrect";
    }
    //return sherPre.getString('password');
  }
}
