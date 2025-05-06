import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';

class AcSizeCalculatorScreen extends StatefulWidget {
  @override
  _AcSizeCalculatorScreenState createState() => _AcSizeCalculatorScreenState();
}

class _AcSizeCalculatorScreenState extends State<AcSizeCalculatorScreen> {
  final BannerAdController bannerAdController = Get.find<BannerAdController>();
  final interstitialAdController = Get.find<InterstitialAdController>();

  final TextEditingController roomLengthController = TextEditingController();
  final TextEditingController roomWidthController = TextEditingController();
  final TextEditingController roomHeightController = TextEditingController(text: '');
  final TextEditingController numberOfPersonsController = TextEditingController(text: '');

  final List<String> temperatureOptions = [
    '20°C',
    '25°C',
    '30°C',
    '35°C',
    '40°C',
    '45°C',
    '50°C',
    '55°C',
    '60°C'
  ];

  String selectedTemperature = '20°C';

  final List<String> unitOptions = ['ft', 'm', 'cm'];
  String selectedLengthUnit = 'ft';
  String selectedWidthUnit = 'ft';
  String selectedHeightUnit = 'ft';


  String result = '';

  // Mapping temperature options to adjustment factors
  final Map<String, double> temperatureAdjustmentFactors = {
    '20°C': 1.00,
    '25°C': 1.10,
    '30°C': 1.20,
    '35°C': 1.30,
    '40°C': 1.40,
    '45°C': 1.50,
    '50°C': 1.60,
    '55°C': 1.70,
    '60°C': 1.80,
  };

  void calculateACSize() {
    double length = double.tryParse(roomLengthController.text) ?? 0;
    double width = double.tryParse(roomWidthController.text) ?? 0;
    double height = double.tryParse(roomHeightController.text) ?? 0;
    int persons = int.tryParse(numberOfPersonsController.text) ?? 0;

    // Convert all units to feet for calculation
    if (selectedLengthUnit == 'm') length *= 3.28084;
    if (selectedLengthUnit == 'cm') length *= 0.0328084;
    if (selectedWidthUnit == 'm') width *= 3.28084;
    if (selectedWidthUnit == 'cm') width *= 0.0328084;
    if (selectedHeightUnit == 'm') height *= 3.28084;
    if (selectedHeightUnit == 'cm') height *= 0.0328084;

    double volume = length * width * height;
    double baseBTU = volume * 5;
    double totalBTU = baseBTU + (persons * 600);

    // Get adjustment factor based on selected temperature
    double tempFactor = temperatureAdjustmentFactors[selectedTemperature] ?? 1.0;

    // Adjust the BTU based on temperature
    double adjustedBTU = totalBTU * tempFactor;

    double tons = adjustedBTU / 12000;

    setState(() {
      result = '${tons.toStringAsFixed(2)} ton';
    });
  }

  void resetFields() {
    roomLengthController.clear();
    roomWidthController.clear();
    numberOfPersonsController.clear();
    roomHeightController.clear();
    selectedTemperature = '20°C';
    selectedLengthUnit = 'ft';
    selectedWidthUnit = 'ft';
    selectedHeightUnit = 'ft';

    setState(() {
      result = '';
    });
  }

  Widget buildTextField(
      String label, TextEditingController controller,
      String selectedUnit, void Function(String?) onChanged) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                hintText: label,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedUnit,
                isExpanded: true,
                onChanged: onChanged,
                items: unitOptions.map((unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Center(child: Text(unit)),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    bannerAdController.loadBannerAd('ad5');
    interstitialAdController.checkAndShowAdOnVisit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'AC Size Calculator',
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kWhite,
              size: 22,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad5'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomContainer(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                bgColor: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Temperature:',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    DropdownButton<String>(
                      value: selectedTemperature,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      iconSize: 24,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                      ),
                      underline: Container(height: 0),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTemperature = newValue!;
                        });
                      },
                      items: temperatureOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Required Data:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              buildTextField('Room Length', roomLengthController, selectedLengthUnit,
                      (value) => setState(() => selectedLengthUnit = value!)),
              buildTextField('Room Width', roomWidthController, selectedWidthUnit,
                      (value) => setState(() => selectedWidthUnit = value!)),
              buildTextField('Room Height', roomHeightController, selectedHeightUnit,
                      (value) => setState(() => selectedHeightUnit = value!)),
              SizedBox(height: 10),
              TextField(
                controller: numberOfPersonsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number Of Persons',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    height: 46,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors.kDarkGreen1),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))),
                      onPressed: calculateACSize,
                      child: regularTextWidget(
                          textTitle: 'Calculate',
                          textSize: 16,
                          textColor: AppColors.kWhite),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 46,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Colors.grey.shade200),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))),
                      onPressed: resetFields,
                      child: regularTextWidget(
                          textTitle: 'Reset',
                          textSize: 16,
                          textColor: AppColors.kBlack),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomContainer(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                bgColor: AppColors.kDarkGreen1,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Text(
                      'Recommended AC Size',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      result.isEmpty ? '0.0 ton' : result,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Temperature is set to:  $selectedTemperature',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}