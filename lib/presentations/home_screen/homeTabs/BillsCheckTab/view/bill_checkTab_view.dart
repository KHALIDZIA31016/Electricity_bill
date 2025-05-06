import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/neumorphic_btn.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../electric_companies/view/electric_companies_screen.dart';

class BillsCheckTab extends StatefulWidget {
  @override
  State<BillsCheckTab> createState() => _BillsCheckTabState();
}

class _BillsCheckTabState extends State<BillsCheckTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        text: "Check Electricity Bills",
        imagePath: Assets.bill.path,
        onTap: () {
          Get.to(ElectricCompaniesScreen());
        },
      ),

    );
  }
}