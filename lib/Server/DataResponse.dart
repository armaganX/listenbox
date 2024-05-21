import 'dart:convert';

import 'package:http/http.dart';

class DataResponse<T> {
  DataResponse({
    required this.headers,
    required this.statusCode,
    // required this.islemSonucu,
    required this.data,
    // this.mesajlar,
  });

  factory DataResponse.fromJSON(
    Response response,
    Function create,
  ) {
    Map<String, dynamic> json = jsonDecode(response.body);

    return DataResponse<T>(
        headers: response.headers,
        statusCode: response.statusCode,
        // islemSonucu: getIslemSonucuWithId(json["islemDurumu"]),
        // mesajlar: json["mesajlar"],
        // data: create(json["data"]),
        data: create(json));
  }
  Map<String, String> headers;
  int statusCode;
  // IslemSonucu islemSonucu;
  // List<dynamic>? mesajlar;
  T? data;
}
