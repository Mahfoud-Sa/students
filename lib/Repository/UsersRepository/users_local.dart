import 'package:students/Models/user_model.dart';
import 'package:students/Repository/UsersRepository/users_repository.dart';
import 'package:students/sqflite.dart';

class UsersLocal extends UserRepository {
  SqlDb db = SqlDb();
  @override
  Future<bool> create(UserModel user) async {
    int response = await db.insertData('''
                          INSERT INTO "users" ('name', 'password')
                          VALUES ("${user.userName}","${user.password}")
                          ''');
    if (response != 0) {
      return true;
    } else {
      throw "User name is allready used try to use another";
    }
  }

  @override
  Future<UserModel> get(String name, String password) async {
    var response = await db.readData(
        "SELECT * FROM users where name='$name' and password='$password'");
    if (!response.isEmpty) {
      return UserModel(userName: 'userName', password: 'password');
    } else {
      throw 'Error in username or password';
    }
  }

  @override
  Future<UserModel> put(UserModel user) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
