import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_repository.dart';
import 'package:students/data/database_init.dart';

class UsersLocal extends UserRepository {
  SqlDb db = SqlDb();
  @override
  Future<bool> create(User user) async {
    int response = await db.create(user);
    if (response != 0) {
      return true;
    } else {
      throw "User name is allready used try to use another";
    }
  }

  @override
  Future<User> logIn(String name, String password) async {
    var response = await db.get(name, password);
    if (!response.isEmpty) {
      var data = response.first;
      return User.fromJson(response.first);
    } else {
      throw 'Error in username or password';
    }
  }

  @override
  Future<User> put(int id, User user) async {
    var response = await db.update(id, user);
    if (response == 1) {
      return get(id);
    } else {
      throw 'Error while Processing';
    }
  }

  @override
  Future<bool> delete(int id) async {
    var response = await db.deleteData(id);
    return true;
  }

  @override
  getAll() async {
    List<Map<String, Object?>> response = await db.getAll("students");
    List<User> users = response.map((json) => User.fromJson(json)).toList();
    return users;
  }

  @override
  Future<User> get(int id) async {
    var response = await db.getById(id);
    if (!response.isEmpty) {
      var data = response.first;

      return User.fromJson(data);
    } else {
      throw 'error while loading';
    }
  }
}
