import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:cycle/models/login_response_model.dart';
import 'package:cycle/models/update_profile_response_model.dart';
import 'package:cycle/models/user_details_response_model.dart';
import 'package:flutter/cupertino.dart';

/// This class is responsible to maintain the consistency of the cache when user logs-in, updates
/// his details or logs-out.
class UserDetailsHelper {
  /// Checks if user login details are stored in the cache.
  static Future<bool> isLoggedIn() async {
    var keyExists = await APICacheManager().isAPICacheKeyExist("auth_token");

    return keyExists;
  }

  /// Used to get user details from the cache.
  static Future<UserDetailsResponseModel?> userDetails() async {
    var isLoggedIn = await UserDetailsHelper.isLoggedIn();
    if (isLoggedIn) {
      var cacheData = await APICacheManager().getCacheData("user_details");
      return getUserDetailsResponseModel(cacheData.syncData);
    }
    return null;
  }

  /// Used to get user authentication token from the cache.
  static Future<String?> authToken() async {
    var isLoggedIn = await UserDetailsHelper.isLoggedIn();
    if (isLoggedIn) {
      var cacheData = await APICacheManager().getCacheData("auth_token");
      return jsonDecode(cacheData.syncData);
    }
    return null;
  }

  /// Used to save user details in the cache.
  static Future<void> setUserDetails(UserDetailsResponseModel model) async {
    APICacheDBModel cacheDBModel =
        APICacheDBModel(key: 'user_details', syncData: jsonEncode(model));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  /// Used to update user details in the cache.
  static Future<void> updateUserDetails(
      UpdateProfileResponseModel model) async {
    // Delete old details
    await APICacheManager().deleteCache('user_details');
    // Put new details
    Map<String, dynamic> data = {
      "first_name": model.firstName,
      "last_name": model.lastName,
      "email": model.email,
    };
    APICacheDBModel cacheDBModel =
        APICacheDBModel(key: 'user_details', syncData: jsonEncode(data));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  /// Save the authentication token received during the log in.
  static Future<void> saveAuthenticationToken(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel =
        APICacheDBModel(key: 'auth_token', syncData: jsonEncode(model.token));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  /// Used to remove user details from the cache after user log-out out of the application.
  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache('user_details');
    await APICacheManager().deleteCache('auth_token');
  }
}
