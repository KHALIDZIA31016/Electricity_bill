import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../ads_manager/interstitial_ads.dart';
import '../../../ads_manager/splash_interstitial.dart';
import '../../home_screen/view/home_view.dart';
import '../controller/splash_control.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(SplashController());
  final SplashInterstitialAd splashInterstitial = Get.put(SplashInterstitialAd());
  @override
  void initState() {
    super.initState();
    splashInterstitial.loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Progress Bar and Percentage (only show when progress < 1.0)
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Obx(() {
              if (controller.progress.value < 1.0) {
                return Column(
                  children: [
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 40,
                      lineHeight: 14.0,
                      percent: controller.progress.value.clamp(0.0, 1.0),
                      backgroundColor: Colors.grey.shade300,
                      progressColor: Colors.deepOrange,
                      animation: false,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${(controller.progress.value * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            }),
          ),

          // Get Started Button (always shown, but behavior and color changes)
          Positioned(
            bottom: 45,
            left: MediaQuery.of(context).size.width * 0.34,
            child: Obx(() {
              final isEnabled = controller.progress.value >= 1.0;

              return GestureDetector(
                // onTap: isEnabled ? controller.onGetStartedPressed : null,
                onTap: (){
                  if (controller.isButtonEnabled.value) {
                    splashInterstitial.checkAndShowAdOnVisit();
                    Get.to(() => HomeScreen());
                  }
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isEnabled ? Colors.white : Colors.grey,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
