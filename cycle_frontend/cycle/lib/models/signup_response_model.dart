import 'dart:convert';

SignupResponseModel signupResponseModel(String string, int statusCode) =>
    SignupResponseModel.fromJson(json.decode(string), statusCode);

class SignupResponseModel {
  late final String response;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String token;
  late final int statusCode;

  SignupResponseModel({
    required this.response,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.token,
  });

  SignupResponseModel.fromJson(Map<String, dynamic> json, this.statusCode) {
    if (statusCode == 200) {
      response = json['response'];
      firstName = json['first_name'];
      lastName = json['last_name'];
      email = json['email'];
      token = json['token'];
    } else {
      response = json['detail'];
      firstName = '';
      lastName = '';
      email = '';
      token = '';
    }
  }
}
