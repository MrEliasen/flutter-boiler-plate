import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_boilerplate/core/app_error_handler.dart';
import 'package:flutter_app_boilerplate/core/app_settings.dart';
import 'package:flutter_app_boilerplate/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class APIController {
  final log = Logger('API');

  /// The driver authToken
  String authToken;

  /// Keep the same instance alive
  static APIController _instance;
  factory APIController() => _instance ??= APIController._();
  APIController._();

  /// Make POST
  Future<APIResponse> post(
    String endpoint, {
    Map body,
    Map<String, String> headers,
    String url,
  }) {
    return _call(
      'POST',
      endpoint,
      body: body,
      headers: headers,
      url: url,
    );
  }

  /// Make PATCH
  Future<APIResponse> patch(
    String endpoint, {
    Map body,
    Map<String, String> headers,
    String url,
  }) {
    return _call(
      'PATCH',
      endpoint,
      body: body,
      headers: headers,
      url: url,
    );
  }

  /// Make PUT
  Future<APIResponse> put(
    String endpoint, {
    Map body,
    Map<String, String> headers,
    String url,
  }) {
    return _call(
      'PUT',
      endpoint,
      body: body,
      headers: headers,
      url: url,
    );
  }

  /// Make GET
  Future<APIResponse> get(
    String endpoint, {
    Map<String, String> headers,
    String url,
  }) {
    return _call(
      'GET',
      endpoint,
      headers: headers,
      url: url,
    );
  }

  /// Make GET
  Future<APIResponse> delete(
    String endpoint, {
    Map body,
    Map<String, String> headers,
    String url,
  }) {
    return _call(
      'DELETE',
      endpoint,
      body: body,
      headers: headers,
      url: url,
    );
  }

  /// Make Multipart (file upload)
  Future<APIResponse> multipart(
    String endpoint, {
    Map body,
    Map<String, File> files,
    Map<String, String> headers,
    String url,
  }) {
    return _call(
      'multipart',
      endpoint,
      headers: headers,
      url: url,
      body: body,
      files: files,
    );
  }

  /// Make API call
  Future<APIResponse> _call(
    String method,
    String endpoint, {
    Map<String, String> headers,
    Map body,
    Map<String, File> files,
    String url,
  }) async {
    try {
      String requestEndpoint = endpoint;

      /// add a forward-slash to the request-endpoint, but only if the
      /// apiBaseUrl does not end with one.
      if (!AppSettings.apiBaseUrl.endsWith('/') &&
          !requestEndpoint.startsWith('/')) {
        requestEndpoint = "/$endpoint";
      }

      final DateTime now = DateTime.now();
      final String requestUrl =
          url ?? '${AppSettings.apiBaseUrl}$requestEndpoint';
      final Map<String, String> requestHeaders = {
        "content-type": "application/json",
      };
      String requestBody;
      http.Response response;

      // merge additional headers if found
      if (headers != null) {
        requestHeaders.addAll(headers);
      }

      if (authToken != null) {
        requestHeaders['authToken'] = authToken;
      }

      if (body != null) {
        requestBody = json.encode(body);
      }

      log.log(Level.INFO, '''
      
  --------- API REQUEST ---------
  Call ID: ${now.millisecondsSinceEpoch}
  Method: $method
  URL: $requestUrl
  Headers: ${requestHeaders.toString()}
  Body: $requestBody
  --------------------------------''');

      switch (method.toLowerCase()) {
        case 'get':
          response = await http.get(requestUrl, headers: requestHeaders);
          break;
        case 'post':
          response = await http.post(requestUrl,
              headers: requestHeaders, body: requestBody);
          break;
        case 'patch':
          response = await http.patch(requestUrl,
              headers: requestHeaders, body: requestBody);
          break;
        case 'put':
          response = await http.put(requestUrl,
              headers: requestHeaders, body: requestBody);
          break;
        case 'delete':
          response = await http.delete(requestUrl, headers: requestHeaders);
          break;
        case 'multipart':
          final request = http.MultipartRequest('POST', Uri.parse(requestUrl));

          /// add headers
          request.headers.addAll(requestHeaders);

          /// add form body
          if (body != null) {
            body.forEach((key, value) {
              request.fields[key as String] = value as String;
            });
          }

          /// add file(s)
          for (final String fieldName in files.keys) {
            request.files.add(
              await http.MultipartFile.fromPath(
                fieldName,
                files[fieldName].path,
              ),
            );
          }

          /// setup listener for when its done transmitting.
          response = await http.Response.fromStream(await request.send());
          break;
      }

      log.log(Level.INFO, '''
      
  --------- API RESPONSE ---------
  Call ID: ${now.millisecondsSinceEpoch}
  Status Code: ${response.statusCode}
  Response Headers: ${response.headers}
  Response Body: ${response.body}
  --------------------------------''');

      return APIResponse.fromHttp(response);
    } catch (error, stacktrace) {
      AppErrorHandler().logException(error, stacktrace);
      return null;
    }
  }
}
