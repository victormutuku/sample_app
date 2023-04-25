import 'dart:developer';

import 'package:flutter/material.dart';

class Items with ChangeNotifier {
  List<int> items = [1, 2, 3, 4, 5, 5, 6, 7, 8, 8, 8];
  List<int> sqItems = [];

  sqValues() {
    for (var element in items) {
      sqItems.add(element * element);
    }
    log("I'm Listening");
    notifyListeners();
  }
}
