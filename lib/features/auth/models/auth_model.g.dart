// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequestModel _$RegisterRequestModelFromJson(
  Map<String, dynamic> json,
) => _RegisterRequestModel(
  username: json['username'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  name: json['name'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$RegisterRequestModelToJson(
  _RegisterRequestModel instance,
) => <String, dynamic>{
  'username': instance.username,
  'email': instance.email,
  'password': instance.password,
  'name': instance.name,
  'role': instance.role,
};

_LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    _LoginRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestModelToJson(_LoginRequestModel instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'role': instance.role,
    };

_RegisterResponseModel _$RegisterResponseModelFromJson(
  Map<String, dynamic> json,
) => _RegisterResponseModel(
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  token: json['token'] as String,
);

Map<String, dynamic> _$RegisterResponseModelToJson(
  _RegisterResponseModel instance,
) => <String, dynamic>{'user': instance.user, 'token': instance.token};

_LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    _LoginResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginResponseModelToJson(_LoginResponseModel instance) =>
    <String, dynamic>{'user': instance.user, 'token': instance.token};
