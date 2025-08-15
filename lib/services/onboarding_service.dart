import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _featureHintsEnabledKey = 'feature_hints_enabled';
  
  final SharedPreferences _prefs;

  OnboardingService(this._prefs);

  // Check if onboarding has been completed
  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  // Mark onboarding as completed
  Future<void> completeOnboarding() async {
    await _prefs.setBool(_onboardingCompletedKey, true);
  }

  // Reset onboarding status (for testing or user request)
  Future<void> resetOnboarding() async {
    await _prefs.setBool(_onboardingCompletedKey, false);
  }

  // Check if feature hints are enabled
  Future<bool> areFeatureHintsEnabled() async {
    return _prefs.getBool(_featureHintsEnabledKey) ?? true;
  }

  // Toggle feature hints
  Future<void> setFeatureHintsEnabled(bool enabled) async {
    await _prefs.setBool(_featureHintsEnabledKey, enabled);
  }

  // Get the last viewed help section (for resuming help documentation)
  Future<String?> getLastViewedHelpSection() async {
    return _prefs.getString('last_help_section');
  }

  // Save the last viewed help section
  Future<void> saveLastViewedHelpSection(String sectionId) async {
    await _prefs.setString('last_help_section', sectionId);
  }

  // Track feature discovery
  Future<bool> hasSeenFeature(String featureId) async {
    return _prefs.getBool('feature_seen_$featureId') ?? false;
  }

  // Mark a feature as seen
  Future<void> markFeatureAsSeen(String featureId) async {
    await _prefs.setBool('feature_seen_$featureId', true);
  }

  // Reset all feature discovery states
  Future<void> resetFeatureDiscovery() async {
    final keys = _prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith('feature_seen_')) {
        await _prefs.remove(key);
      }
    }
  }
}