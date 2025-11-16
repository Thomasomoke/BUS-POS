import 'dart:async';
import 'dart:convert';

import 'package:bus_pos/core/config/app_env.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final Map<String, String> defaultHeaders;
  final Duration timeout;

  String? _authToken;
  final String baseUrl = AppEnv.baseUrl;

  HttpClient({Map<String, String>? defaultHeaders, Duration? timeout})
    : defaultHeaders =
          defaultHeaders ?? const {'Content-Type': 'application/json'},
      timeout = timeout ?? const Duration(seconds: 30);

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  Map<String, String> _buildHeaders(
    Map<String, String>? headers, {
    bool forceJson = true,
  }) {
    final Map<String, String> out = {};
    out.addAll(defaultHeaders);

    if (!forceJson) {
      out.remove('Content-Type');
    }

    if (_authToken != null && _authToken!.isNotEmpty) {
      out['Authorization'] = 'Bearer $_authToken';
    }

    if (headers != null) {
      out.addAll(headers);
    }

    return out;
  }

  Uri _buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final p = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse(base + p);

    if (queryParameters == null || queryParameters.isEmpty) return uri;

    final qp = queryParameters.map((k, v) => MapEntry(k, v?.toString() ?? ''));
    return uri.replace(queryParameters: qp);
  }

  Future<http.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool throwOnError = false,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final h = _buildHeaders(headers);
    if (kDebugMode) debugPrint('GET $uri\nheaders: $h');

    final resp = await http.get(uri, headers: h).timeout(timeout);
    if (kDebugMode) debugPrint('GET ${resp.statusCode} ${resp.body}');
    if (throwOnError && resp.statusCode >= 400) {
      throw HttpException(resp.statusCode, resp.body);
    }
    return resp;
  }

  Future<http.Response> post(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool encodeJson = true,
    bool throwOnError = true,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final isJson = encodeJson;
    final h = _buildHeaders(headers, forceJson: isJson);
    Object? finalBody;

    if (body != null) {
      if (isJson) {
        finalBody = body is String ? body : jsonEncode(body);
      } else {
        finalBody = body;
      }
    }

    if (kDebugMode) {
      debugPrint('POST $uri\nheaders: $h\nbody: ${finalBody ?? "null"}');
    }

    final resp = await http
        .post(uri, headers: h, body: finalBody)
        .timeout(timeout);
    if (kDebugMode) debugPrint('POST ${resp.statusCode} ${resp.body}');
    if (throwOnError && (resp.statusCode != 200 || resp.statusCode != 201)) {
      throw HttpException(resp.statusCode, resp.body);
    }
    return resp;
  }

  Future<http.Response> put(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool encodeJson = true,
    bool throwOnError = true,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final isJson = encodeJson;
    final h = _buildHeaders(headers, forceJson: isJson);
    Object? finalBody;
    if (body != null) {
      finalBody = isJson ? (body is String ? body : jsonEncode(body)) : body;
    }

    if (kDebugMode) {
      debugPrint('PUT $uri\nheaders: $h\nbody: ${finalBody ?? "null"}');
    }

    final resp = await http
        .put(uri, headers: h, body: finalBody)
        .timeout(timeout);
    if (kDebugMode) debugPrint('PUT ${resp.statusCode} ${resp.body}');
    if (throwOnError && (resp.statusCode != 200 || resp.statusCode != 201)) {
      throw HttpException(resp.statusCode, resp.body);
    }
    return resp;
  }

  Future<http.Response> patch(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool encodeJson = true,
    bool throwOnError = true,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final isJson = encodeJson;
    final h = _buildHeaders(headers, forceJson: isJson);
    Object? finalBody;
    if (body != null) {
      finalBody = isJson ? (body is String ? body : jsonEncode(body)) : body;
    }

    if (kDebugMode) {
      debugPrint('PATCH $uri\nheaders: $h\nbody: ${finalBody ?? "null"}');
    }

    final resp = await http
        .patch(uri, headers: h, body: finalBody)
        .timeout(timeout);
    if (kDebugMode) debugPrint('PATCH ${resp.statusCode} ${resp.body}');
    if (throwOnError && (resp.statusCode != 200 || resp.statusCode != 201)) {
      throw HttpException(resp.statusCode, resp.body);
    }
    return resp;
  }

  Future<http.Response> delete(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool encodeJson = true,
    bool throwOnError = true,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final isJson = encodeJson;
    final h = _buildHeaders(headers, forceJson: isJson);
    Object? finalBody;
    if (body != null) {
      finalBody = isJson ? (body is String ? body : jsonEncode(body)) : body;
    }

    if (kDebugMode) {
      debugPrint('DELETE $uri\nheaders: $h\nbody: ${finalBody ?? "null"}');
    }

    final resp = await http
        .delete(uri, headers: h, body: finalBody)
        .timeout(timeout);
    if (kDebugMode) debugPrint('DELETE ${resp.statusCode} ${resp.body}');
    if (throwOnError && (resp.statusCode != 200 || resp.statusCode != 201)) {
      throw HttpException(resp.statusCode, resp.body);
    }
    return resp;
  }

  Future<http.Response> postMultipart(
    String path, {
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String method = 'POST',
    bool throwOnError = false,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final h = _buildHeaders(headers, forceJson: false);

    final req = http.MultipartRequest(method, uri);
    req.headers.addAll(h);
    if (fields != null) req.fields.addAll(fields);
    if (files != null) req.files.addAll(files);

    if (kDebugMode) {
      debugPrint(
        'MULTIPART ${method.toUpperCase()} $uri\nheaders: $h\nfields: $fields\nfiles: ${files?.map((f) => f.filename).toList()}',
      );
    }

    final streamed = await req.send().timeout(timeout);
    final resp = await http.Response.fromStream(streamed);
    if (kDebugMode) {
      debugPrint('MULTIPART ${resp.statusCode} ${resp.body}');
    }
    if (throwOnError && (resp.statusCode != 200 || resp.statusCode != 201)) {
      throw HttpException(resp.statusCode, resp.body);
    }
    return resp;
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String body;

  HttpException(this.statusCode, this.body);

  @override
  String toString() => 'HttpException($statusCode): $body';
}

HttpClient client = HttpClient();
