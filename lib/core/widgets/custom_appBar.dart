import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_color.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.bgColor,
    this.borderColor, this.leading, // Added this parameter for the border color
  }) : super(key: key);

  final String title;
  final Color? bgColor;
  final Color? borderColor;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: AppColors.kDarkGreen1,
      ),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make AppBar transparent to show the border
        leading: leading,
        iconTheme: IconThemeData(color: Colors.white, size: 30), // Change the icon color here
        title: Text(
          title,
          style: TextStyle(
              color: AppColors.kWhite, fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}