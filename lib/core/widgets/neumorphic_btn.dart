import 'package:flutter/material.dart';

import '../themes/app_color.dart';

class NeumorphicButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const NeumorphicButton({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(2, 0),
              blurRadius: 12,
              spreadRadius: 6.7,
            ),

          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 42,
              width: 42,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
