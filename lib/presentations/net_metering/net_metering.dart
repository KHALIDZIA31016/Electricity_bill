import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../ads_manager/banner_ads.dart';
import '../../ads_manager/interstitial_ads.dart';
import '../../core/themes/app_color.dart';
import '../../core/widgets/custom_appBar.dart';



class NetMeteringScreen extends StatefulWidget {
  final String url;
  final String companyName;

  const NetMeteringScreen({super.key, required this.url, required this.companyName});

  @override
  State<NetMeteringScreen> createState() => _NetMeteringScreenState();
}

class _NetMeteringScreenState extends State<NetMeteringScreen> {
  final interstitialAdController = Get.find<InterstitialAdController>();
  final BannerAdController bannerAdController = Get.find<BannerAdController>();


  bool isBannerVisible = true;
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://roshanpakistan.pk/net_metering/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
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
    bannerAdController.loadBannerAd('ad1');
  }

  late final WebViewController controller;
  bool isLoading = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title:  widget.companyName.toUpperCase(),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      bottomNavigationBar: isBannerVisible
          ? SizedBox(width: double.infinity, child: bannerAdController.getBannerAdWidget('ad1'),)
          : SizedBox.shrink(),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}