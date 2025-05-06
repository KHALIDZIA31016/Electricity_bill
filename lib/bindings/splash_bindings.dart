
import 'package:get/get.dart';
import '../presentations/splash_screen/controller/splash_control.dart';

class SplashBindings extends Bindings {
 @override
 void dependencies() {
  print("Splash Binding Called");
  // Get.lazyPut<SplashController>(() => SplashController());
  Get.put<SplashController>(SplashController());
 }
}