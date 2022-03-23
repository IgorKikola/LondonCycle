import 'dart:convert';

UserDetailsResponseModel getUserDetailsResponseModel(String string) =>
    UserDetailsResponseModel.fromJson(json.decode(string));

class UserDetailsResponseModel {
  late final String firstName;
  late final String lastName;
  late final String email;

  UserDetailsResponseModel({
    required this.firstName,
    required this.email,
    required this.lastName,
  });

  UserDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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
