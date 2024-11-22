import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class ApiProvider {
  final Dio _dio;

  ApiProvider(Dio dio)
      : _dio = dio,
        baseUri = Uri.parse(dio.options.baseUrl),
        baseHeaders = dio.options.headers;

  final Uri baseUri;
  final Map<String, dynamic> baseHeaders;

  Future<Map<String, Object?>?> sendRequest<T extends Object>({
    required String path,
    required String method,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
    Object? body,
  }) async {
    try {
      final uri = _buildUri(path: path, queryParams: queryParams);
      final options = Options(
        headers: headers ?? baseHeaders,
        method: method,
        contentType: 'application/json',
        responseType: ResponseType.json,
      );

      final response = await _dio.request<T>(
        uri.toString(),
        data: body,
        options: options,
      );

      final resp = await _decodeResponse(
        response.data,
        statusCode: response.statusCode,
      );

      return resp;
    } on RestClientException {
      rethrow;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        Error.throwWithStackTrace(
          ConnectionException(
            message: 'ConnectionException',
            statusCode: e.response?.statusCode,
            cause: e,
          ),
          e.stackTrace,
        );
      }
      if (e.response != null) {
        final result = await _decodeResponse(
          e.response?.data,
          statusCode: e.response?.statusCode,
        );

        return result;
      }
      Error.throwWithStackTrace(
        ClientException(
          message: e.toString(),
          statusCode: e.response?.statusCode,
          cause: e,
        ),
        e.stackTrace,
      );
    } on Object catch (e, stack) {
      Error.throwWithStackTrace(
        ClientException(message: e.toString(), cause: e),
        stack,
      );
    }
  }

  Future<Map<String, Object?>?> delete(
    String path, {
    Object? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'DELETE',
        body: body,
        headers: headers ?? baseHeaders,
        queryParams: queryParams,
      );

  Future<Map<String, Object?>?> get(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'GET',
        headers: headers ?? baseHeaders,
        queryParams: queryParams,
      );

  Future<Map<String, Object?>?> patch(
    String path, {
    Object? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'PATCH',
        body: body,
        headers: headers ?? baseHeaders,
        queryParams: queryParams,
      );

  Future<Map<String, Object?>?> post(
    String path, {
    Object? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'POST',
        body: body,
        headers: headers ?? baseHeaders,
        queryParams: queryParams,
      );

  Future<Map<String, Object?>?> put(
    String path, {
    Object? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'PUT',
        body: body,
        headers: headers ?? baseHeaders,
        queryParams: queryParams,
      );

  Uri _buildUri({required String path, Map<String, Object?>? queryParams}) {
    final finalPath = '${baseUri.path}$path';
    final params = {
      ...baseUri.queryParameters,
      if (queryParams != null) ...queryParams,
    };
    return baseUri.replace(
      path: finalPath,
      queryParameters:
          params.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  FutureOr<Map<String, Object?>?> _decodeResponse(
    Object? body, {
    int? statusCode,
  }) async {
    if (body == null) return null;
    try {
      Map<String, Object?> result;
      if (body is String) {
        result = json.decode(body) as Map<String, Object?>;
      } else if (body is Map<String, Object?>) {
        result = body;
      } else if (body is List<int>) {
        result = json.fuse(utf8).decode(body)! as Map<String, Object?>;
      } else if (body is List<dynamic>) {
        final iterableResponse = body.map(
          (item) {
            if (item is String) {
              return json.decode(item) as Map<String, Object?>;
            } else if (item is Map<String, Object?>) {
              return item;
            }
          },
        ).toList();
        result = {'data': iterableResponse};
      } else {
        throw WrongResponseTypeException(
          message: 'Unexpected response body type: ${body.runtimeType}',
          statusCode: statusCode,
        );
      }

      if (result['error'] is String) {
        throw CustomServerException(
          message: result['message'] as String? ?? 'Server error',
          error: result['error']! as String,
          statusCode: statusCode,
        );
      }

      return result;
    } on RestClientException {
      rethrow;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ClientException(
          message: 'Error occurred during decoding',
          statusCode: statusCode,
          cause: e,
        ),
        stackTrace,
      );
    }
  }
}
