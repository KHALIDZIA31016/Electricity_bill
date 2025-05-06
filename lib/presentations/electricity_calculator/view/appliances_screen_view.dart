import 'dart:convert';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/presentations/electricity_calculator/view/show_result_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../gen/assets.gen.dart';

class AppliancesScreen extends StatefulWidget {
  const AppliancesScreen({super.key});

  @override
  _AppliancesScreenState createState() => _AppliancesScreenState();
}

class _AppliancesScreenState extends State<AppliancesScreen> {
  final interstitialAdController = Get.find<InterstitialAdController>();

  List<Map<String, dynamic>> devicesTitle = [
    {'name': 'Refrigerator', 'image': Assets.refrigerator.path},
    {'name': 'Freezer', 'image': Assets.freezer.path},
    {'name': 'Washing Machine', 'image': Assets.mahine.path},
    {'name': 'Television', 'image': Assets.tv.path},
    {'name': 'Water Pump', 'image': Assets.pump.path},
    {'name': 'Electric Iron', 'image': Assets.iron.path},
    {'name': 'Electric Fans', 'image': Assets.coffeeMaker.path},
    {'name': 'Electric Heater', 'image': Assets.airCoolerPng.path},
    {'name': 'Electric Geyser', 'image': Assets.geyser.path},
    {'name': 'Electric Light', 'image': Assets.light.path},
    {'name': 'Microwave Oven', 'image': Assets.microwave.path},
    {'name': 'Air Conditioner', 'image': Assets.ac.path},
    {'name': 'Cloth Dryer', 'image': Assets.dryer.path},
    {'name': 'Air Cooler', 'image': Assets.airCoolerPng.path},
    {'name': 'Computer/Laptop', 'image': Assets.laptop.path},
    {'name': 'Printer', 'image': Assets.printer.path},
    {'name': 'Coffee Maker', 'image': Assets.coffeeMaker.path},
    {'name': 'DishWasher', 'image': Assets.dishwasher.path},
  ];

  Future<void> saveDeviceData({
    required String deviceName,
    required int watt,
    required int quantity,
    required int dailyUsage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> existingData = prefs.getStringList('device_data') ?? [];

    Map<String, dynamic> newData = {
      'deviceName': deviceName,
      'watt': watt,
      'quantity': quantity,
      'dailyUsage': dailyUsage,
    };

    existingData.add(json.encode(newData)); // Changed this line
    await prefs.setStringList('device_data', existingData);
  }


  @override
  void initState() {
    super.initState();
    interstitialAdController.checkAndShowAdOnVisit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Electricity consumption calculator',
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
      bottomNavigationBar: CustomContainer(
        width: double.infinity,
        height: 50,
        bgColor: Colors.blue,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kDarkGreen1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Get.to(() => ShowResultScreen());
          },
          child: regularTextWidget(
            textTitle: 'Show Result',
            textSize: 22,
            textColor: AppColors.kWhite,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                itemCount: devicesTitle.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2.6,
                ),
                itemBuilder: (context, index) {
                  return CustomContainer(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 146,
                    width: 320,
                    ontap: () {
                      _showDeviceDialog(index);
                    },
                    borderRadius: BorderRadius.circular(10),
                    bgColor: AppColors.kDarkGreen1,
                    child: Center(
                      child: Column(
                        children: [
                          10.asWidth,
                          CustomContainer(
                            height: 80,
                            width: 90,
                            bgColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            borderRadius: BorderRadius.circular(10),
                            shadowColor: Colors.black54,
                            offset: Offset(-3.0, 3.0),
                            blurRadius: 10,
                            child: Image.asset(devicesTitle[index]['image']),
                          ),
                          10.asHeight,
                          regularTextWidget(
                            textTitle: devicesTitle[index]['name'],
                            textSize: 16,
                            textColor: AppColors.kWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              30.asHeight,

              // --- Show Result Button at Bottom ---


            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Function to Show Device Dialog ---
  void _showDeviceDialog(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final deviceName = devicesTitle[index]['name'];

    // Load data if exists
    String? wattStored = prefs.getString('$deviceName-watt');
    String? quantityStored = prefs.getString('$deviceName-quantity');
    String? usageStored = prefs.getString('$deviceName-usage');

    TextEditingController wattController = TextEditingController(text: wattStored ?? '');
    TextEditingController quantityController = TextEditingController(text: quantityStored ?? '');
    TextEditingController usageController = TextEditingController(text: usageStored ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: CustomContainer(
                width: 300,
                height: 350,
                child: Column(
                  children: [
                    CustomContainer(
                      width: double.infinity,
                      height: 46,
                      bgColor: AppColors.kDarkGreen1,
                      borderRadius: BorderRadius.circular(16),
                      child: Center(
                        child: regularTextWidget(
                          textTitle: deviceName,
                          textSize: 16,
                          textColor: AppColors.kWhite,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    CustomContainer(
                      height: 88,
                      bgColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 8),
                            child: regularTextWidget(
                              textTitle: 'Enter power',
                              textSize: 16,
                              textColor: AppColors.kBlack,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: wattController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'e.g. 500',
                                    contentPadding: EdgeInsets.all(12),
                                  ),
                                ),
                              ),
                              Text('Watts', style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomContainer(
                      height: 56,
                      bgColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                      child: TextField(
                        controller: quantityController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Quantity',
                          contentPadding: EdgeInsets.all(12),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomContainer(
                      height: 56,
                      bgColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                      child: TextField(
                        controller: usageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Daily Usage (hours)',
                          contentPadding: EdgeInsets.all(12),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kDarkGreen1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        String watt = wattController.text.trim();
                        String quantity = quantityController.text.trim();
                        String usage = usageController.text.trim();

                        // Validate before saving
                        if (watt.isNotEmpty && quantity.isNotEmpty && usage.isNotEmpty) {
                          await prefs.setString('$deviceName-watt', watt);
                          await prefs.setString('$deviceName-quantity', quantity);
                          await prefs.setString('$deviceName-usage', usage);

                          await saveDeviceData(
                            deviceName: deviceName,
                            watt: int.tryParse(watt) ?? 0,
                            quantity: int.tryParse(quantity) ?? 0,
                            dailyUsage: int.tryParse(usage) ?? 0,
                          );

                          Navigator.pop(context);
                          Get.snackbar('Saved', 'Device information saved successfully!',
                              backgroundColor: Colors.grey.shade300, colorText: Colors.black54);
                        } else {
                          Get.snackbar('Error', 'Please fill all fields',
                              backgroundColor: Colors.deepOrange, colorText: Colors.white);
                        }
                      },
                      child: regularTextWidget(
                        textTitle: 'Save',
                        textSize: 18,
                        textColor: AppColors.kWhite,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
