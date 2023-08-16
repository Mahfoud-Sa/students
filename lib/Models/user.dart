import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? fullName;
  String? lastName;
  String? country;
  String? city;
  String? neighborhood;
  DateTime? borthDay;
  int? gender;
  String? userName;
  String? password;

  User(
      {this.fullName,
      this.lastName,
      this.country,
      this.city,
      this.neighborhood,
      this.borthDay,
      this.gender,
      this.id,
      this.userName,
      this.password});

  getBirthDay() {
    return DateTime.now().difference(borthDay!);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
