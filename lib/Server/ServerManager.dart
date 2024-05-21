import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:listenbox/Server/DataResponse.dart';
import 'package:listenbox/models/BaseModel.dart';
import 'package:http/http.dart' as http;

class ServerManager<T extends BaseModel> {
  String baseURL = "https://api.deezer.com";
  // ServerManager() {}

  final headers = {
    "content-type": "application/json",
    'accept': 'application/json',
    'connection': 'keep-alive',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'GET,POST',
    // "MaxRequestBodySize": "Always",
    // "Keep-Alive": "timeout=5, max=1000",
  };

  Future<DataResponse<T>> getApiRequestDataResponse<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    // String? token = '',
  }) async {
    http.Response? response;

    final uri = Uri(
      scheme: Uri.parse(baseURL).scheme,
      host: Uri.parse(baseURL).host,
      port: Uri.parse(baseURL).port,
      path: Uri.parse(baseURL).path + endPoint,
      queryParameters: params != null
          ? params.map((key, value) => MapEntry(key, value.toString()))
          : params,
    );
    if (kDebugMode) {
      print('Api URL: ' + uri.toString());
    }

    if (kDebugMode) {
      print('Query String: ' + json.encode(headers));
    }
    try {
      String? jsonBody;
      if (body != null) {
        jsonBody = json.encode(body);
      } else {
        jsonBody = json.encode("{}");
      }
      response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode != 200) {
        // throw getInternalException(response.statusCode);
      }

      final data = DataResponse<T>.fromJSON(response, fromJson);

      return data;
    } on Exception catch (e) {
      // Constants.hasLoadingButton.value = false;
      // await BasicHelpers().reportCrash(e);
      // if (isInternalException) {
      //   isInternalException = false;
      //   return Future.error(Exception(e.toString()));
      // }
      var ex = Exception('Hata oluştu. Tekrar deneyiniz.');
      return Future.error(ex);
    }
  }
}
