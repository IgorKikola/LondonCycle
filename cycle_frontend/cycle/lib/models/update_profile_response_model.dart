import 'dart:convert';

UpdateProfileResponseModel updateProfileResponseModel(
        String string, int statusCode) =>
    UpdateProfileResponseModel.fromJson(json.decode(string), statusCode);

class UpdateProfileResponseModel {
  late final String response;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final int statusCode;

  UpdateProfileResponseModel({
    required this.response,
    required this.firstName,
    required this.email,
    required this.lastName,
  });

  UpdateProfileResponseModel.fromJson(
      Map<String, dynamic> json, this.statusCode) {
    if (statusCode == 200) {
      response = json['response'];
      firstName = json['first_name'];
      lastName = json['last_name'];
      email = json['email'];
    } else {
      response = json['detail']['email'][0];
      firstName = '';
      lastName = '';
      email = '';
    }
  }
}
