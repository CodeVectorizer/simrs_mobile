import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/pages/home.dart';
import 'package:simrs_mobile/pages/login.dart';
import 'package:simrs_mobile/widgets/button_primary.dart';
import 'package:simrs_mobile/widgets/textfield_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import 'dashboard.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _register() {
    var data = {
      'name': _nameController.text,
      'username': _usernameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    CallApi().postData(data, "register").then((response) async {
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
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 116),
                width: 146,
                height: 152,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('img/illustration1.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              // make textfield with icon bg white
              TextFieldPrimary(
                controller: _nameController,
                text: "Name",
                icon: Icons.highlight_remove_rounded,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldPrimary(
                controller: _usernameController,
                text: "Username",
                icon: Icons.remove_red_eye_outlined,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldPrimary(
                controller: _emailController,
                text: "Email",
                icon: Icons.highlight_remove_rounded,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldPrimary(
                controller: _passwordController,
                text: "Password",
                icon: Icons.remove_red_eye_outlined,
                obscureText: true,
              ),
              SizedBox(height: 56),
              ButtonPrimary(
                text: "Create Account",
                onTap: _register,
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: color.AppColor.textPrimaryColor),
                  ),
                  SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      "Log in here",
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
