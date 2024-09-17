import 'dart:convert';
import 'dart:developer';

import 'package:my_first_app/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class BaseService {

  
  Future<http.Response> getHttp(String api) async {
    final url = ApiUrls.baseUrl + api;
    log(url, name: 'getHttp');

    final response = await http.get(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
    );
    // log(response.statusCode.toString(), name: 'Status');
    // log(response.body, name: 'body');
    return response;
  }

  //POst Api
  Future<http.Response> postHttp({
    required String api,
    required Map<String, dynamic> data,
  }) async {
    final url = ApiUrls.baseUrl + api;
    log(url, name: 'postHttp');

    final body = json.encode(data);

    final response = await http.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: body,
    );

    return response;
  }

  
}
