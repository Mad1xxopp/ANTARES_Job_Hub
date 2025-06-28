import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationsProvider with ChangeNotifier {
  final List<String> _applications = [];

  List<String> get applications => _applications;

  Future<void> loadApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final applications = prefs.getStringList('applications') ?? [];
    _applications.addAll(applications);
    notifyListeners();
  }

  Future<void> addApplication(String specialization) async {
    if (!_applications.contains(specialization)) {
      _applications.add(specialization);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('applications', _applications);
      notifyListeners();
    }
  }

  Future<void> removeApplication(String specialization) async {
    _applications.remove(specialization);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('applications', _applications);
    notifyListeners();
  }
}