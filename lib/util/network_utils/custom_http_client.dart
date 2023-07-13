import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'custom_cache_handler.dart';

class CustomHttpClient {
  CustomHttpClient._privateConstructor();

  static final CustomHttpClient _instance = CustomHttpClient._privateConstructor();

  factory CustomHttpClient() {
    return _instance;
  }

  static Future<Map<String, String>> getHeaders() async {
    const token = String.fromEnvironment('authToken');
    Map<String, String> headers;
    if (token.isEmpty) {
      headers = {"Accept": "application/json", "Content-Type": "application/json"};
    } else {
      headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
    }
    return headers;
  }

  static Future<Response> getRequest(String path, {Map<String, String>? header}) async {
    Response response;
    File file = await CustomCacheHandler.instance.getSingleFile(path, headers: await getHeaders());
    if (await file.exists()) {
      var res = await file.readAsString();
      // debugPrint('from: cache');
      response = Response(res, 200);
    } else {
      response = await get(Uri.tryParse(path)!, headers: header ?? await getHeaders());
    }

    return response;
  }

  static Future<Response> postRequest({
    required String path,
    required Map body,
    Map<String, String>? header,
  }) async {
    Response response = await post(Uri.tryParse(path)!,
        body: jsonEncode(body), headers: header ?? await getHeaders());
    return response;
  }

  static Future<Response> postStringRequest({
    required String path,
    required String body,
    Map<String, String>? header,
  }) async {
    Response response = await post(Uri.tryParse(path)!,
        body: jsonEncode(body), headers: header ?? await getHeaders());

    return response;
  }

  static Future<Response> postObjectRequest({
    required String path,
    required Object body,
    Map<String, String>? header,
  }) async {
    Response response =
        await post(Uri.tryParse(path)!, body: body, headers: header ?? await getHeaders());

    return response;
  }

  static Future<Response> putRequest({
    required String path,
    required Map body,
    Map<String, String>? header,
  }) async {
    Response response = await put(Uri.tryParse(path)!,
        body: jsonEncode(body), headers: header ?? await getHeaders());

    return response;
  }

  static Future<Response> patchRequest({
    required String path,
    required Map body,
    Map<String, String>? header,
  }) async {
    Response response = await patch(Uri.tryParse(path)!,
        body: jsonEncode(body), headers: header ?? await getHeaders());

    return response;
  }

  static Future<Response> deleteRequest(String path) async {
    Response response = await delete(Uri.tryParse(path)!, headers: await getHeaders());

    return response;
  }
}
