import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// This class is used to handle API calls, decode JSON files and return data contained in them.
class NetworkHelper {
  static var client = http.Client();

  static Future<http.Response>? get(
      {required String domain, required String path}) async {
    var url = Uri.https(domain, path);
    return await client.get(url);
  }

  static Future<List<dynamic>> getJsonList(
      {required String domain, required String path}) async {
    var response = (await get(
      domain: domain,
      path: path,
    ));
    if (response!.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data == null) {
        return List.empty();
      }
      return data['results'] as List;
    }
    return List.empty();
  }

  // HTTP METHODS FOR TESTING PURPOSES. USED WITH THE LOCALHOST CALLS

  static Future<http.Response>? httpGet(
      {required String domain, required String path, required headers}) async {
    var url = Uri.http(domain, path);
    return await client.get(url, headers: headers);
  }

  static Future<http.Response>? httpPost(
      {required String domain,
      required String path,
      required body,
      required headers}) async {
    var url = Uri.http(domain, path);
    return await client.post(url, headers: headers, body: body);
  }

  static Future<http.Response>? httpPut(
      {required String domain,
      required String path,
      required body,
      required headers}) async {
    var url = Uri.http(domain, path);
    return await client.put(url, headers: headers, body: body);
  }
}
