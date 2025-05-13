import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../gen/assets.gen.dart';
import '../../air_conditioner/view/air_conditioner.dart';
import '../../battery_life_view/battery_life_view.dart';
import '../../net_metering/net_metering.dart';
import '../../solar_plant/view/solar_plant_view.dart';
import '../../water_pump/view/water_pump.dart';
import '../view/appliances_screen_view.dart';

class ElectricityCalculatorController extends GetxController {
  final interstitialAdController = Get.find<InterstitialAdController>();
  final bannerAdController = Get.find<BannerAdController>();

  // Banner visibility
  var isBannerVisible = true.obs;

  // Data
  final List<String> namesTitle = [
    'Home Generator Design',
    'Solar Plant',
    'Battery Life',
    'Air Conditioner Size',
    'Water Pump',
  ];

  final List<Map<String, dynamic>> meteringName = [
    {
      "name": "Net Metering",
      'subtitle': 'Required Internet to check',
      "image": '', // You can remove this if not needed
      "url": "https://roshanpakistan.pk/net_metering/"
    },
  ];

  final List<String> subTitle = [
    '17 appliances record',
    'Required data to calculate',
    'Required data to calculate',
    'Required data to calculate',
    'Required data to calculate',
  ];

  final List<String> images = [
    Assets.generator.path,
    Assets.solarEnergy.path,
    Assets.battery.path,
    Assets.ac.path,
    Assets.pump.path,
  ];

  @override
  void onInit() {
    super.onInit();

    // Setup Ad callbacks
    interstitialAdController.onAdShown = () {
      isBannerVisible.value = false;
    };
    interstitialAdController.onAdClosed = () {
      isBannerVisible.value = true;
    };

    // Load initial ads
    interstitialAdController.checkAndShowAdOnVisit();
    bannerAdController.loadBannerAd('ad1');
  }

  // Method to handle navigation with ad check
  void navigateTo(BuildContext context, int index) {
    interstitialAdController.checkAndShowAdOnVisit();

    switch (index) {
      case 0:
        Get.to(() => AppliancesScreen());
        break;
      case 1:
        Get.to(() => SolarCalculatorScreen());
        break;
      case 2:
        Get.to(() => BatteryLifeCalculator(
          results: [],
          title: namesTitle[index],
        ));
        break;
      case 3:
        Get.to(() => AcSizeCalculatorScreen());
        break;
      case 4:
        Get.to(() => WaterPumpCalculator());
        break;
    }
  }

  void openMetering() {
    interstitialAdController.checkAndShowAdOnVisit();
    Get.to(() => NetMeteringScreen(
      url: meteringName[0]["url"],
      companyName: meteringName[0]['name'],
    ));
  }
}