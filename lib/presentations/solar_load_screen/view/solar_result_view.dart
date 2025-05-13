import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/presentations/solar_load_screen/view/solar_load_view.dart';
import 'package:electricity_app/presentations/solar_load_screen/view/submission_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';

class SubmissionRecord extends StatefulWidget {
  final List<Map<String, dynamic>> submissions;

  SubmissionRecord({super.key, required this.submissions});

  @override
  State<SubmissionRecord> createState() => _SubmissionRecordState();
}

class _SubmissionRecordState extends State<SubmissionRecord> {
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
    final BannerAdController bannerAdController = Get.find<BannerAdController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Submissions Record',
          borderColor: AppColors.kDarkGreen2,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon:
            const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.submissions.isNotEmpty) ...[
                for (int index = 0; index < widget.submissions.length; index++)
                  CustomContainer(
                    height: 200,
                    borderRadius: BorderRadius.circular(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    child: InkWell(
                      onTap: () {
                        var submission = widget.submissions[index];
                        Get.to(
                          SubmissionDetailScreen(
                            totalLoad: submission['totalLoad'],
                            panelsRequired: submission['panelsRequired'],
                            panelCapacity: submission['panelCapacity'],
                            enteredQuantities:
                            List<int>.from(submission['enteredQuantities']),
                          ),
                        );
                      },
                      child: CustomContainer(
                        margin: EdgeInsets.symmetric(horizontal: 16,),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              dense: true,
                              title: regularTextWidget(textTitle: 'Submitted Record: ', textSize: 18, textColor: Colors.black, fontWeight: FontWeight.w600),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 16,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Divider(color: Colors.green, thickness: 2),
                            10.asHeight,
                            CustomContainer(
                              borderRadius: BorderRadius.circular(10),
                              bgColor: Colors.grey.shade300,
                              child: ListTile(
                                dense: true,
                                title: const Text(
                                    'Total Load: ', style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.w600)),
                                trailing: Text(
                                    '${widget.submissions[index]['totalLoad']} Watts', style: TextStyle(fontSize: 16,color: Colors.black, )),
                              ),
                            ),
                            10.asHeight,
                            CustomContainer(
                              borderRadius: BorderRadius.circular(10),
                              bgColor: Colors.grey.shade300,
                              child: ListTile(
                                dense: true,
                                title: const Text('Panels Required: ', style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.w600)),
                                trailing: Text(
                                    '${widget.submissions[index]['panelsRequired']} panels', style: TextStyle(fontSize: 16,color: Colors.green, )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ] else ...[
                const Center(child: Text('No submissions available.')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}