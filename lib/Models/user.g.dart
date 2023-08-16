// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      fullName: json['fullName'] as String?,
      lastName: json['lastName'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      neighborhood: json['neighborhood'] as String?,
      borthDay: json['borthDay'] == null
          ? DateTime.now()
          : DateTime.parse(json['borthDay'] as String),
      gender: json['gender'] as int?,
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'lastName': instance.lastName,
      'country': instance.country,
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'borthDay': instance.borthDay?.toIso8601String(),
      'gender': instance.gender,
      'userName': instance.userName,
      'password': instance.password,
    };
