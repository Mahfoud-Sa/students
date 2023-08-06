import 'package:students/Models/user.dart';

abstract class UserRepository {
  Future<List<User>> getAll();
  Future<User> put(int id, User user);
  Future<bool> create(User user);
  Future<User> logIn(String name, String password);
  Future<bool> delete(int id);
  Future<User> get(int id);
}
