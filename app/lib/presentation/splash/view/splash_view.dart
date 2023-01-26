import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/presentation/resources/assets_manager.dart';
import 'package:news_app/presentation/resources/color_manager.dart';
import 'package:news_app/presentation/resources/routes_manager.dart';
import 'package:news_app/presentation/resources/strings_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(Duration(seconds: 4), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: Container(
          width: 200,
          height: 250,
          child: Column(
            children: [
              Lottie.asset(JsonAssets.NewsLoading),
              SizedBox(
                width: 150,
                child: Image.asset(
                  ImageAssets.Egypt,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
