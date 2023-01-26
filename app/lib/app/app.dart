import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/di.dart';
import 'package:news_app/domain/provider/news.dart';
import 'package:news_app/presentation/details/view/news_details.dart';
import 'package:news_app/presentation/home/view/home_view.dart';
import 'package:news_app/presentation/resources/routes_manager.dart';
import 'package:news_app/presentation/resources/theme_manager.dart';
import 'package:news_app/presentation/splash/view/splash_view.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EGYPT 24',
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        Routes.homeRoute: (context) {
          initHomeModule();
          return HomeView();
        },
        Routes.detailsRoute: (context) {
          initDetailsModule();
          return NewsDetails();
        },
      },
    );
  }
}
