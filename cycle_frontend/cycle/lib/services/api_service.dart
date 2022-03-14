import 'dart:convert';

import 'package:cycle/config.dart';
import 'package:cycle/models/login_response_model.dart';
import 'package:cycle/models/signup_request_model.dart';
import 'package:cycle/shared_service.dart';
import 'package:http/http.dart' as http;
import '../models/login_request_model.dart';
import '../models/signup_response_model.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var response = await client.post(url,
        headers: requestHeaders, body: json.encode(model.toJson()));

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<SignupResponseModel> signup(SignupRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.signupAPI);
    var response = await client.post(url,
        headers: requestHeaders, body: json.encode(model.toJson()));

    return signupResponseModel(response.body);
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(Config.apiURL, Config.userProfileAPI);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }
}
