import 'dart:collection';

import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  int currentIndex = 0;
  ListQueue<int> navigationQueue = ListQueue(0);

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Function(int)? onTapped(int index) {
    if (index == 0) {
      navigationQueue.clear();
    }
    currentIndex = index;
    navigationQueue.add(index);
    notifyListeners();
    return null;
  }

  /// Clears Provider
  void clearProvider() {
    currentIndex = 0;
    navigationQueue.clear();
    notifyListeners();
  }
}
