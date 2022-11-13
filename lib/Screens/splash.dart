import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/Screens/Sign/signIn.dart';
import 'package:todo_app/Screens/testScreen.dart';
import 'package:todo_app/pageTrasition.dart';
import 'firstScreen.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    waitCheck();
  }

  waitCheck() async {
    await auth.checkTheUser();
    await Future.delayed(Duration(seconds: 3));
    Get.to(FirstScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/todoload.json",
        ),
      ),
    );
  }
}
