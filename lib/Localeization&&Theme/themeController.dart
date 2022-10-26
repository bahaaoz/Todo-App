import 'package:flutter/material.dart';
import 'package:todo_app/DataContoller/todo.dart';
import 'package:todo_app/main.dart';
import '../SupabaseManager/supabaseManager.dart';

class ThemeController extends ChangeNotifier {
//theme _____________________________________
  bool get themeToggle => sharedPreferences!.getBool("theme") ?? false;

  void clickThemeToggle() {
    sharedPreferences!.setBool("theme", !themeToggle);
    notifyListeners();
  }

  void clickDoneToggle(Todo todo) {
    todo.todoDone = !todo.todoDone!;
    notifyListeners();
  }
//.........................................

}
