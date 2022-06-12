import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/models/doctor_model/doctor_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/CallApi.dart';

class Doctor extends StatefulWidget {
  const Doctor({Key? key}) : super(key: key);

  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  var doctorList = <DoctorModel>[];
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDoctors();
  }

  _getDoctors() {
    CallApi().getPublicData('doctor').then((response) {
      Iterable list = json.decode(response.body);
      setState(() {
        doctorList = list.map((model) => DoctorModel.fromJson(model)).toList();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Column(
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
                          Navigator.pop(context);
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
                  Row(
                    children: [
                      Text(
                        "Top Doctor",
                        style: TextStyle(
                            color: color.AppColor.textPrimaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Icon(
                        FontAwesomeIcons.star,
                        color: color.AppColor.yellowPrimaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            Container(
              decoration: BoxDecoration(
                color: color.AppColor.textPrimaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(54),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 46, left: 36, right: 36),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Categories / ",
                              style: TextStyle(
                                  color: color.AppColor.textBlackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            Text(
                              "Spesialis",
                              style: TextStyle(
                                  color: color.AppColor.textBlackColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/DoctorList');
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                                color: color.AppColor.textBlackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SpecialityItem(
                            icon: FontAwesomeIcons.brain,
                          ),
                          SpecialityItem(
                            icon: FontAwesomeIcons.bone,
                          ),
                          SpecialityItem(
                            icon: FontAwesomeIcons.solidHeart,
                            isPrimary: true,
                          ),
                          SpecialityItem(
                            icon: FontAwesomeIcons.child,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: doctorList.length,
                            itemBuilder: (context, index) {
                              print(doctorList[index].avatar.toString());
                              return DoctorItem(
                                image: doctorList[index].avatar.toString(),
                                name: doctorList[index].name,
                                speciality:
                                    doctorList[index].speciality?.speciality,
                                schedule: doctorList[index].monday,
                              );
                            },
                          ),
                          isLoading
                              ? Container(
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                  ],
                                ))
                              : Container()
                        ],
                      ),
                    ),
                    // DoctorItem(
                    //   name: doctorList[0].name,
                    //   speciality: doctorList[0].speciality?.speciality,
                    //   rating: "4.5",
                    //   schedule: "08.00 - 17.00",
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DoctorItem extends StatelessWidget {
  String? schedule;

  String? rating;

  String? speciality;

  String? name;
  final String image;

  DoctorItem(
      {Key? key,
      this.name,
      this.rating,
      required this.image,
      this.schedule,
      this.speciality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              color: color.AppColor.textBlackColor.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              // image container with corner radius
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: color.AppColor.textBlackColor.withOpacity(0.15),
                      blurRadius: 22,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$name",
                        style: TextStyle(
                            color: color.AppColor.textBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "$speciality",
                        style: TextStyle(
                            color: color.AppColor.secondaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              // icon rating with text
                              Icon(
                                FontAwesomeIcons.solidStar,
                                color: color.AppColor.yellowPrimaryColor,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "$rating",
                                style: TextStyle(
                                    color: color.AppColor.secondaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [
                              // clock icon with text
                              const Icon(
                                FontAwesomeIcons.solidClock,
                                color: const Color(0xFFFF4343),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "$schedule",
                                style: TextStyle(
                                    color: color.AppColor.secondaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class SpecialityItem extends StatelessWidget {
  final IconData? icon;
  bool isPrimary;
  SpecialityItem({
    Key? key,
    required this.icon,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 92,
          height: 92,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: !isPrimary ? color.AppColor.primaryColor : Colors.white,
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
