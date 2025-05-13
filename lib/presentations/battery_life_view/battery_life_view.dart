import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ads_manager/banner_ads.dart';
import '../../ads_manager/interstitial_ads.dart';
import '../../core/themes/app_color.dart';
import '../../core/widgets/custom_appBar.dart';
import '../../core/widgets/custom_container.dart';
import '../../core/widgets/text_widget.dart';


class BatteryLifeCalculator extends StatefulWidget {
  const BatteryLifeCalculator({super.key, required this.results, required this.title});

  final List<Map<String, dynamic>> results;
  final String title;  // Add title parameter

  @override
  State<BatteryLifeCalculator> createState() => _BatteryLifeCalculatorState();
}

class _BatteryLifeCalculatorState extends State<BatteryLifeCalculator> {
  final BannerAdController bannerAdController = Get.find<BannerAdController>();
  final interstitialAdController = Get.find<InterstitialAdController>();
  late List<Map<String, dynamic>> results;
  bool isBannerVisible = true;
  String selectedOption = 'Single battery';
  final List<String> options = ['Single battery', 'Parallel battery', 'Series battery'];

  String selectedTemperature = '0*C to 32*F';
  final List<String> temperatureOptions = ['0*C to 32*F', '33*F to 60*F', '61*F to 100*F'];

  String selectedLoad = '0 watt';
  final List<String> loadOptions = ['0 watt', '100 watt', '200 watt', '1000 watt'];

  String batteryCapacity = '';
  String dischargeSafety = '';
  String efficiency = '';
  @override
  void initState() {
    super.initState();
    results = List.from(widget.results);
    interstitialAdController.onAdShown = () {
      setState(() {
        isBannerVisible = false;
      });
    };

    interstitialAdController.onAdClosed = () {
      setState(() {
        isBannerVisible = true; // Show banner when ad closed
      });
    };

    // Load initial ads
    interstitialAdController.checkAndShowAdOnVisit();
    bannerAdController.loadBannerAd('ad1');
  }


  Widget _buildDropdown(String title, String value, List<String> items, Function(String?) onChanged) {
    return CustomContainer(
      height: 66,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      borderRadius: BorderRadius.circular(10),
      bgColor: Colors.grey.shade200,
      child: Column(
        children: [
          regularTextWidget(textTitle: title, textSize: 18, textColor: Colors.black),
          Center(
            child: DropdownButton<String>(
              value: value,
              isDense: true,
              dropdownColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              underline: const SizedBox(), // Removes default underline
              items: items.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option, style: const TextStyle(color: Colors.blue)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String title, String hint, String? Function(String?)? validator, Function(String) onChanged) {
    return CustomContainer(
      height: 66,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      borderRadius: BorderRadius.circular(16),
      bgColor:  Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          regularTextWidget(textTitle: title, textSize: 18, textColor: Colors.black),
          Center(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  void _calculateEnergy() {
    // Convert string inputs to numbers
    double load = double.tryParse(loadOptions.firstWhere((
        option) => option == selectedLoad).split(' ')[0]) ?? 0;
    double capacity = double.tryParse(batteryCapacity) ?? 0;
    double safety = double.tryParse(dischargeSafety) ?? 0;
    double efficiencyValue = double.tryParse(efficiency) ?? 0;

    // Example calculation: Total energy = (Load * Capacity * Efficiency / 100) * (1 - (Safety / 100))
    double totalEnergy = (load * capacity * (efficiencyValue / 100)) * (1 - (safety / 100));

    // Show the result in a dialog
    Get.defaultDialog(
      title: "Calculated Energy",
      content: Text("Total Energy: ${totalEnergy.toStringAsFixed(2)} Wh"),
      confirm: TextButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.kDarkGreen1.withValues(alpha: .74)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Adjust this value
                ))),
        onPressed: () => Get.back(),
        child: regularTextWidget(textTitle: 'OK', textSize: 18, textColor: AppColors.kWhite),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: widget.title,  // Use the title from the widget
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
        bottomNavigationBar: isBannerVisible
            ? SizedBox(width: double.infinity, child: bannerAdController.getBannerAdWidget('ad1'),)
            : SizedBox.shrink(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              _buildDropdown('Battery Type', selectedOption, options, (newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              }),
              regularTextWidget(textTitle: 'Required Data', textSize: 22, textColor: AppColors.kDarker, fontWeight: FontWeight.w700),
              _buildDropdown('Ambient Temperature', selectedTemperature, temperatureOptions, (newValue) {
                setState(() {
                  selectedTemperature = newValue!;
                });
              }),
              _buildTextField('Number of Batteries', '0', null, (value) {
                // Handle number of batteries change
              }),
              Row(
                children: [
                  Flexible(child: _buildTextField('Load', '0', null, (value) {
                    // Handle load change
                  })),
                  const SizedBox(width: 10),
                  Flexible(child: _buildDropdown('Load Options', selectedLoad, loadOptions, (newValue) {
                    setState(() {
                      selectedLoad = newValue!;
                    });
                  })),
                ],
              ),
              Row(
                children: [
                  Flexible(child: _buildTextField('Discharge Safety', '0%', null, (value) {
                    dischargeSafety = value;
                  })),
                  const SizedBox(width: 10),
                  Flexible(child: _buildTextField('Efficiency', '0%', null, (value) {
                    efficiency = value;
                  })),
                ],
              ),
              _buildTextField('Battery Capacity', '0', null, (value) {
                batteryCapacity = value;
              }),
              const SizedBox(height: 20),
              CustomContainer(
                height: 54,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                borderRadius: BorderRadius.circular(10),
                bgColor: Colors.green,
                child: Center(
                  child: GestureDetector(
                    onTap: _calculateEnergy,
                    child: regularTextWidget(
                      textTitle: 'Calculate',
                      textSize: 18,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}