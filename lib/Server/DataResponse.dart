import 'dart:convert';

import 'package:http/http.dart';

class DataResponse<T> {
  DataResponse({
    required this.headers,
    required this.statusCode,
    required this.data,
  });

  factory DataResponse.fromJSON(
    Response response,
    Function create,
  ) {
    Map<String, dynamic> json = jsonDecode(response.body);

    return DataResponse<T>(
        headers: response.headers,
        statusCode: response.statusCode,
        data: create(json));
  }
  Map<String, String> headers;
  int statusCode;

  T? data;
}
