import 'package:flutter/material.dart';


class CustomContainer extends StatelessWidget {
   CustomContainer({
     super.key,
    this.height,
    this.width,
     this.decorationImage,
     this.bgColor,
     this.borderRadius,
     this.border,
     this.shape,
     this.gradient,
     this.spreadRadius,
     this.offset,
     this.shadowColor,
     this.blurRadius,
     this.ontap, this.child, this.padding, this.margin
  });

  final double? height;
  final double? width;
  final DecorationImage? decorationImage;
  final Color? bgColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final BoxShape? shape;
  final Gradient? gradient;
  final Color? shadowColor;
  final double? blurRadius;
  final double? spreadRadius;
  final  Offset? offset;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(

          borderRadius: borderRadius,
          color: bgColor,
          image: decorationImage,
          border: border,
          shape: shape ?? BoxShape.values[0],
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Colors.transparent,
              blurRadius: blurRadius ?? 0,
              spreadRadius: spreadRadius ?? 0,
              offset: offset ?? Offset(0, 0),
            )
          ]
        ),
        child: child,
      ),
    );
  }
}
