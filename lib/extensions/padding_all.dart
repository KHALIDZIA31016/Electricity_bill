import 'package:flutter/material.dart';


extension PaddingExtensions on num {
  Padding get horizontalPadding => Padding(
    padding: EdgeInsets.symmetric(horizontal: toDouble()),
  );

  Padding get verticalPadding => Padding(
    padding: EdgeInsets.symmetric(vertical: toDouble()),
  );

  Padding get allPadding => Padding(
    padding: EdgeInsets.all(toDouble()),
  );
}
