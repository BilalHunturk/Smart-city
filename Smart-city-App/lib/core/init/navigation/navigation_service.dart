import 'package:bocekilaclama/bindings/home_bindings.dart';
import 'package:bocekilaclama/core/constants/navigation_constants.dart';
import 'package:bocekilaclama/views/map_view/map_view.dart';
import 'package:bocekilaclama/views/navigation_pageview/navigation_pageview.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class NavigationService {
  static List<GetPage> routes = [
    GetPage(
      name: NavigationConstants.navigationPageview,
      page: () => NavigationPageview(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: NavigationConstants.mapPageview,
      page: () => MapPageView(),
      binding: HomeBindings(),
    ),
  ];
}
