import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../utils/logger/logger.dart';

class ApiClient {
  late final Dio _dio;

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  ApiClient(Dio dio) {
    _dio = dio;
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AppLogger.info('🚀 REQUEST: ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.info('✅ RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (error, handler) {
          AppLogger.error('❌ ERROR: ${error.message}');
          handler.next(error);
        },
      ),
    );

    // Debug uchun
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ));
    }
  }

  // GET request
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      AppLogger.error('GET request error: $e');
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      AppLogger.error('POST request error: $e');
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      AppLogger.error('PUT request error: $e');
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      AppLogger.error('DELETE request error: $e');
      rethrow;
    }
  }
}