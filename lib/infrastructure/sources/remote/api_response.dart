import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class APIResponse {
  const APIResponse(this.response);

  /// [Response] instance from the http request.
  @protected
  final Response response;

  /// The response status code
  @protected
  int get statusCode {
    if (response == null) {
      return 400;
    }

    return response.statusCode;
  }

  /// The response headers
  @protected
  Map<String, String> get headers {
    if (response == null) {
      return {};
    }

    return response.headers;
  }

  /// json decodes the [response.body]
  dynamic get body {
    if (response == null) {
      return null;
    }

    return jsonDecode(
      response.body,
    );
  }
}
