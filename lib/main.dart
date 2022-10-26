import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/Localeization&&Theme/themeController.dart';
import 'package:todo_app/Localeization&&Theme/myLocale.dart';
import 'package:todo_app/Localeization&&Theme/myLocaleController.dart';
import 'package:todo_app/Screens/firstScreen.dart';

import 'DataContoller/dataController.dart';

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Supabase.initialize(
    //i can use (dotenv) for hiden the key
    url: 'https://atuvspqmdrktudsqmtqc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0dXZzcHFtZHJrdHVkc3FtdHFjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU5MTE3MjQsImV4cCI6MTk4MTQ4NzcyNH0.J9Yh0Qcwuti5ubtSRHNPVVqKneXzaMMtw9ZM6Q1BDkY',
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    MyLocaleController getController = Get.put(MyLocaleController());
    final controller = Get.put(DataController());
    return ChangeNotifierProvider(
      create: (context) => ThemeController(),
      child: Consumer<ThemeController>(
        builder: (context, controller, child) {
          return GetMaterialApp(
            locale: getController.initLocale,
            translations: MyLocal(),
            theme: controller.themeToggle
                ? ThemeData(
                    brightness: Brightness.dark,
                    listTileTheme: const ListTileThemeData(
                      tileColor: Color.fromARGB(255, 74, 74, 74),
                    ),
                  )
                : ThemeData(
                    listTileTheme: const ListTileThemeData(
                      
                      tileColor: Color.fromARGB(255, 211, 209, 209),
                    ),
                  ),
            debugShowCheckedModeBanner: false,
            home: const Scaffold(
              body: FirstScreen(),
            ),
          );
        },
      ),
    );
  }
}
