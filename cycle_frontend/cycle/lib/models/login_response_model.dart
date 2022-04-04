import 'dart:convert';

LoginResponseModel loginResponseJson(String string, int statusCode) =>
    LoginResponseModel.fromJson(json.decode(string), statusCode);

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.token,
  });
  late final String message;
  late final String token;
  late final int statusCode;

  LoginResponseModel.fromJson(Map<String, dynamic> json, this.statusCode) {
    if (statusCode == 200) {
      token = json['token'];
      message = 'Token was received successfully';
    } else {
      if (json['non_field_errors'][0] != null) {
        message = json['non_field_errors'][0];
      } else {
        message = '';
      }
      token = '';
    }
  }
}
