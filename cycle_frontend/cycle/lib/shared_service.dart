import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:cycle/models/login_response_model.dart';
import 'package:cycle/pages/login_page.dart';
import 'package:flutter/cupertino.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var keyExists = await APICacheManager().isAPICacheKeyExist("login_details");

    return keyExists;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isLoggedIn = await SharedService.isLoggedIn();
    if (isLoggedIn) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: 'login_details', syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache('login_details');
    Navigator.pushNamed(context, LoginPage.id);
  }
}
