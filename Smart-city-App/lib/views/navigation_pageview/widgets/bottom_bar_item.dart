import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

final class BottomBarItems {
  static final List<String> _bottomIconPath = [
    'home.png',
    'traffic-park_1.png',
    'pharmacy.png',
    'message.png'
  ];

  static List<BottomBarItem> bottomBarItems = List.generate(
    _bottomIconPath.length,
    (index) => BottomBarItem(
      activeItem: Image.asset(
        'assets/icons/${_bottomIconPath[index]}',
      ),
      inActiveItem: Image.asset(
        opacity: const AlwaysStoppedAnimation<double>(0.4),
        'assets/icons/${_bottomIconPath[index]}',
      ),
    ),
  );
}
