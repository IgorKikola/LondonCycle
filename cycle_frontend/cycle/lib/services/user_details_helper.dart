import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:cycle/models/get_user_details_response_model.dart';
import 'package:cycle/models/login_response_model.dart';
import 'package:cycle/pages/signup_login_pages/signup_page.dart';
import 'package:flutter/cupertino.dart';

/// This class is responsible to maintain the consistency of the cache when user logs-in, updates
/// his details or logs-out.
class UserDetailsHelper {
  /// Checks if user login details are stored in the cache.
  static Future<bool> isLoggedIn() async {
    var keyExists = await APICacheManager().isAPICacheKeyExist("login_details");

    return keyExists;
  }

  /// Used to get user details from the cache.
  static Future<GetUserDetailsResponseModel?> loginDetails() async {
    var isLoggedIn = await UserDetailsHelper.isLoggedIn();
    if (isLoggedIn) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      return getUserDetailsResponseModel(cacheData.syncData);
    }
    return null;
  }

  /// Used to get user authentication token from the cache.
  static Future<String?> authToken() async {
    var isLoggedIn = await UserDetailsHelper.isLoggedIn();
    if (isLoggedIn) {
      var cacheData = await APICacheManager().getCacheData("auth_token");
      return cacheData.syncData;
    }
    return null;
  }

  /// Used to save user details in the cache.
  static Future<void> setLoginDetails(GetUserDetailsResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: 'login_details', syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> saveAuthenticationToken(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel =
        APICacheDBModel(key: 'auth_token', syncData: jsonEncode(model.token));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  /// Used to remove user details from the cache after user log-out out of the application.
  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache('login_details');
    await APICacheManager().deleteCache('auth_token');
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
