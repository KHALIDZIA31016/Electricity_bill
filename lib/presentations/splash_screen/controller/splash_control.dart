import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../ads_manager/splash_interstitial.dart';
import '../../home_screen/view/home_view.dart';

class SplashController extends GetxController {
  final SplashInterstitialAd interstitialAdController = Get.put(SplashInterstitialAd());

  @override
  void onInit() {
    super.onInit();
    interstitialAdController.loadInterstitialAd();
    print("Splash Controller onInit called");
  }

  Future<void> onGetStartedPressed() async {
    await interstitialAdController.checkAndShowAdOnVisit();
    Get.to(HomeScreen());  // Navigate to HomeScreen after showing the ad
  }
}

