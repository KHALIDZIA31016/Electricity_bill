import 'package:electricity_app/core/themes/app_color.dart';
import 'package:electricity_app/core/widgets/custom_appBar.dart';
import 'package:electricity_app/core/widgets/custom_container.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/gen/assets.gen.dart';
import 'package:electricity_app/presentations/electric_companies/view/reference_number_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../controller/electric_companies_control.dart';

class ElectricCompaniesScreen extends StatefulWidget {
  ElectricCompaniesScreen({super.key});

  @override
  State<ElectricCompaniesScreen> createState() =>
      _ElectricCompaniesScreenState();
}

class _ElectricCompaniesScreenState extends State<ElectricCompaniesScreen> {
  final interstitialAdController = Get.find<InterstitialAdController>();
  final BannerAdController bannerAdController = Get.find<BannerAdController>();

  final ElectricCompaniesController controller = Get.put(
    ElectricCompaniesController(),
  );
  final List<Map<String, dynamic>> companies = [
    {
      "name": "IESCO",
      'location': 'Islamabad',
      "image": Assets.iesco.path,
      "url": "https://bill.pitc.com.pk/iescobill",
    },
    {
      "name": "LESCO",
      'location': 'Lahore',
      "image": Assets.lesco.path,
      "url": "https://bill.pitc.com.pk/lescobill",
    },
    {
      "name": "GEPCO",
      'location': 'Gujranwala',
      "image": Assets.gepco.path,
      "url": "https://bill.pitc.com.pk/gepcobill",
    },

    {
      "name": "PESCO",
      'location': 'Peshawar',
      "image": Assets.pesco.path,
      "url": "https://bill.pitc.com.pk/pescobill",
    },
    {
      "name": "FESCO",
      'location': 'Faisalabad',
      "image": Assets.fesco.path,
      "url": "https://bill.pitc.com.pk/fescobill",
    },
    {
      "name": "QESCO",
      'location': 'Quetta',
      "image": Assets.qesco.path,
      "url": "https://bill.pitc.com.pk/qescobill",
    },

    {
      "name": "TESCO",
      'location': 'Tribal Areas',
      "image": Assets.teco.path,
      "url": "https://bill.pitc.com.pk/tescobill",
    },

    {
      "name": "HESCO",
      'location': 'Hyderabad ',
      "image": Assets.hesco.path,
      "url": "https://bill.pitc.com.pk/hescobill",
    },
    {
      "name": "MEPCO",
      'location': 'Multan',
      "image": Assets.mepco.path,
      "url": "https://bill.pitc.com.pk/mepcobill",
    },

    {
      "name": "SEPCO",
      'location': 'Sukkur',
      "image": Assets.sepco.path,
      "url": "https://bill.pitc.com.pk/sepcobill",
    },
    {
      "name": "K-ELECTRIC",
      'location': 'Karachi',
      "image": Assets.kelectric.path,
      "url": "https://staging.ke.com.pk:24555/",
    },
  ];

  @override
  void initState() {
    super.initState();
    interstitialAdController.checkAndShowAdOnVisit();
    bannerAdController.loadBannerAd('ad4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Electric Companies',
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
      body: SingleChildScrollView(
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
            20.asHeight,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: companies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.96,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final company = companies[index];
                return CustomContainer(
                  ontap: () {
                    interstitialAdController.checkAndShowAdOnVisit();
                    Get.to(() => ReferenceNumberScreen(
                        url: company["url"],
                        companyName: companies[index]['name']));
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  borderRadius: BorderRadius.circular(16),
                  bgColor: AppColors.kWhite,
                  shadowColor: Colors.grey.shade400,
                  blurRadius: 6,
                  offset: const Offset(2, 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(company['image'], scale: 3),
                      // 10.asHeight,
                      Flexible(
                        child: regularTextWidget(
                          textTitle: company['name'],
                          textSize: 20,
                          textColor: AppColors.kBlack0D.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Flexible(
                        child: regularTextWidget(
                          textTitle: company['location'],
                          textSize: 14,
                          textColor: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            24.asHeight,
          ],
        ),
      ),
    );
  }
}

