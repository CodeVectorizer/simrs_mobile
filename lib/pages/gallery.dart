import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/models/gallery_model/gallery_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  // Future<List<Mitra>> galleryList = [];
  var galleryList = <GalleryModel>[];
  var isLoading = true;

  @override
  void initState() {
    _getGalleries();
    // TODO: implement initState
    super.initState();

    // _getMitra();
  }

  _getGalleries() {
    CallApi().getPublicData('gallery').then((response) {
      Iterable list = json.decode(response.body);
      setState(() {
        galleryList =
            list.map((model) => GalleryModel.fromJson(model)).toList();
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
                    "Galleri",
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
              padding: EdgeInsets.only(top: 40),
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
                    children: List.generate(galleryList.length, (index) {
                      // return image with caption
                      return Container(
                        height: 600,
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    galleryList[index].image.toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 140,
                              child: Text(
                                galleryList[index].description.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: color.AppColor.bluePrimaryBoxColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  isLoading
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
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
