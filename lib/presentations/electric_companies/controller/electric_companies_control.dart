import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';

class ElectricCompaniesController extends GetxController {
  final Map<String, List<Map<String, dynamic>>> regionCompanies = {
    "Punjab": [
      {"name": "MEPCO", "image": Assets.mepco.path},
      {"name": "LESCO", "image": Assets.lesco.path},
      {"name": "FESCO", "image": Assets.fesco.path},
    ],
    "Sindh": [
      {"name": "HESCO", "image": Assets.hesco.path},
      {"name": "SEPCO", "image": Assets.sepco.path},
      {"name": "K-Electric", "image": Assets.kelectric.path},
    ],
    "KPK": [
      {"name": "PESCO", "image": Assets.pesco.path},
      {"name": "TESCO", "image": Assets.teco.path},
    ],
    "Islamabad": [
      {"name": "IESCO", "image": Assets.iesco.path},
    ],
    "Balochistan": [
      {"name": "QESCO", "image": Assets.qesco.path},
    ],
  };

  List<Map<String, dynamic>> getCompaniesByRegion(String region) {
    return regionCompanies[region] ?? [];
  }
}
