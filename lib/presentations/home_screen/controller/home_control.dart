
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("Home Controller Initialized");
  }

  void ForElectricCompanies() {
    Get.toNamed('/electricCompanies');
  }
}
