import 'package:bocekilaclama/core/init/helper/ui_helper.dart';
import 'package:bocekilaclama/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewStateWidget extends StatelessWidget {
  ViewStateWidget({super.key, required this.isLoading, required this.widget});
  RxBool isLoading;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return SizedBox(height: 150, child: UiHelper.showWaitingData());
      } else {
        return widget;
      }
    });
  }
}
