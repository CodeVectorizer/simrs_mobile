import 'package:flutter/material.dart';
import 'package:simrs_mobile/colors.dart' as color;

class ButtonPrimary extends StatelessWidget {
  final String? text;
  final GestureTapCallback? onTap;
  const ButtonPrimary({Key? key, @required this.text, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color.AppColor.textPrimaryColor,
        ),
        child: Center(
          child: Text(
            "$text",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: color.AppColor.textSecondaryColor),
          ),
        ),
      ),
    );
  }
}
