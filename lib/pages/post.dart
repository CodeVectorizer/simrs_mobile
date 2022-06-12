import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/models/gallery_model/gallery_model.dart';
import 'package:simrs_mobile/models/post_model/post_model.dart';
import 'package:simrs_mobile/pages/post_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  // Future<List<Mitra>> postList = [];
  var postList = <PostModel>[];
  var isLoading = true;

  @override
  void initState() {
    _getPosts();
    // TODO: implement initState
    super.initState();

    // _getMitra();
  }

  _getPosts() {
    CallApi().getPublicData('post').then((response) {
      Iterable list = json.decode(response.body);
      setState(() {
        postList = list.map((model) => PostModel.fromJson(model)).toList();
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
                    "Artikel",
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
              padding: const EdgeInsets.only(top: 46, left: 36, right: 36),

              // padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                color: color.AppColor.textPrimaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(54),
                ),
              ),
              child: Stack(
                children: [
                  GridView.count(
                    crossAxisCount: 1,
                    physics: BouncingScrollPhysics(),
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(postList.length, (index) {
                      // return image with caption
                      return Container(
                        // margin: EdgeInsets.only(bottom: 10),
                        height: 1000,
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    postList[index].image.toString(),
                                    // "https://cdnwpedutorenews.gramedia.net/wp-content/uploads/2022/02/28072816/5f2a5a1a66dfa.jpg"
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.maxFinite,
                              child: Text(
                                postList[index].title.toString().length < 66
                                    ? postList[index].title.toString()
                                    : postList[index]
                                            .title
                                            .toString()
                                            .substring(0, 66) +
                                        ("..."),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: color.AppColor.bluePrimaryBoxColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PostDetail(
                                                    postId: postList[index].id,
                                                  )));
                                    },
                                    style: TextButton.styleFrom(
                                      primary: color.AppColor.primaryColor,
                                      elevation: 2,
                                      shadowColor:
                                          color.AppColor.blueSecondaryBoxColor,
                                    ),
                                    child: Text(
                                      "Lihat Detail",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: color
                                              .AppColor.bluePrimaryBoxColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    )),
                              ],
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

class PostItem extends StatelessWidget {
  final String image;
  final String? text;
  bool isPrimary;
  PostItem({
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
