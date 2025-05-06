import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../gen/assets.gen.dart';

class SolarCalculatorScreen extends StatefulWidget {
  @override
  State<SolarCalculatorScreen> createState() => _SolarCalculatorScreenState();
}

class _SolarCalculatorScreenState extends State<SolarCalculatorScreen> {
  final interstitialAdController = Get.find<InterstitialAdController>();
  final BannerAdController bannerAdController = Get.find<BannerAdController>();

  final List<Map<String, dynamic>> fields = [
    {
      'label': 'Total Load of Your Home',
      'unit': 'W',
      'unitOptions': ['W', 'mW', 'µW', 'nW', 'pW', 'KW', 'MW', 'GW']
    },
    {
      'label': 'Battery Voltage',
      'unit': 'V',
      'unitOptions': ['V', 'mV', 'kV']
    },
    {
      'label': 'Battery Capacity',
      'unit': 'Ah',
      'unitOptions': ['Ah', 'mAh']
    },
    {
      'label': 'Required Backup Time',
      'unit': 'Hour',
      'unitOptions': ['Minute', 'Hour']
    },
    {
      'label': 'Solar Panel Watt',
      'unit': 'W',
      'unitOptions': ['W', 'kW', 'MW']
    },
    {
      'label': 'Connected Load to Solar Panel',
      'unit': 'A',
      'unitOptions': ['A', 'mA']
    },
  ];
  List<String> selectedUnits = [];
  @override
  void initState() {
    super.initState();
    selectedUnits = fields.map((f) => f['unit'].toString()).toList();
    interstitialAdController.checkAndShowAdOnVisit();
    bannerAdController.loadBannerAd('ad4');
  }


  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());

  void calculateEnergy() {
    try {
      final load = double.parse(controllers[0].text);
      final batteryVoltage = double.parse(controllers[1].text);
      final batteryCapacity = double.parse(controllers[2].text);
      final backupTime = double.parse(controllers[3].text);
      final solarWatt = double.parse(controllers[4].text);
      final connectedLoad = double.parse(controllers[5].text);

      final energyRequired = load * backupTime; // Wh
      final requiredAh = energyRequired / batteryVoltage;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Calculation Result'),
          content: Text(
            '🔋 Energy Required: ${energyRequired.toStringAsFixed(2)} Wh\n'
                '⚡ Required Battery Capacity: ${requiredAh.toStringAsFixed(2)} Ah',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
    } catch (e) {
      Get.snackbar("Error", "Please enter valid numeric values in all fields.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
  void resetFields() {
    for (var controller in controllers) {
      controller.clear();
    }
    setState(() {
      // Reset to default units (initial ones)
      selectedUnits = fields.map((f) => f['unit'].toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Solar plant Calculator',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kWhite,
              size: 22,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad4'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.solarEnergy.path, scale: 6,),
              10.asHeight,
              regularTextWidget(textTitle: 'Required Data', textSize: 24, textColor: AppColors.kDarker, fontWeight: FontWeight.w600),
              ...fields.asMap().entries.map((entry) {
                int index = entry.key;
                var field = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: controllers[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: field['label'],
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedUnits[index],
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedUnits[index] = newValue!;
                                });
                              },
                              items: fields[index]['unitOptions']
                                  .map<DropdownMenuItem<String>>((unit) {
                                return DropdownMenuItem<String>(
                                  value: unit,
                                  child: Text(unit, style: TextStyle(color: Colors.blue),),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               spacing: 16,
               children: [
                 SizedBox(
                   width: 170,
                   height: 50,
                   child: ElevatedButton(
                       onPressed: calculateEnergy,
                       style: ButtonStyle(
                           backgroundColor: WidgetStatePropertyAll(AppColors.kDarkGreen1),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(8.0), // Adjust this value
                               ))),
                       child: regularTextWidget(textTitle: 'Calculate Load', textSize: 16, textColor: AppColors.kWhite)
                   ),
                 ),

                 SizedBox(
                   height: 50,
                   width: 150,
                   child: ElevatedButton(
                     style: ButtonStyle(
                         backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                             RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8.0), // Adjust this value
                             ))),
                     onPressed: resetFields,
                     child: regularTextWidget(textTitle: 'Reset Fields', textSize: 16, textColor: AppColors.kBlack),
                   ),
                 ),
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
