import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/models/doctor_model/doctor_model.dart';
import 'package:simrs_mobile/models/gallery_model/gallery_model.dart';
import 'package:simrs_mobile/models/post_model/post_model.dart';
import 'package:simrs_mobile/pages/doctor.dart';
import 'package:simrs_mobile/pages/post_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  // Future<List<Mitra>> doctorData = [];
  DoctorModel doctorData = DoctorModel();
  var isLoading = true;

  @override
  void initState() {
    _getDoctorProfiles();
    // TODO: implement initState
    super.initState();

    // _getMitra();
  }

  _getDoctorProfiles() {
    CallApi().getPublicData('doctor/8').then((response) {
      // Iterable list = json.decode(response.body);

      setState(() {
        // doctorData = list.map((model) => DoctorModel.fromJson(model)).toList();
        doctorData = DoctorModel.fromJson(json.decode(response.body));
        // print(doctorData);
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
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    width: double.maxFinite,
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          // image container with corner radius
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: color.AppColor.textBlackColor
                                      .withOpacity(0.15),
                                  blurRadius: 22,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image:
                                    NetworkImage(doctorData.avatar.toString()),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    doctorData.name ?? '',
                                    style: TextStyle(
                                        color: color.AppColor.textBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    doctorData.speciality?.speciality ?? '',
                                    style: TextStyle(
                                        color: color.AppColor.secondaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // icon rating with text
                                      Icon(
                                        FontAwesomeIcons.solidStar,
                                        color:
                                            color.AppColor.yellowPrimaryColor,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        doctorData.wednesday.toString(),
                                        style: TextStyle(
                                            color:
                                                color.AppColor.secondaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        doctorData.monday.toString(),
                                        style: TextStyle(
                                            color:
                                                color.AppColor.secondaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          // container white with border radius and shadow
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            Container(
              padding: const EdgeInsets.only(top: 46, left: 36, right: 36),

              // padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                color: color.AppColor.textPrimaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(54),
                ),
              ),
              child: Container(
                width: double.maxFinite,
                height: 200,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: color.AppColor.textBlackColor.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biografi',
                      style: TextStyle(
                          color: color.AppColor.textBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      doctorData.description.toString(),
                      style: TextStyle(
                          color: color.AppColor.secondaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorProfileItem extends StatelessWidget {
  final String image;
  final String? text;
  bool isPrimary;
  DoctorProfileItem({
    Key? key,
    required this.image,
    required this.text,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 200,
        height: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: color.AppColor.primaryColor.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 16,
              ),
            ],
            color: !isPrimary ? color.AppColor.primaryColor : Colors.white),
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
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "asdfsadfkjsdhfkjsadfkljhsad sadflkasjdfksjdf asdfsadfkjsdhfkjsadfkljhsad sadflkasjdfksjdf asdfsadfkjsdhfkjsadfkljhsad sadflkasjdfksjdf asdfsadfkjsdhfkjsadfkljhsad sadflkasjdfksjdf",
              style: TextStyle(
                  color: isPrimary ? color.AppColor.primaryColor : Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
