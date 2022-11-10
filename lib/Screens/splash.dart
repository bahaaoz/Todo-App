import 'package:flutter/material.dart';
import 'package:todo_app/Screens/Sign/signIn.dart';

import 'firstScreen.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    auth.checkTheUser();
    
    return const FirstScreen();
  }
}
