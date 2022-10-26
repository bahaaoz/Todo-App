import 'dart:ui';

import 'package:get/get.dart';
import 'package:todo_app/main.dart';

class MyLocaleController extends GetxController {
  Locale? get initLocale => sharedPreferences!.getString("lang") == null
      ? Get.deviceLocale
      : Locale(sharedPreferences!.getString("lang").toString());

  void changeLocale(String str) {
    Locale locale = Locale(str);
    sharedPreferences!.setString("lang", str);
    Get.updateLocale(locale);
  }
}
