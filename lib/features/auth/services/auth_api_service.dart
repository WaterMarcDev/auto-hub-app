import 'package:auto_hub_app/core/router/api_routes.dart';
import 'package:auto_hub_app/core/services/base_api_client.dart';
import 'package:auto_hub_app/features/auth/models/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthApiService {
  final BaseApiClient _apiClient;

  AuthApiService(this._apiClient);

  /// Register a new user
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    final response = await _apiClient.post(
      ApiRoutes.register,
      data: request.toJson(),
    );
    return RegisterResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Login existing user
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _apiClient.post(
      ApiRoutes.login,
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Get logged in user profile
  Future<UserModel> getProfile() async {
    final response = await _apiClient.get<dynamic>(
      ApiRoutes.profile,
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Logout user
  Future<Response<dynamic>> logout() async {
    return _apiClient.post(
      ApiRoutes.logout,
    );
  }
}
