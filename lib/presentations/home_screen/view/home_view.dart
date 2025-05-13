import 'package:carousel_slider/carousel_slider.dart';
import 'package:electricity_app/core/themes/app_color.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/presentations/electric_companies/view/electric_companies_screen.dart';
import 'package:electricity_app/presentations/solar_load_screen/view/solar_load_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../../../gen/assets.gen.dart';
import '../../electricity_calculator/view/electricity_calculator_view.dart';
import '../../net_metering/net_metering.dart';
import '../homeTabs/BillsCheckTab/view/bill_checkTab_view.dart';
import '../homeTabs/CalculatorTab/view/CalculatorTab_view.dart';
import '../homeTabs/SolarPanelTab/view/bill_checkTab_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final interstitialAdController = Get.find<InterstitialAdController>();
  final BannerAdController bannerAdController = Get.find<BannerAdController>();
  bool _isAdVisible = true; // Add a boolean to track ad visibility

  Future<bool> _onWillPop() async {
    final bool? shouldExit = await PanaraConfirmDialog.show(
      context,
      message: '',
      confirmButtonText: 'Exit App',
      cancelButtonText: 'Cancel',
      onTapConfirm: () {
        SystemNavigator.pop(); // Exit the app
      },
      onTapCancel: () {
        Navigator.of(context).pop(); // Close the dialog
      },
      panaraDialogType: PanaraDialogType.normal,
      barrierDismissible: true,
      imagePath: Assets.appIcon.path,
    );

    return shouldExit ?? false; // If dialog is canceled, return false
  }

  @override
  void initState() {
    super.initState();
    bannerAdController.loadBannerAd('ad5');
    interstitialAdController.checkAndShowAdOnVisit();
  }

  final screenIndexing = [
    NetMeteringScreen(
      companyName: 'Net Metering',
      url: 'https://roshanpakistan.pk/net_metering/',
    ),
    ElectricCompaniesScreen(),
    SolarLoadView(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Use the async method for handling back buttons
      child: Scaffold(
        backgroundColor: AppColors.kWhite,
        appBar: PreferredSize(
          preferredSize: Size(0, 70),
          child: CustomAppBar(
            title: 'Electricity Bills',
            borderColor: AppColors.kDarkGreen2,
          ),
        ),
        drawer: CustomDrawer(),
        // Add the onDrawerChanged callback to the Scaffold
        onDrawerChanged: (isOpened) {
          setState(() {
            _isAdVisible = !isOpened; // Hide ad when drawer is open, show when closed
          });
        },
        body: DefaultTabController(
          length: 3,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.asHeight,
                // tabBar tabs
                TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: "Bills Check", icon: Image.asset(Assets.bill.path, scale: 12)),
                    Tab(text: "Solar Panels", icon: Image.asset(Assets.solarEnergy.path, scale: 12)),
                    Tab(text: "Calculator", icon: Image.asset(Assets.calculator.path, scale: 16)),
                  ],
                ),
                // tabBar view
                SizedBox(
                  height: 120,
                  child: TabBarView(
                    children: [
                      BillsCheckTab(),
                      SolarPanelsTab(),
                      CalculatorTab(),
                    ],
                  ),
                ),
                CarouselSlider(
                  disableGesture: true,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.56,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    pauseAutoPlayOnTouch: true,
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    autoPlay: true,
                    viewportFraction: 0.75,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  items: [
                    {
                      "image": Assets.crashBulb.path,
                      "text": "Net Metering",
                    },
                    {
                      "image": Assets.tableBulb.path,
                      "text": "Electricity bills",
                    },
                    {
                      "image": Assets.ladySolar.path,
                      "text": "Solar load Estimation",
                    },
                  ]
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the corresponding screen
                            Get.to(screenIndexing[index]);
                          },
                          child: CustomContainer(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                CustomContainer(
                                  height: 340,
                                  bgColor: Colors.grey,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  borderRadius: BorderRadius.circular(16),
                                  decorationImage: DecorationImage(
                                    image: AssetImage(item['image']!),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(height: 8),
                                regularTextWidget(
                                  textTitle: item['text']!,
                                  textAlign: TextAlign.center,
                                  textSize: 16,
                                  textColor: AppColors.kDarker,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })
                      .toList(),
                ).paddingSymmetric(horizontal: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomContainer(
          width: double.infinity,
          child: _isAdVisible || interstitialAdController.showInterstitialAd
              ? bannerAdController.getBannerAdWidget('ad5')
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}


