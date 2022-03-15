import 'package:cycle/services/network_helper.dart';

class RegisterUser {
  static const url = '';

  RegisterUser();

  Future<Map> registerUser(Map data) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    Map response = await networkHelper.postData(data);
    return response;
  }
}
