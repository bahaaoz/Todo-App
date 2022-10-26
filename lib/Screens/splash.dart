import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/DataContoller/dataController.dart';
import 'package:todo_app/Screens/firstScreen.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final controller = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    load();
  }

  Future load() async {
   // await controller.loadControl("");
    Get.off(() => const FirstScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
