import 'dart:ffi';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:measurement/Login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SpashScreenState();

}

class _SpashScreenState extends State<SplashScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(splash: const SizedBox(
      width: 1000,
      height: 1200,
      child: Image(image: AssetImage("assets/Images/s.jpg"),fit:BoxFit.fill),
      ),
      nextScreen: LoginPage(),
      duration: 1500,
      backgroundColor: Colors.indigoAccent,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.rightToLeft,

    ),
    );
  }

}