import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fooderlich/models/app_cache.dart';

class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  bool initialized = false;
  bool loggedIn = false;
  bool onboardingComplete = false;
  int selectedTab = FooderlichTab.explore;
  final appCache = AppCache();

  bool get isInitialized => initialized;
  bool get isLoggedIn => loggedIn;
  bool get isOnboardingComplete => onboardingComplete;
  int get getSelectedTab => selectedTab;

  void initializeApp() async {
    loggedIn = await appCache.isUserLoggedIn();
    onboardingComplete = await appCache.didCompleteOnboarding();

    Timer(const Duration(milliseconds: 2000), () {
      initialized = true;
      notifyListeners();
    });
  }

  void login(String username, String password) async {
    loggedIn = true;
    await appCache.cacheUser();
    notifyListeners();
  }

  void completeOnBoarding() async {
    onboardingComplete = true;
    await appCache.completeOnboarding();
    notifyListeners();
  }

  void goToTab(index) {
    selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  void logout() async {
    initialized = false;
    selectedTab = 0;

    await appCache.invalidate();

    initializeApp();
    notifyListeners();
  }
}
