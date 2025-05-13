
import 'dart:ui';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  int count = 0;
  bool showInterstitialAd = true;  // Controlled via Remote Config
  int interstitialFrequency = 3;  // Default frequency

  // Callbacks to notify UI about ad events
  VoidCallback? onAdShown;
  VoidCallback? onAdClosed;

  @override
  void onInit() {
    super.onInit();
    // optionally load an ad initially
    loadInterstitialAd();
  }

  // Load the interstitial ad
  void loadInterstitialAd() {
    if (!showInterstitialAd) return;  // Skip if disabled

    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712", // test ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('Interstitial failed to load: ${error.message}');
          _interstitialAd = null;
        },
      ),
    );
  }

  // Show ad if conditions meet
  // void checkAndShowAdOnVisit() {
  //   if (!showInterstitialAd) {
  //     print('Interstitial ads are disabled via Remote Config');
  //     return;
  //   }
  //
  //   count++;
  //   print('Screen visit count: $count');
  //
  //   if (count >= interstitialFrequency) {
  //     if (_interstitialAd != null) {
  //       print('Showing interstitial ad...');
  //       // Assign fullScreenContentCallback
  //       _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //         onAdShowedFullScreenContent: (ad) {
  //           print('Interstitial ad shown.');
  //           if (onAdShown != null) onAdShown!();
  //         },
  //         onAdDismissedFullScreenContent: (ad) {
  //           print('Interstitial ad dismissed.');
  //           if (onAdClosed != null) onAdClosed!();
  //           loadInterstitialAd(); // preload next ad
  //           _interstitialAd = null;
  //         },
  //         onAdFailedToShowFullScreenContent: (ad, error) {
  //           print('Failed to show ad: ${error.message}');
  //           if (onAdClosed != null) onAdClosed!();
  //           loadInterstitialAd();
  //           _interstitialAd = null;
  //         },
  //       );
  //
  //       _interstitialAd!.show();
  //       _interstitialAd = null; // reset
  //       count = 0; // reset visit count
  //     } else {
  //       print('Interstitial ad not ready, loading...');
  //       loadInterstitialAd();
  //     }
  //   }
  // }
  void checkAndShowAdOnVisit() {
    if (!showInterstitialAd) {
      print('Interstitial ads are disabled via Remote Config');
      return;
    }

    count++;
    print('Screen visit count: $count');

    if (count >= interstitialFrequency) {
      if (_interstitialAd != null) {
        print('Preparing to show interstitial ad...');

        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (ad) {
            print('Interstitial ad is now OPEN (shown).');
          },
          onAdDismissedFullScreenContent: (ad) {
            print('Interstitial ad is now CLOSED (dismissed).');
            if (onAdClosed != null) onAdClosed!();
            loadInterstitialAd();  // preload next ad
            _interstitialAd = null;
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            print('Failed to show ad: ${error.message}');
            if (onAdClosed != null) onAdClosed!();
            loadInterstitialAd();
            _interstitialAd = null;
          },
        );

        _interstitialAd!.show();
        _interstitialAd = null; // reset
        count = 0; // reset visit count
      } else {
        print('Interstitial ad not ready, loading...');
        loadInterstitialAd();
      }
    }
  }


}






//
//
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class InterstitialAdController extends GetxController {
//   InterstitialAd? _interstitialAd;
//   int count = 0;
//   bool showInterstitialAd = true;  // This will be controlled via Remote Config
//   int interstitialFrequency = 3;  // Default frequency for showing interstitial ads
//
//   @override
//   void onInit() {
//     super.onInit();
//     // fetchRemoteConfig();  // Fetch Remote Config when the controller is initialized
//   }
//
//   // Fetch Remote Config values
//   // Future<void> fetchRemoteConfig() async {
//   //   try {
//   //     final RemoteConfig remoteConfig = await RemoteConfig.instance;
//   //     await remoteConfig.fetch(expiration: const Duration(hours: 1)); // Fetch config with a 1-hour expiration
//   //     await remoteConfig.activate();  // Apply the fetched config
//   //
//   //     // Fetch interstitial ad settings
//   //     showInterstitialAd = remoteConfig.getBool('interstitial') ?? true;  // Default to true if not available
//   //     interstitialFrequency = int.tryParse(remoteConfig.getString('interstitial') ?? '3') ?? 3;  // Default to 3 if not available
//   //
//   //     print('Remote Config fetched: showInterstitialAd: $showInterstitialAd, interstitialFrequency: $interstitialFrequency');
//   //   } catch (e) {
//   //     print('Error fetching remote config: $e');
//   //   }
//   // }
//
//   // Load the interstitial ad
//   void loadInterstitialAd() {
//     if (!showInterstitialAd) return;  // Skip loading if interstitial ads are disabled
//
//     InterstitialAd.load(
//       adUnitId: "ca-app-pub-3940256099942544/1033173712", // tested
//       // adUnitId: "ca-app-pub-3118392277684870/6868775612", // actual
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (ad) {
//           _interstitialAd = ad;
//         },
//         onAdFailedToLoad: (error) {
//           print('Interstitial failed to load: ${error.message}');
//           _interstitialAd = null;
//         },
//       ),
//     );
//   }
//
//   // Check and show ad on visit based on Remote Config frequency
//   void checkAndShowAdOnVisit() {
//     if (!showInterstitialAd) {
//       print('Interstitial ads are disabled via Remote Config');
//       return;
//     }
//
//     count++;
//     print('Screen visit count: $count');
//
//     if (count >= interstitialFrequency) {
//       if (_interstitialAd != null) {
//         print('Showing interstitial ad...');
//
//         _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
//           onAdDismissedFullScreenContent: (ad) {
//             print('Interstitial ad dismissed.');
//             loadInterstitialAd();  // Load next ad
//           },
//           onAdFailedToShowFullScreenContent: (ad, error) {
//             print('Failed to show interstitial ad: ${error.message}');
//             loadInterstitialAd();  // Load next ad if show failed
//           },
//         );
//
//         _interstitialAd?.show();
//         _interstitialAd = null;  // Clear reference
//         count = 0;  // Reset visit count
//       } else {
//         print('Interstitial ad not ready.');
//         loadInterstitialAd();  // Try to preload for next time
//       }
//     }
//   }
// }
