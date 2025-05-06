import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SubmissionStorage {
  static const String key = 'submissions';

  static Future<List<Map<String, dynamic>>> loadSubmissions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) {
      return [];
    }
    final List<dynamic> jsonData =  json.decode(jsonString);
    return jsonData.cast<Map<String, dynamic>>();
  }

  static Future<void> saveSubmissions(List<Map<String, dynamic>> submissions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(submissions);
    await prefs.setString(key, jsonString);
  }
}