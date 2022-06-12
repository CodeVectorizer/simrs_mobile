import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/config/CallApi.dart';
import 'package:simrs_mobile/models/gallery_model/gallery_model.dart';
import 'package:simrs_mobile/models/post_model/post_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostDetail extends StatefulWidget {
  final int? postId;
  const PostDetail({Key? key, this.postId}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  // Future<List<Mitra>> postList = [];
  var postData = PostModel();
  var isLoading = true;

  @override
  void initState() {
    _getPostDetails(widget.postId);
    // TODO: implement initState
    super.initState();

    // _getMitra();
  }

  _getPostDetails(id) {
    CallApi().getPublicData('post/$id').then((response) {
      // Iterable list = json.decode(response.body);
      // print(json.decode(response.body));
      setState(() {
        postData = PostModel.fromJson(json.decode(response.body));
        // postList = list.map((model) => PostModel.fromJson(model)).toList();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(postData.image.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Container(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: color.AppColor.textPrimaryColor,
                  ),
                ),
              ),
            ),
            backgroundColor:
                color.AppColor.bluePrimaryBoxColor.withOpacity(0.5),
            expandedHeight: 200.0,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                postData.image == null
                    ? "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif"
                    : postData.image.toString(),
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, constraints) {
              print(postData.image.toString());
              return postData.title != null
                  ? Container(
                      padding: EdgeInsets.all(16),
                      color: color.AppColor.textPrimaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            postData.title.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: color.AppColor.bluePrimaryBoxColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   postData.content.toString(),
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //       color: color.AppColor.bluePrimaryBoxColor),
                          // ),
                          Html(
                              data: postData.content.toString(),
                              onLinkTap: (String? url,
                                  RenderContext context,
                                  Map<String, String> attributes,
                                  dom.Element? element) {
                                //open URL in webview, or launch URL in browser, or any other logic here
                              }),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    );
            }),
          )
        ],
      ),
    );
  }
}
//   body: Column(
//     // crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(top: 46, left: 36, right: 36),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Icon(
//                       FontAwesomeIcons.arrowLeft,
//                       color: color.AppColor.primaryColor,
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/Home');
//                   },
//                   child: SizedBox(
//                     width: 42,
//                     height: 42,
//                     child: Icon(
//                       FontAwesomeIcons.bars,
//                       color: color.AppColor.textPrimaryColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 74,
//             ),
//             SizedBox(
//               child: Text(
//                 "Artikel",
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                     color: color.AppColor.textPrimaryColor,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 30),
//               ),
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(
//         height: 42,
//       ),
//       Expanded(
//         child: Container(
//           padding: const EdgeInsets.only(top: 46, left: 36, right: 36),

//           // padding: EdgeInsets.only(top: 40),
//           decoration: BoxDecoration(
//             color: color.AppColor.textPrimaryColor,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(54),
//             ),
//           ),
//           child: Stack(
//             children: [
//               GridView.count(
//                 crossAxisCount: 1,
//                 physics: BouncingScrollPhysics(),
//                 // Generate 100 widgets that display their index in the List.
//                 children: List.generate(postList.length, (index) {
//                   // return image with caption
//                   return Container(
//                     height: 600,
//                     width: double.maxFinite,
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 120,
//                           width: 140,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                               image: NetworkImage(
//                                 postList[index].image.toString(),
//                               ),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: 140,
//                           child: Text(
//                             postList[index].title.toString(),
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: color.AppColor.bluePrimaryBoxColor,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 12),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             TextButton(
//                                 onPressed: () {},
//                                 child: Text(
//                                   "Lihat Detail",
//                                   textAlign: TextAlign.end,
//                                   style: TextStyle(
//                                       color: color
//                                           .AppColor.bluePrimaryBoxColor,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 12),
//                                 )),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//               isLoading
//                   ? Container(
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     )
//                   : Container(),
//             ],
//           ),
//         ),
//       )
//     ],
//   ),
// );
