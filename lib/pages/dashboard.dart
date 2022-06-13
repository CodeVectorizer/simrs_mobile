import 'package:flutter/material.dart';
import 'package:simrs_mobile/colors.dart' as color;
import 'package:simrs_mobile/models/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  final UserModel userData;
  const Dashboard({Key? key, required this.userData}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userData.name);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('img/bg_dashboard.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 46, bottom: 46, left: 36, right: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // avatar image widget
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                image: const DecorationImage(
                                    image: AssetImage('img/luffy.jpeg'),
                                    fit: BoxFit.cover),
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
                                  color: color.AppColor.textBlackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 74,
                        ),
                        Text(
                          "Hello",
                          style: TextStyle(
                              color: color.AppColor.textBlackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 24),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.userData.name != null
                                  ? widget.userData.name.toString()
                                  : "User",
                              style: TextStyle(
                                  color: color.AppColor.textBlackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Icon(
                              FontAwesomeIcons.solidHeart,
                              color: Color(0xFFFF4343),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 138,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: color.AppColor.bluePrimaryBoxColor,
                            image: const DecorationImage(
                                image: AssetImage('img/box_decoration.png'),
                                fit: BoxFit.contain,
                                alignment: Alignment.centerRight),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 138,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Stay Home!",
                                              style: TextStyle(
                                                  color: color.AppColor
                                                      .textPrimaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "Schedule on e-visit and discuss the plan with a doctor!",
                                              style: TextStyle(
                                                  color: color.AppColor
                                                      .textPrimaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  right: -4,
                                  bottom: 0,
                                  top: 0,
                                  child: Image(
                                    image: AssetImage('img/illustration1.png'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 29,
                ),
                Text(
                  "What do you need?",
                  style: TextStyle(
                      color: color.AppColor.textBlackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MenuItem(
                              icon: FontAwesomeIcons.userDoctor,
                              title: "Dokter",
                              routeName: '/doctor',
                            ),
                            MenuItem(
                              icon: FontAwesomeIcons.servicestack,
                              title: "Layanan",
                              isPrimary: true,
                              routeName: '/service',
                            ),
                            MenuItem(
                                icon: FontAwesomeIcons.bedPulse,
                                title: "Fasilitas",
                                routeName: '/facility'),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MenuItem(
                              icon: FontAwesomeIcons.handshake,
                              title: "Mitra",
                              isPrimary: true,
                              routeName: '/mitra',
                            ),
                            MenuItem(
                              icon: FontAwesomeIcons.images,
                              title: "Galeri",
                              routeName: '/gallery',
                            ),
                            MenuItem(
                              icon: FontAwesomeIcons.newspaper,
                              title: "Berita",
                              isPrimary: true,
                              routeName: '/post',
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final String routeName;
  bool isPrimary;
  MenuItem({
    Key? key,
    required this.title,
    required this.routeName,
    required this.icon,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
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
              Text(
                "$title",
                style: TextStyle(
                  color:
                      !isPrimary ? color.AppColor.primaryColor : Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
