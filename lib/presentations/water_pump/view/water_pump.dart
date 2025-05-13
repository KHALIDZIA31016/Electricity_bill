import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../gen/assets.gen.dart';



class WaterPumpCalculator extends StatefulWidget {
  const WaterPumpCalculator({super.key});

  @override
  State<WaterPumpCalculator> createState() => _WaterPumpCalculatorState();
}

class _WaterPumpCalculatorState extends State<WaterPumpCalculator> {
  final BannerAdController bannerAdController = Get.find<BannerAdController>();
  final interstitialAdController = Get.find<InterstitialAdController>();
  final _dischargeController = TextEditingController();
  final _headController = TextEditingController();
  double _horsepower = 0.0;
  bool isBannerVisible = true;
  void _calculateHorsepower() {
    if (_dischargeController.text.isNotEmpty && _headController.text.isNotEmpty) {
      if (double.tryParse(_dischargeController.text) != null &&
          double.tryParse(_headController.text) != null) {
        double discharge = double.parse(_dischargeController.text);
        double head = double.parse(_headController.text);

        // Simplified horsepower calculation (replace with actual formula if needed)
        // For water at standard conditions, a rough estimate:
        // Horsepower ≈ (Flow Rate (gpm) * Total Head (ft)) / 3960
        setState(() {
          _horsepower = (discharge * head) / 3960;
        });
      } else {
        setState(() {
          _horsepower = 0.0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid numeric values.')),
        );
      }
    } else {
      setState(() {
        _horsepower = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter values for discharge and head.')),
      );
    }
  }
  @override
  void initState() {
    super.initState();

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
    bannerAdController.loadBannerAd('ad5');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Water Pump Power',
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
        bottomNavigationBar: isBannerVisible
          ? SizedBox(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad5'),
      )
          : SizedBox.shrink(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           Image.asset(Assets.pump.path,width: 20,height: 140,),

            const Text(
              'Required Data :',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomContainer(
                    height: 50,
                    width: 100,
                    bgColor: AppColors.kDarkLighter.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardAppearance: Brightness.dark,
                      controller: _dischargeController,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        hintText: 'Discharge Value',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                SizedBox(
                  width: 120.0,
                  child: CustomContainer(
                      height: 50,
                      width: 100,
                      bgColor: AppColors.kDarkLighter.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(10),
                      child: Center(child: Text('gallon/min', style: TextStyle(color: Colors.blue),))),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomContainer(
                    height: 50,
                    width: 100,
                    bgColor: AppColors.kDarkLighter.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: _headController,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        hintText: 'Differential Head Size',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                SizedBox(
                  width: 120.0,
                  child: CustomContainer(
                      height: 50,
                      width: 100,
                      bgColor: AppColors.kDarkLighter.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(10),
                      child: Center(child: Text('ft', style: TextStyle(color: Colors.blue),))),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.kDarkGreen1),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Adjust this value
                                ))),
                  onPressed: _calculateHorsepower,
                  child: regularTextWidget(textTitle: 'Calculate Power', textSize: 18, textColor: AppColors.kWhite),
                ),
              ),

            const SizedBox(height: 50.0),
            regularTextWidget(textTitle: 'Result: ', textSize: 22, textColor: AppColors.kBlack, fontWeight: FontWeight.w600),
            CustomContainer(
              height: 100,
              padding: const EdgeInsets.all(16.0),
              bgColor: Colors.blue[400],
              borderRadius: BorderRadius.circular(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Water Pump Horsepower',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    '${_horsepower.toStringAsFixed(2)} hp',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}