import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Models/user_model.dart';
import 'package:students/Repository/UsersRepository/users_api.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';

class PersonalDetailesEditVM {
  edit(UserModel user) async {
    try {
      SharedPreferences sherPre = await SharedPreferences.getInstance();

      int id = int.parse(sherPre.getInt('id').toString());
      UserModel upatedUser = await UsersLocal().put(id, user);

      sherPre.setString('userName', upatedUser.userName!);

      sherPre.setString('password', upatedUser.password!);
      return 'Updated Susseccfly';
    } catch (e) {
      return e.toString();
    }
  }
}
