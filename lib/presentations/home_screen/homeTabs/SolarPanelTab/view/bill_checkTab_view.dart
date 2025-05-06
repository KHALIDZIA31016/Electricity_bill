import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/neumorphic_btn.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../solar_load_screen/view/solar_load_view.dart';

class SolarPanelsTab extends StatefulWidget {
  @override
  State<SolarPanelsTab> createState() => _SolarPanelsTabState();
}

class _SolarPanelsTabState extends State<SolarPanelsTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        text: "Solar Panels Estimation",
        imagePath: Assets.solarEnergy.path, // Replace with your actual image path
        onTap: () {
          Get.to(SolarLoadView());
        },
      ),
    );
  }
}