import 'package:students/Models/user_model.dart';
import 'package:students/Repository/UsersRepository/users_repository.dart';

class UsersAPI extends UserRepository {
  @override
  Future<bool> create(UserModel user) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<UserModel> get(String name, String password) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<UserModel> put(int id, UserModel user) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
