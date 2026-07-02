import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
abstract class RegisterRequestModel with _$RegisterRequestModel {
  const factory RegisterRequestModel({
    required String username,
    required String email,
    required String password,
    required String name,
    required String role,
  }) = _RegisterRequestModel;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);
}

@freezed
abstract class LoginRequestModel with _$LoginRequestModel {
  const factory LoginRequestModel({
    required String email,
    required String password,
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String username,
    required String email,
    required String name,
    required String role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
abstract class RegisterResponseModel with _$RegisterResponseModel {
  const factory RegisterResponseModel({
    required UserModel user,
    required String token,
  }) = _RegisterResponseModel;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);
}

@freezed
abstract class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    required UserModel user,
    required String token,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
