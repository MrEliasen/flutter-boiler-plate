import 'dart:convert';

import 'package:http/http.dart';

class APIResponse {
  /// Original [response] instance
  Response _response;

  APIResponse(this._response);

  factory APIResponse.fromHttp(Response response) {
    return APIResponse(response);
  }

  /// The response status code
  int get statusCode {
    return _response.statusCode;
  }

  /// The response headers
  Map<String, String> get headers {
    return _response.headers;
  }

  /// If you expected a [List] response, return a the json parsed body as a List.
  /// This is to ensure if a response can be an empty list, it won't suddenly
  /// return a an empty map.
  List<dynamic> get bodyAsList {
    return _jsonBody as List<dynamic> ?? [];
  }

  /// If you expected a [Map] response, return a the json parsed body as a Map
  Map<String, dynamic> get bodyAsMap {
    return _jsonBody as Map<String, dynamic> ?? {};
  }

  /// json decodes the [_response.body]
  dynamic get _jsonBody {
    return jsonDecode(
      _response.body,
    );
  }
}
