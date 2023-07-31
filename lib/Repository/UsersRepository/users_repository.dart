import 'package:students/Models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> put(int id, UserModel user);
  Future<bool> create(UserModel user);
  Future<UserModel> get(String name, String password);
  Future<bool> delete(int id);
}
