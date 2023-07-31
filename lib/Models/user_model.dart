class UserModel {
  int? id;
  String? userName;
  String? password;

  UserModel({this.id, this.userName, this.password});

  UserModel.fromJson(Map<String, dynamic> map) {
    userName = map['id'];
    userName = map['userName'];
    password = map['password'];
  }

  Map<String, dynamic> toJson(UserModel usr) => {
        'useridName': usr.id,
        'userName': usr.userName,
        'password': usr.password
      };
}
