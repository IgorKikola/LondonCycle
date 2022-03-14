import 'dart:convert';

import 'package:cycle/config.dart';
import 'package:cycle/models/login_response_model.dart';
import 'package:cycle/models/signup_request_model.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:http/http.dart' as http;
import '../models/login_request_model.dart';
import '../models/signup_response_model.dart';

/// Used for communication with the server.
class APIService {
  static var client = http.Client();

  /// Look for an existing account in the database using the provided model.
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var response = await client.post(url,
        headers: requestHeaders, body: json.encode(model.toJson()));

    if (response.statusCode == 200) {
      // If login is successful, save user login status in the cache.
      await UserDetailsHelper.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  /// Create a new account in the database.
  static Future<SignupResponseModel> signup(SignupRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.signupAPI);
    var response = await client.post(url,
        headers: requestHeaders, body: json.encode(model.toJson()));

    return signupResponseModel(response.body);
  }

  /// Get logged in user details from the database.
  static Future<String> getUserProfile() async {
    var loginDetails = await UserDetailsHelper.loginDetails();

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
