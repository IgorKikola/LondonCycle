import 'dart:convert';

GetUserDetailsResponseModel getUserDetailsResponseModel(String string) =>
    GetUserDetailsResponseModel.fromJson(json.decode(string));

class GetUserDetailsResponseModel {
  late final String firstName;
  late final String lastName;
  late final String email;

  GetUserDetailsResponseModel({
    required this.firstName,
    required this.email,
    required this.lastName,
  });

  GetUserDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    return _data;
  }
}
