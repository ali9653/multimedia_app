import 'package:get/get.dart';

class ScreenUtils {
  static double _screenHeight = Get.height;
  static double _screenWidth = Get.width;

  static double deviceHeight(double i) {
    return _screenHeight * i / 100;
  }

  static double deviceWidth(double i) {
    return _screenWidth * i / 100;
  }

  static double fontSize(double i) {
    return _screenWidth / 100 * (i / 3);
  }

  static double statusBarHeight () {
    return Get.statusBarHeight;
  }
}
