import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/models/gallery_model/gallery_model.dart';
import 'package:simrs_mobile/models/post_model/post_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Custom extends StatefulWidget {
  const Custom({Key? key}) : super(key: key);

  @override
  CustomState createState() => CustomState();
}

class CustomState extends State<Custom> {
  // Future<List<Mitra>> postList = [];
  var postList = <PostModel>[];
  var isLoading = true;

  @override
  void initState() {
    Customs();
    // TODO: implement initState
    super.initState();

    // _getMitra();
  }

  Customs() {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.shoppingCart,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
            backgroundColor: color.AppColor.textPrimaryColor,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            title: Text("data"),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Custom',
                style: TextStyle(
                  color: color.AppColor.bluePrimaryBoxColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Image.asset(
                'img/illustration1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            ),
          )
        ],
      ),
    );
  }
}

class CustomItem extends StatelessWidget {
  final String image;
  final String? text;
  bool isPrimary;
  CustomItem({
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
