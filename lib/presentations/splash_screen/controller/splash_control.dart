
import 'dart:async';
import 'package:get/get.dart';

import '../../../ads_manager/splash_interstitial.dart';
import '../../home_screen/view/home_view.dart';

class SplashController extends GetxController {
  final RxDouble progress = 0.0.obs;
  final RxBool isButtonEnabled = false.obs;



  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startProgressTimer();
  }

  void _startProgressTimer() {
    const totalDuration = 7000; // 4 seconds
    const tickInterval = 30; // milliseconds
    final increment = tickInterval / totalDuration; // progress increment per tick

    _timer = Timer.periodic(Duration(milliseconds: tickInterval), (timer) {
      if (progress.value >= 1.0) {
        progress.value = 1.0;
        isButtonEnabled.value = true;
        timer.cancel();
      } else {
        progress.value += increment;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}