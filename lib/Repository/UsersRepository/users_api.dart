import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_repository.dart';

class UsersAPI extends UserRepository {
  @override
  Future<bool> create(User user) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<User> logIn(String name, String password) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<User> put(int id, User user) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<User> get(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
