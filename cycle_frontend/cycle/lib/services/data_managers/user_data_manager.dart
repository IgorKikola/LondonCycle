import 'dart:convert';

import 'package:cycle/config.dart';
import 'package:cycle/models/update_profile_request_model.dart';
import 'package:cycle/models/update_profile_response_model.dart';
import 'package:cycle/models/user_details_response_model.dart';
import 'package:cycle/models/login_response_model.dart';
import 'package:cycle/models/signup_request_model.dart';
import 'package:cycle/services/network_helper.dart';
import 'package:cycle/services/user_details_helper.dart';
import '../../models/login_request_model.dart';
import '../../models/signup_response_model.dart';

/// Used for communication with the server.
class APIService {
  /// Look for an existing account in the database using the provided model.
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var response = await NetworkHelper.httpPost(
      domain: Config.localhostURL,
      path: Config.loginPath,
      body: json.encode(model.toJson()),
      headers: requestHeaders,
    );

    if (response!.statusCode == 200) {
      // If login is successful, save user login status in the cache.
      await UserDetailsHelper.saveAuthenticationToken(
          loginResponseJson(response.body, response.statusCode));
      await APIService.getUserProfile();
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

    var response = await NetworkHelper.httpPost(
      domain: Config.localhostURL,
      path: Config.signupPath,
      body: json.encode(model.toJson()),
      headers: requestHeaders,
    );
    return signupResponseModel(response!.body, response.statusCode);
  }

  /// Update user details in the database.
  static Future<UpdateProfileResponseModel> updateProfile(
      UpdateProfileRequestModel model) async {
    var token = await UserDetailsHelper.authToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token'
    };

    var response = await NetworkHelper.httpPut(
      domain: Config.localhostURL,
      path: Config.updateUserProfilePath,
      body: json.encode(model.toJson()),
      headers: requestHeaders,
    );
    return updateProfileResponseModel(response!.body, response.statusCode);
  }

  /// Get logged in user details from the database.
  static Future<void> getUserProfile() async {
    var token = await UserDetailsHelper.authToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token'
    };

    var response = await NetworkHelper.httpGet(
      domain: Config.localhostURL,
      path: Config.getUserProfilePath,
      headers: requestHeaders,
    );

    if (response!.statusCode == 200) {
      await UserDetailsHelper.setUserDetails(
          getUserDetailsResponseModel(response.body));
    }
  }
}
