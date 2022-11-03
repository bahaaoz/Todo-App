import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/FirebaseManager/firebaseAuthentication.dart';
import 'package:todo_app/FirebaseManager/firebaseManager.dart';
import 'package:todo_app/Localeization&&Theme/themeController.dart';
import 'package:todo_app/Localeization&&Theme/myLocale.dart';
import 'package:todo_app/Localeization&&Theme/myLocaleController.dart';
import 'package:todo_app/Screens/Sign/signPage.dart';
import 'package:todo_app/Screens/firstScreen.dart';
import 'package:todo_app/Screens/Sign/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'DataContoller/dataController.dart';

FirebaseAuthentication _create = FirebaseAuthentication();

SharedPreferences? sharedPreferences;
String? userUID;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  // await Supabase.initialize(
  //   //i can use (dotenv) for hiden the key
  //   url: 'https://atuvspqmdrktudsqmtqc.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0dXZzcHFtZHJrdHVkc3FtdHFjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU5MTE3MjQsImV4cCI6MTk4MTQ4NzcyNH0.J9Yh0Qcwuti5ubtSRHNPVVqKneXzaMMtw9ZM6Q1BDkY',
  // );

  userUID = sharedPreferences!.getString("user");
  print(" -------------$userUID-------------------");
  if (userUID == null) {
    await _create.signUpAnonymous();
  }

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
                    appBarTheme: const AppBarTheme(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 8, 11, 46)),
                    tabBarTheme: const TabBarTheme(
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    scaffoldBackgroundColor:
                        const Color.fromARGB(255, 8, 11, 46),
                    brightness: Brightness.dark,
                    listTileTheme: const ListTileThemeData(
                      tileColor: Color.fromARGB(255, 24, 28, 71),
                    ),
                  )
                : ThemeData(
                    appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      titleTextStyle: TextStyle(
                          color: const Color.fromARGB(255, 8, 11, 46)),
                      elevation: 0,
                      backgroundColor: Colors.white,
                    ),
                    tabBarTheme: const TabBarTheme(
                      labelColor: Colors.black,
                      indicator: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 46, 147, 231),
                          ),
                        ),
                      ),
                    ),
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
