import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginPageModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    //https://e-commerce-node-deploy.herokuapp.com/api/auth/login

    var url =
        Uri.https("e-commerce-node-deploy.herokuapp.com", "/api/auth/login");

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      //SHARED

      return true;
    } else {
      return false;
    }
  }
}

class LoginPageModel {
  LoginPageModel({
    required this.email,
    required this.password,
  });
  late final String email;
  late final String password;

  LoginPageModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}
