import 'dart:async';

import 'package:dio/dio.dart';
import '../app_config.dart';
import 'interceptors/dio_log_interceptor.dart';

part 'interceptors/error_interceptor.dart';

class DioConfig {
  final AppConfig appConfig;
  final Dio _dio = Dio();

  Dio get dio => _dio;

  DioConfig({required this.appConfig}) {
    _dio
      ..options.baseUrl = appConfig.baseUrl
      ..interceptors.addAll(<Interceptor>[
        ErrorInterceptor(_dio),
        dioLoggerInterceptor,
      ]);
  }

  Map<String, String> headers = <String, String>{};
}
