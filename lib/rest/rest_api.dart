import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loginandsignup_nodejs/constant/utils.dart';
import 'package:loginandsignup_nodejs/rest/rest_api.dart';

Future userLogin(String email, String password) async {
  try {
    final response = await http.post(Uri.parse('${Utils.baseUrl}'),
        headers: {"Accept": "application/json"},
        body: json.encode({"email": email, "password": password}));
    print('result : ${response.body}');
    // print(
    //     'access token is -> ${json.decode(response.body)['payload']['AcessToken']}');

    // var _body = {'email': email, 'password': password};
    // print(_body);

    //this is our request now we store it in a varible and convert in json

    // var res = await CallApi().postData(response, 'login');
    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}
