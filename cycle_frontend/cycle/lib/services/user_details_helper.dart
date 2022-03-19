import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:cycle/models/get_user_details_response_model.dart';
import 'package:cycle/models/login_response_model.dart';
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
  static Future<GetUserDetailsResponseModel?> userDetails() async {
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
  static Future<void> setUserDetails(GetUserDetailsResponseModel model) async {
    APICacheDBModel cacheDBModel =
        APICacheDBModel(key: 'user_details', syncData: jsonEncode(model));
    await APICacheManager().addCacheData(cacheDBModel);
  }

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
