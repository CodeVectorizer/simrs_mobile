import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/models/mitra_model/mitra_model.dart';
import 'package:simrs_mobile/models/post_model/post_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mitra extends StatefulWidget {
  const Mitra({Key? key}) : super(key: key);

  @override
  _MitraState createState() => _MitraState();
}

class _MitraState extends State<Mitra> {
  // Future<List<Mitra>> mitraList = [];
  var mitraList = <MitraModel>[];
  var isLoading = true;

  @override
  void initState() {
    _getMitras();
    // TODO: implement initState
    super.initState();

    // _getMitra();
  }

  _getMitras() {
    CallApi().getPublicData('mitra').then((response) {
      Iterable list = json.decode(response.body);
      setState(() {
        mitraList = list.map((model) => MitraModel.fromJson(model)).toList();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color.AppColor.primaryColor,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 46, left: 36, right: 36),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: color.AppColor.primaryColor,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/Home');
                      },
                      child: SizedBox(
                        width: 42,
                        height: 42,
                        child: Icon(
                          FontAwesomeIcons.bars,
                          color: color.AppColor.textPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 74,
                ),
                SizedBox(
                  child: Text(
                    "Mitra Kerja",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: color.AppColor.textPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 42,
          ),
          Expanded(
            child: Container(
              height: 400,
              padding: const EdgeInsets.only(
                top: 46,
              ),
              decoration: BoxDecoration(
                color: color.AppColor.textPrimaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(54),
                ),
              ),
              child: Stack(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    physics: BouncingScrollPhysics(),
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(mitraList.length, (index) {
                      return SpecialityItem(
                        image: mitraList[index].image.toString(),
                        text: mitraList[index].description,
                      );
                    }),
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SpecialityItem extends StatelessWidget {
  final String image;
  final String? text;
  bool isPrimary;
  SpecialityItem({
    Key? key,
    required this.image,
    required this.text,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 140,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: color.AppColor.primaryColor.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 16,
              ),
            ],
            color: isPrimary ? color.AppColor.primaryColor : Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                margin: EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text("$text",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: !isPrimary
                          ? color.AppColor.primaryColor
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
