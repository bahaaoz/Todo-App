import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/FirebaseManager/firebaseAuthentication.dart';
import 'package:todo_app/Localeization&&Theme/themeController.dart';
import 'package:todo_app/Localeization&&Theme/myLocale.dart';
import 'package:todo_app/Localeization&&Theme/myLocaleController.dart';
import 'package:todo_app/Screens/splash.dart';
import 'DataContoller/dataController.dart';

FirebaseAuthentication _create = FirebaseAuthentication();

SharedPreferences? sharedPreferences;
String? tokenId;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    e.printError();
  }

  sharedPreferences = await SharedPreferences.getInstance();

  tokenId = sharedPreferences!.getString("token");
  if (tokenId == null) {
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
    Get.put(DataController());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeController(),
        )
      ],
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
                      titleTextStyle:
                          TextStyle(color: Color.fromARGB(255, 8, 11, 46)),
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
              body: Splash(),
            ),
          );
        },
      ),
    );
  }
}
