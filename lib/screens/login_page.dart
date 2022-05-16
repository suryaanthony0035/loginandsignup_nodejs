import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginandsignup_nodejs/rest/login.dart';
import 'package:loginandsignup_nodejs/screens/home_page.dart';
import 'package:loginandsignup_nodejs/widget/form_field_widget.dart';
import 'package:loginandsignup_nodejs/rest/rest_api.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  get child => null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Material(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.grey, Colors.black87],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.repeated,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(50),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //here  we add form field if we  have many field for that we create
                        // a custom dart file for all field
                        FormFields(
                          controller: _emailController,
                          data: Icons.email,
                          txtHint: 'email',
                          obsecure: false,
                        ),
                        FormFields(
                          controller: _passwordController,
                          data: Icons.lock,
                          txtHint: 'Password',
                          obsecure: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forget password",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // print('click on login button');
                          // _emailController.text.isNotEmpty &&
                          //         _passwordController.text.isNotEmpty
                          //     ? doLogin(_emailController.text,
                          //         _passwordController.text)
                          //     : Fluttertoast.showToast(
                          //         msg: 'All field are required',
                          //         textColor: Colors.red);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => HomePage()));
                          LoginPageModel model = LoginPageModel(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          APIService.login(model).then((response) {
                            if (response) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false);
                            } else {
                              print('UserName and Password is incorrect');
                              Fluttertoast.showToast(
                                  msg: 'Email and password  not vaild ? ',
                                  textColor: Colors.red);
                            }
                          });
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  doLogin(String email, String password) async {
    var res = await userLogin(email.trim(), password.trim());
    // print(res.toString());

    if (res == null?['AcessToken']['ID']) {
      Fluttertoast.showToast(
          msg: 'Email and password  not vaild ? ', textColor: Colors.red);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }

    // res == null?['AcessToken']['ID']
    //     ? Fluttertoast.showToast(
    //         msg: 'Email and password  not vaild ? ', textColor: Colors.red)
    //     : Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => const HomePage()));

    // if (res == null) {
    //   // Route route = MaterialPageRoute(builder: (_) => HomePage());
    //   // Navigator.pushReplacement(context, route);
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const HomePage()));
    // } else {
    //   Fluttertoast.showToast(
    //       msg: 'Email and password  not vaild ? ', textColor: Colors.red);
    // }
  }
}
