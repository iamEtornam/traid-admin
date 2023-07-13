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
    const token = 'eyJraWQiOiJRUEJmMFlybEl5ZnhzY29WZmRTSjR6bFdncnhwT3h0d3I2UFc0S1BTSFFFPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiIzYzRiODI3NC1jYzc3LTRhYWMtOGU4MC0wYzQ1MGI4M2QyMDkiLCJkZXZpY2Vfa2V5IjoiZXUtd2VzdC0xX2QxODE2MWY4LWM1YTQtNDNkMi05YjE1LTk2NzU5NmI3NTQyNyIsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5ldS13ZXN0LTEuYW1hem9uYXdzLmNvbVwvZXUtd2VzdC0xX0xlUW1kWmZiMCIsImNsaWVudF9pZCI6IjJlNGhpcWNmNHM4M3VrNjNpc2VtOWU2aWw0Iiwib3JpZ2luX2p0aSI6IjJkYjUxN2M2LTIzMzgtNDkxMi1hMjcxLTA2N2VkNDNiN2VkYiIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE2ODkyNTIxMzgsImV4cCI6MTY4OTMzODUzOCwiaWF0IjoxNjg5MjUyMTM4LCJqdGkiOiIzZjI1YzgwYi1lM2MzLTQ3YWYtYjkzNC1lNzIyNjg5YzQ0ZGMiLCJ1c2VybmFtZSI6IjNjNGI4Mjc0LWNjNzctNGFhYy04ZTgwLTBjNDUwYjgzZDIwOSJ9.QnlOiRoKgPxWq5pepMGbaSEHwH_fPG7podfUreWNjVZR5XrdOdm37IJr8_wNeVZexnu-ZSz3Z7sbDEIBOWIO8N2uN1I8xkLdAPBbN2Vp1L7XyJ5ZM_tVa7j4KoHIYMne1NBbwp501MKuxh4d5thmFbwOzHJ8L1btL-hjPmM4C8ey74Rot-H4KVA_lWxDDSmA8ers8ntCH-7kp_6QJnDM7f7mTsyhB2uksHXyhk8Ofw-Lb0N-DIACbXvZWmvGpw6TbfGfv7Bah3F6_-8OeBT0bjCSQreBjgwOenGo0pd-jWcwPKmtWcmmKIh370xJLrq2KvzUFAv9qkrfb9pG3G9UxA';
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
