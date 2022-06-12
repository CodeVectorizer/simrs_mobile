import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/widgets/button_primary.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                width: 206,
                height: 214,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('img/illustration1.png'),
                  ),
                ),
              ),
              const SizedBox(height: 76),
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: color.AppColor.textPrimaryColor),
              ),
              const SizedBox(height: 2),
              Text(
                "Read without limits",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: color.AppColor.textPrimaryColor),
              ),
              const SizedBox(
                height: 54,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color.AppColor.textPrimaryColor,
                  ),
                  child: Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: color.AppColor.textSecondaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color.AppColor.textPrimaryColor.withOpacity(0),
                    border: Border.all(
                      color: color.AppColor.textPrimaryColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Log In as Guest",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: color.AppColor.textPrimaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
