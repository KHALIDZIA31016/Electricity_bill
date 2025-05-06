import 'package:electricity_app/presentations/splash_screen/view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'ads_manager/appOpen_ads.dart';
import 'ads_manager/banner_ads.dart';
import 'ads_manager/interstitial_ads.dart';
import 'core/routes/app_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();

  Get.put(OpenAppAdController());
  Get.put(BannerAdController());
  Get.put(InterstitialAdController()..checkAndShowAdOnVisit());

  runApp(const EBillingApp());


  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("05516325-cd96-4e78-94dc-2935a0b83dd1");
  OneSignal.Notifications.requestPermission(true);

}

class EBillingApp extends StatelessWidget {
  const EBillingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}
