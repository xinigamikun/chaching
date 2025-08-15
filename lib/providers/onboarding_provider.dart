import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/onboarding_service.dart';

class OnboardingProvider extends ChangeNotifier {
  late OnboardingService _onboardingService;
  bool _isInitialized = false;
  bool _onboardingCompleted = false;
  bool _featureHintsEnabled = true;

  bool get isInitialized => _isInitialized;
  bool get onboardingCompleted => _onboardingCompleted;
  bool get featureHintsEnabled => _featureHintsEnabled;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    _onboardingService = OnboardingService(prefs);
    
    _onboardingCompleted = await _onboardingService.isOnboardingCompleted();
    _featureHintsEnabled = await _onboardingService.areFeatureHintsEnabled();
    _isInitialized = true;
    
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await _onboardingService.completeOnboarding();
    _onboardingCompleted = true;
    notifyListeners();
  }

  Future<void> setFeatureHintsEnabled(bool enabled) async {
    await _onboardingService.setFeatureHintsEnabled(enabled);
    _featureHintsEnabled = enabled;
    notifyListeners();
  }

  Future<bool> hasSeenFeature(String featureId) async {
    return _onboardingService.hasSeenFeature(featureId);
  }

  Future<void> markFeatureAsSeen(String featureId) async {
    await _onboardingService.markFeatureAsSeen(featureId);
    notifyListeners();
  }

  Future<void> resetOnboarding() async {
    await _onboardingService.resetOnboarding();
    await _onboardingService.resetFeatureDiscovery();
    _onboardingCompleted = false;
    notifyListeners();
  }
}