import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';

class ShowResultScreen extends StatefulWidget {
  const ShowResultScreen({super.key});

  @override
  _ShowResultScreenState createState() => _ShowResultScreenState();
}

class _ShowResultScreenState extends State<ShowResultScreen> {
  final BannerAdController bannerAdController = Get.find<BannerAdController>();
  final interstitialAdController = Get.find<InterstitialAdController>();

  List<Map<String, dynamic>> deviceList = [];
  bool isBannerVisible = true;


  @override
  void initState() {
    super.initState();
    fetchStoredData();
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

  Future<void> fetchStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataStrings = prefs.getStringList('device_data') ?? [];
    List<Map<String, dynamic>> devices = [];

    for (String data in dataStrings) {
      try {
        final map = json.decode(data) as Map<String, dynamic>;
        devices.add(map);
      } catch (e) {
        print('Error parsing device data: $e');
      }
    }

    setState(() {
      deviceList = devices;
    });
  }

  Future<void> deleteDeviceData(String deviceName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> existingData = prefs.getStringList('device_data') ?? [];

    // Find all entries that match the device name and remove them
    existingData.removeWhere((data) {
      try {
        final map = json.decode(data) as Map<String, dynamic>;
        return map['deviceName'] == deviceName;
      } catch (e) {
        return false;
      }
    });

    await prefs.setStringList('device_data', existingData);
    await fetchStoredData(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Electricity Consumption Result',
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
        ),
      ),
      bottomNavigationBar: isBannerVisible
          ? SizedBox(width: double.infinity, child: bannerAdController.getBannerAdWidget('ad1'),)
          : SizedBox.shrink(),
      body: deviceList.isEmpty
          ? Center(child: Text("No devices saved yet."))
          : SingleChildScrollView(
        child: Column(
          children: deviceList.map((device) {
            String deviceName = device['deviceName'] ?? 'Unknown Device';
            int watt = int.tryParse(device['watt']?.toString() ?? '0') ?? 0;
            int quantity = int.tryParse(device['quantity']?.toString() ?? '1') ?? 1;
            int dailyUsage = int.tryParse(device['dailyUsage']?.toString() ?? '1') ?? 1;
            double energyConsumed = (watt * dailyUsage * quantity) / 1000;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        children: [
                          tableHeader('Device'),
                          tableHeader('Power'),
                          tableHeader('Qty'),
                          tableHeader('Hrs'),
                        ],
                      ),
                      TableRow(
                        children: [
                          tableCell(deviceName),
                          tableCell('$watt W'),
                          tableCell('$quantity'),
                          tableCell('$dailyUsage'),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: Text(
                              'Energy Consumed: ${energyConsumed.toStringAsFixed(2)} kWh',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.green.shade100.withOpacity(0.6),
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.deepOrange),
                            onPressed: () => deleteDeviceData(deviceName),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
