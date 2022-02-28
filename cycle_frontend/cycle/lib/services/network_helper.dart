import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// This class is used to handle API calls, decode JSON files and return data contained in them.
class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    // Retrieve JSON data using http GET call.
    http.Response response = await http.get(Uri.parse(url));

    // If retrieval was successful, decode data and return it.
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // print(response.statusCode);
    }
  }

  Future<Map> postData(Map data) async {
    http.Response response = await http.post(Uri.parse(url), body: data);
    var responseData = jsonDecode(response.body);

    // Returns a map that contains the status code of the POST action
    // and the message received.
    Map result = {'statusCode': responseData.statusCode, 'body': responseData};

    return result;
  }
}
