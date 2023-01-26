import 'package:flutter/material.dart';
import 'package:news_app/app/app.dart';
import 'package:news_app/app/di.dart';

void main() async {
  await initAppModule();
  runApp(MyApp());
}
