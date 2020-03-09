import 'dart:math';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0, 1],
          ),
        ),
        child: Center(
          child: Image(image: AssetImage('assets/strath_logo.png'),
              height: 100,
              width: 100,
            )
        ),
      ),
    );
  }
}
