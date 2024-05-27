import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bocekilaclama/core/constants/color_constants.dart';
import 'package:bocekilaclama/views/comment_view/comment_view.dart';
import 'package:bocekilaclama/views/home_view/home_view.dart';
import 'package:bocekilaclama/views/navigation_pageview/widgets/bottom_bar_item.dart';
import 'package:bocekilaclama/views/pharmacy_view/pharmacy_view.dart';
import 'package:bocekilaclama/views/traffic_view/traffic_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class NavigationPageview extends StatelessWidget {
  NavigationPageview({super.key});
  final NotchBottomBarController _notchBottomBarController =
      NotchBottomBarController();
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorConstants.scaffoldBackgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) => _notchBottomBarController.jumpTo(value),
        children: const [
          HomeView(),
          TrafficView(),
          PharmacyView(),
          CommentView(),
        ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        color: ColorConstants.whiteColor,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        blurFilterX: 2,
        blurFilterY: 2,
        blurOpacity: 0.7,
        shadowElevation: 3,
        removeMargins: false,
        bottomBarWidth: Get.width,
        showShadow: true,
        durationInMilliSeconds: 125,
        itemLabelStyle: const TextStyle(fontSize: 10),
        elevation: 0.3,
        bottomBarItems: BottomBarItems.bottomBarItems,
        kIconSize: 25,
        notchBottomBarController: _notchBottomBarController,
        kBottomRadius: 25.r,
        onTap: (value) {
          _pageController.jumpToPage(value);
        },
      ),
    );
  }
}
