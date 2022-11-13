import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Page;

  CustomPageRoute({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = 0.0;
              var end = 1.0;
              var tween = Tween(begin: begin, end: end);
              var curve =
                  CurvedAnimation(parent: animation, curve: Curves.easeInBack);

              return ScaleTransition(
                scale: tween.animate(curve),
                child: child,
              );
            });
}
