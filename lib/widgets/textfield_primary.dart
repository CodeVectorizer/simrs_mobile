// import material
import 'package:flutter/material.dart';
import '../colors.dart' as color;

class TextFieldPrimary extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool obscureText;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  TextFieldPrimary(
      {Key? key,
      @required this.text,
      @required this.icon,
      this.onTap,
      @required this.controller,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: '$text',
          contentPadding: EdgeInsets.all(10.0),
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: color.AppColor.textSecondaryColor,
          ),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              icon,
              color: color.AppColor.textSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
