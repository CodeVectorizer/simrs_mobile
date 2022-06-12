import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/models/facility_model/facility_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Facility extends StatefulWidget {
  const Facility({Key? key}) : super(key: key);

  @override
  _FacilityState createState() => _FacilityState();
}

class _FacilityState extends State<Facility> {
  // Future<List<Mitra>> facilityList = [];
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  var facilityList = <FacilityModel>[];
  var isLoading = true;

  @override
  void initState() {
    _getMitras();
    // TODO: implement initState
    super.initState();

    // _getMitra();
  }

  _getMitras() {
    CallApi().getPublicData('facility').then((response) {
      Iterable list = json.decode(response.body);
      setState(() {
        facilityList =
            list.map((model) => FacilityModel.fromJson(model)).toList();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  width: double.maxFinite,
                  child: Text(
                    "Fasilitas Rumah Sakit",
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
              height: 200,
              decoration: BoxDecoration(
                color: color.AppColor.textPrimaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(54),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 46, left: 36, right: 36),
                child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return FacilityItem(
                        title: facilityList[index].title,
                        description: facilityList[index].description,
                        price: formatCurrency.format(facilityList[index].price),
                        image: facilityList[index].image,
                      );
                    }),
                    itemCount: facilityList.length),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FacilityItem extends StatelessWidget {
  String? price;

  String? description;

  String? title;
  String? image;

  FacilityItem({Key? key, this.title, this.price, this.image, this.description})
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
                    image: NetworkImage(image.toString()),
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
                        "$title",
                        style: TextStyle(
                            color: color.AppColor.textBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "$description",
                        style: TextStyle(
                            color: color.AppColor.secondaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // text 10 bold blue primaryColor
                      Text(
                        "Tarif: $price,-",
                        style: TextStyle(
                            color: color.AppColor.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
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
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 140,
          height: 160,
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
