import 'package:bocekilaclama/core/constants/color_constants.dart';
import 'package:bocekilaclama/core/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._init();
  static AppTheme get instance => _instance;

  TextTheme _customLightTextTheme(TextTheme base) {
    return base.copyWith(
      bodyLarge: TextStyle(
        fontFamily: FontConstants.montserratBold,
        fontSize: 20.sp,
        color: Colors.black,
      ),
    );
  }

  AppTheme._init();

  ThemeData get lightTheme => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: ColorConstants.blueColor,
          onPrimary: ColorConstants.whiteColor,
          secondary: ColorConstants.secondary,
          onSecondary: ColorConstants.whiteColor,
          error: ColorConstants.error,
          onError: ColorConstants.whiteColor,
          background: ColorConstants.whiteColor,
          onBackground: ColorConstants.blackColor,
          surface: ColorConstants.whiteColor,
          onSurface: ColorConstants.blackColor,
        ),
        scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColor,
        textTheme: _customLightTextTheme(ThemeData.light().textTheme),
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: const ColorScheme.dark(),
        scaffoldBackgroundColor: Colors.black,
      );
}
