import 'package:electricity_app/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../extensions/size_box.dart';
import '../../../gen/assets.gen.dart';
import '../../air_conditioner/view/air_conditioner.dart';
import '../../battery_life_view/battery_life_view.dart';
import '../../electric_companies/view/electric_companies_screen.dart';
import '../../solar_load_screen/view/solar_load_view.dart';
import '../../solar_plant/view/solar_plant_view.dart';
import '../../water_pump/view/water_pump.dart';
import 'appliances_screen_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ElectricityCalculator extends StatefulWidget {
  ElectricityCalculator({super.key});

  @override
  State<ElectricityCalculator> createState() => _ElectricityCalculatorState();
}

class _ElectricityCalculatorState extends State<ElectricityCalculator> {
  final interstitialAdController = Get.find<InterstitialAdController>();
  final BannerAdController bannerAdController = Get.find<BannerAdController>();


  List<Map<String, dynamic>> results = [];

  final List<String> namesTitle = [
    'Home Generator Design',
    'Solar Plant',
    // 'Required Solar',
    'Battery Life',
    'Air Conditioner Size',
    'Water Pump',
    // 'Net Metering',
  ];

  final List<Map<String, dynamic>> meteringName = [
  {"name": "Net Metering", 'subtitle': 'Required Internet to check', "image": Assets.metering.path,
  "url": "https://roshanpakistan.pk/net_metering/"},
    ];

  final List<String> subTitle = [
    '17 appliances record',
    'Required data to calculate',
    // 'Required data to calculate',
    'Required data to calculate',
    'Required data to calculate',
    'Required data to calculate',
    // 'Internet required to find',
  ];

  final List<String> images = [
    Assets.generator.path,
    Assets.solarEnergy.path,
    // Assets.solarEnergy.path,
    Assets.battery.path,
    Assets.ac.path,
    Assets.pump.path,
    // Assets.metering.path,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interstitialAdController.checkAndShowAdOnVisit();
      bannerAdController.loadBannerAd('ad1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: Container(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad1'), // Display the ad
      ),
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Electricity Calculator',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kWhite,
              size: 22,
            ),
          ),
        ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.asHeight,
              Center(
                child: regularTextWidget(
                  textTitle: 'Electricity Supply Companies in Pakistan',
                  textSize: 18,
                  textColor: AppColors.kCharcoal,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: namesTitle.length,
                itemBuilder: (context, index) {
                  return CustomContainer(
                    ontap: () {
                      if (index == 0) {
                          interstitialAdController.checkAndShowAdOnVisit();
                        Get.to(AppliancesScreen());
                      } else if(index == 3){
                        interstitialAdController.checkAndShowAdOnVisit();
                        Get.to(AcSizeCalculatorScreen());
                      } else if(index == 1){
                        interstitialAdController.checkAndShowAdOnVisit();
                        Get.to(SolarCalculatorScreen());
                      }
                      else if(index == 2){
                        interstitialAdController.checkAndShowAdOnVisit();
                        Get.to(BatteryLifeCalculator(
                          results: results,
                          title: namesTitle[index], // Pass the selected title
                        ));
                      } else if(index == 4){
                        interstitialAdController.checkAndShowAdOnVisit();
                        Get.to(WaterPumpCalculator());
                      }
                    },
                    margin: EdgeInsets.symmetric(vertical: 10),
                    borderRadius: BorderRadius.circular(16),
                    bgColor: AppColors.kDarkGreen1,
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                    child: ListTile(
                      dense: true,
                      leading: Image.asset(images[index], scale: 18),
                      title: regularTextWidget(
                        textTitle: namesTitle[index],
                        textSize: 18,
                        textColor: AppColors.kWhite,
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: regularTextWidget(
                        textTitle: subTitle[index],
                        textSize: 14,
                        textColor: AppColors.kWhite,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kOffWhiteGrey,
                        size: 18,
                      ),
                    ),
                  );
                },
              ),
            CustomContainer(

              margin: EdgeInsets.symmetric(vertical: 10),
              borderRadius: BorderRadius.circular(16),
              bgColor: AppColors.kDarkGreen1,
              blurRadius: 6,
              offset: const Offset(2, 4),
              child: ListTile(
                dense: true,
                onTap: () {
                  interstitialAdController.checkAndShowAdOnVisit();
                  Get.to(() => NetMeteringScreen(
                      url: meteringName[0]["url"],
                      companyName: meteringName[0]['name']),
                  );
                },
                leading: Image.asset(Assets.metering.path, scale: 18),
                title: regularTextWidget(
                  textTitle: meteringName[0]['name'],
                  textSize: 18,
                  textColor: AppColors.kWhite,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: regularTextWidget(
                  textTitle: meteringName[0]['subtitle'],
                  textSize: 14,
                  textColor: AppColors.kWhite,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.kOffWhiteGrey,
                  size: 18,
                ),
              ),
            ),
              24.asHeight,
            ],
          ),
        ),
      ),
    );
  }
}


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

  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
      interstitialAdController.checkAndShowAdOnVisit();
      bannerAdController.loadBannerAd('ad4');
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
  }

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
      bottomNavigationBar: Container(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad4'),
      ),
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