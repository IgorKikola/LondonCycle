import 'dart:convert';

import 'package:cycle/config.dart';
import 'package:cycle/models/get_user_details_response_model.dart';
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
      await UserDetailsHelper.saveAuthenticationToken(
          loginResponseJson(response.body, response.statusCode));
      await getUserProfile();
      print("aaa");
      return true;
    } else {
      print(response.body);
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
    return signupResponseModel(response.body, response.statusCode);
  }

  /// Get logged in user details from the database.
  static Future<void> getUserProfile() async {
    var token = await UserDetailsHelper.authToken();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token'
    };

    var url = Uri.http(Config.apiURL, Config.getUserProfileAPI);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      await UserDetailsHelper.setLoginDetails(
          getUserDetailsResponseModel(response.body));
    }
  }
}
