import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';

class SubmissionDetailScreen extends StatefulWidget {
  final int totalLoad;
  final int panelsRequired;
  final int panelCapacity;
  final List<int> enteredQuantities;

  const SubmissionDetailScreen({
    super.key,
    required this.totalLoad,
    required this.panelsRequired,
    required this.panelCapacity,
    required this.enteredQuantities,
  });

  @override
  State<SubmissionDetailScreen> createState() => _SubmissionDetailScreenState();
}

class _SubmissionDetailScreenState extends State<SubmissionDetailScreen> {
  final interstitialAdController = Get.find<InterstitialAdController>();
  final BannerAdController bannerAdController = Get.find<BannerAdController>();
  bool isBannerVisible = true;

  @override
  void initState() {
    super.initState();

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


  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      'Tube Light',
      'Energy Saver',
      'LED bulbs',
      'TV',
      'LED TV',
      'Computer',
      'Laptop',
      'Ceiling Fan',
      'Stand Fan',
      'Split AC',
      'Inverter AC',
      'Freezer',
      'Refrigerator',
      'Washing Machine',
      'Iron',
      'Water Pump'
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Solar Load Details',
          borderColor: AppColors.kDarkGreen2,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      bottomNavigationBar: isBannerVisible
          ? SizedBox(width: double.infinity, child: bannerAdController.getBannerAdWidget('ad1'),)
          : SizedBox.shrink(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              Wrap(
                children: [
                  regularTextWidget(
                    textTitle: '🔋 Total Load (in watts): ',
                    textSize: 18,
                    textColor: AppColors.kPineGreen,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 8),
                  regularTextWidget(
                    textTitle: '${widget.totalLoad} Watts',
                    textSize: 18,
                    textColor: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(
                color: AppColors.kDarkGreen1,
                indent: 60,
                endIndent: 60,
                thickness: 2,
              ),
              Wrap(
                children: [
                  regularTextWidget(
                    textTitle: '☀️ Panels Required: ',
                    textSize: 18,
                    textColor: AppColors.kPineGreen,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 8),
                  regularTextWidget(
                    textTitle: '${widget.panelsRequired} panels',
                    textSize: 18,
                    textColor: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              regularTextWidget(
                textTitle: " (Each ${widget.panelCapacity} Watts)",
                textSize: 16,
                textColor: AppColors.kBlack,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.kDarkGreen1, thickness: 2),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return CustomContainer(
                    bgColor: AppColors.kEmeraldGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        titles[index],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        '${widget.enteredQuantities[index]}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}