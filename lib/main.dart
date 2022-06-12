import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simrs_mobile/models/user_model.dart';
import 'package:simrs_mobile/pages/custom.dart';
import 'package:simrs_mobile/pages/dashboard.dart';
import 'package:simrs_mobile/pages/doctor.dart';
import 'package:simrs_mobile/pages/doctor_profile.dart';
import 'package:simrs_mobile/pages/facility.dart';
import 'package:simrs_mobile/pages/gallery.dart';
import 'package:simrs_mobile/pages/home.dart';
import 'package:simrs_mobile/pages/post.dart';
import 'package:simrs_mobile/pages/mitra.dart';
import 'package:simrs_mobile/pages/post_detail.dart';
import 'package:simrs_mobile/pages/service.dart';
import 'colors.dart' as color;
import 'package:simrs_mobile/pages/login.dart';
import 'package:simrs_mobile/pages/register.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // starting point from where app should begin
      // initialRoute: '/',
      //when initial Route is given no need to add home widget for initial start point of app
      //full app route structure

      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(
            name: '/dashboard',
            page: () => Dashboard(
                  userData: UserModel(),
                )),
        GetPage(name: '/gallery', page: () => const Gallery()),
        GetPage(name: '/facility', page: () => const Facility()),
        GetPage(name: '/doctor', page: () => const Doctor()),
        GetPage(name: '/mitra', page: () => const Mitra()),
        GetPage(name: '/post', page: () => const Post()),
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Register(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const MaterialApp(
      title: "SIMRS APP",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
