import 'package:get/get.dart';

import '../presentations/home_screen/controller/home_control.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
