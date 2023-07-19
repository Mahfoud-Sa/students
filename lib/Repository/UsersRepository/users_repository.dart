import 'package:students/Models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> put(UserModel user);
  Future<bool> create(UserModel user);
  Future<UserModel> get(String name, String password);
}
