import 'package:auto_hub_app/core/router/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Base API client wrapping [Dio] with predefined configurations,
/// interceptors, and error handling as per architecture standards.
@lazySingleton
class BaseApiClient {
  late final Dio dio;

  BaseApiClient() {
    _initDio();
  }

  void _initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiRoutes.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      _authInterceptor(),
      _errorNormalizationInterceptor(),
      if (kDebugMode) _loggingInterceptor(),
    ]);
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // TODO: Inject auth token securely from local storage here
        // final token = await secureStorage.getToken();
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        return handler.next(options);
      },
    );
  }

  Interceptor _errorNormalizationInterceptor() {
    return InterceptorsWrapper(
      onError: (DioException e, handler) {
        // TODO: Normalize errors into consistent app-wide formats if needed
        return handler.next(e);
      },
    );
  }

  Interceptor _loggingInterceptor() {
    final logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 80,
      ),
    );

    return InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.d(
          'REQUEST[${options.method}] => PATH: ${options.path}\n'
          '=> Headers: ${options.headers}\n'
          '=> Data: ${options.data}',
        );
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.i(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}\n'
          '=> Data: ${response.data}',
        );
        return handler.next(response);
      },
      onError: (err, handler) {
        logger.e(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}\n'
          '=> Message: ${err.message}\n'
          '=> Data: ${err.response?.data}',
        );
        return handler.next(err);
      },
    );
  }

  // ==========================================
  // HTTP Methods Wrapper
  // ==========================================

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
