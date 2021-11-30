import 'dart:async';
import 'package:flutter/material.dart';

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

  bool get isInitialized => initialized;
  bool get isLoggedIn => loggedIn;
  bool get isOnboardingComplete => onboardingComplete;
  int get getSelectedTab => selectedTab;

  void initializeApp() {
    Timer(const Duration(milliseconds: 2000), () {
      initialized = true;
      notifyListeners();
    });
  }

  void login(String username, String password) {
    loggedIn = true;
    notifyListeners();
  }

  void completeOnBoarding() {
    onboardingComplete = true;
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

  void logout() {
    loggedIn = false;
    onboardingComplete = false;
    initialized = false;
    selectedTab = 0;

    initializeApp();
    notifyListeners();
  }
}
