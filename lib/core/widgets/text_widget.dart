import 'package:flutter/material.dart';

Widget regularTextWidget ({
    required String textTitle,
    required double textSize,
    required Color textColor,
    FontWeight? fontWeight,
    Color? bgColor,
    Color? shadowColor,
    double? blurRadius,
    double? spreadRadius,
    Offset? offset,
    TextAlign? textAlign,

}){
  return Text(
    textTitle,
    textAlign: textAlign,
    style: TextStyle(
      color: textColor,
      fontSize: textSize,
      fontWeight: fontWeight,
      backgroundColor: bgColor,
      shadows: [
        BoxShadow(
          color: shadowColor ?? Colors.transparent,
          offset: offset ?? Offset(0, 0),
          blurRadius: blurRadius ?? 0,
          spreadRadius: spreadRadius ?? 0

        ),
      ],

    ),
  );
}