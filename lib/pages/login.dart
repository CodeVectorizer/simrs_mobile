import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/models/user_model.dart';
import 'package:simrs_mobile/pages/dashboard.dart';
import 'package:simrs_mobile/pages/home.dart';
import 'package:simrs_mobile/pages/register.dart';
import 'package:simrs_mobile/widgets/button_primary.dart';
import 'package:simrs_mobile/widgets/textfield_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _login() {
    var data = {
      'email': _usernameController.text,
      'password': _passwordController.text,
    };

    // Navigator.pushReplacementNamed(context, '/dashboard');

    CallApi().postData(data, "login").then((response) async {
      var jsonData = json.decode(response.body);

      if (jsonData['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', jsonData['token']);
        UserModel user = UserModel.fromJson(jsonData['user']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(userData: user),
          ),
        );
      } else {
        print(jsonData['message']);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.primaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 116),
                width: 206,
                height: 214,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('img/illustration1.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 54,
              ),
              // make textfield with icon bg white
              TextFieldPrimary(
                  controller: _usernameController,
                  text: "Username",
                  icon: Icons.highlight_remove_rounded),
              const SizedBox(
                height: 20,
              ),
              TextFieldPrimary(
                  controller: _passwordController,
                  text: "Password",
                  icon: Icons.remove_red_eye_outlined,
                  obscureText: true),
              SizedBox(height: 56),
              ButtonPrimary(text: "Log In", onTap: _login),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: color.AppColor.textPrimaryColor),
                  ),
                  SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: Text(
                      "Sign up here",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: color.AppColor.textPrimaryColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
