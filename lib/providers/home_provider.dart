import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  int currentIndex = 0;

  void changeTab(int index) {
    this.currentIndex = index;
    notifyListeners();
  }
}
