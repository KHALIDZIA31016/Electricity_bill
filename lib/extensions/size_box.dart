
import 'package:flutter/material.dart';

extension EmptySpace on num{
  SizedBox get asHeight => SizedBox(height: toDouble());
  SizedBox get asWidth => SizedBox(height: toDouble());
}

