import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mvvm_project_1/app/di.dart';
import 'package:mvvm_project_1/presentation/resources/language_manager.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
        supportedLocales: const <Locale>[
          ARABIC_LOCALE,
          ENGLISH_LOCALE,
        ],
        fallbackLocale: ENGLISH_LOCALE,
        path: ASSET_PATH_LOCALIZATION,
        child: Phoenix(
          child: MyApp(),
        )),
  );
}
