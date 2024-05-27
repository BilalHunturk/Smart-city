import 'package:bocekilaclama/bindings/home_bindings.dart';
import 'package:bocekilaclama/core/constants/app_constants.dart';
import 'package:bocekilaclama/core/constants/navigation_constants.dart';
import 'package:bocekilaclama/core/init/helper/ui_helper.dart';
import 'package:bocekilaclama/core/init/locale/locale_manager.dart';
import 'package:bocekilaclama/core/init/navigation/navigation_service.dart';
import 'package:bocekilaclama/core/init/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.instance.preferencesInit();
  initializeDateFormatting();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle().copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  runApp(
    ScreenUtilInit(
      designSize: UiHelper.designSize,
      builder: (context, child) => GetMaterialApp(
        initialBinding: HomeBindings(),
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        getPages: NavigationService.routes,
        initialRoute: NavigationConstants.navigationPageview,
        theme: AppTheme.instance.lightTheme,
        themeMode: ThemeMode.light,
      ),
    ),
  );
}
