import 'package:flutter/material.dart';
import 'package:news_app/presentation/resources/color_manager.dart';
import 'package:news_app/presentation/resources/font_manager.dart';
import 'package:news_app/presentation/resources/styles_manager.dart';
import 'package:news_app/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorManager.white,
      elevation: AppSize.s4,
      titleTextStyle: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
    ),
    textTheme: TextTheme(
      headline1:
          getSemiBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
      headline2:
          getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s18),
      headline3: getRegularStyle(
          color: ColorManager.lightBlue, fontSize: FontSize.s16),
      subtitle1: getBoldStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s12,
      ),
      bodyText1: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s14,
      ),
      bodyText2: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,
      ),
    ),
  );
}
