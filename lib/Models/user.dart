class User {
  int? id;
  String? userName;
  String? password;

  User({this.id, this.userName, this.password});

  User.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    userName = map['name'];
    password = map['password'];
  }

  Map<String, dynamic> toJson(User usr) =>
      {'id': usr.id, 'userName': usr.userName, 'password': usr.password};
}
