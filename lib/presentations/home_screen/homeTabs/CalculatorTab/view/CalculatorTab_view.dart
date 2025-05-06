import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../ads_manager/interstitial_ads.dart';
import '../../../../../core/widgets/neumorphic_btn.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../electricity_calculator/view/electricity_calculator_view.dart';



class CalculatorTab extends StatefulWidget {
  @override
  State<CalculatorTab> createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<CalculatorTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        text: "Electricity Calculator",
        imagePath: Assets.calculator.path, // Replace with your actual image path
        onTap: () {
          Get.to(ElectricityCalculator());
        },
      ),
    );
  }
}