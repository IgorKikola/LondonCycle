class SignupRequestModel {
  SignupRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String password;

  SignupRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['password'] = password;
    return _data;
  }
}
