import 'package:bocekilaclama/core/constants/color_constants.dart';
import 'package:bocekilaclama/core/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UiHelper {
  static const Size designSize = Size(375, 812);

  static TextStyle headline1 = TextStyle(
    fontSize: 14.sp,
    fontFamily: FontConstants.montserratMedium,
    color: ColorConstants.secondary,
  );

  static SizedBox defaultSpaceHeight = 12.h.verticalSpace;

  static SizedBox defaultSpaceWidth = 12.w.horizontalSpace;

  static Text appText(
    String text, {
    int index = 2,
    Color? color = ColorConstants.blackColor,
  }) {
    TextStyle? style;
    switch (index) {
      case 0:
        style = TextStyle(
          fontSize: 22,
          fontFamily: FontConstants.montserratMedium,
          color: color,
        );
        break;
      case 1:
        style = TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 16,
          fontFamily: FontConstants.montserratMedium,
          color: color,
        );
        break;
      case 2:
        style = TextStyle(
          fontSize: 14,
          fontFamily: FontConstants.montserratMedium,
          color: color,
        );
        break;
      default:
    }

    return Text(
      textAlign: TextAlign.center,
      text,
      style: style,
    );
  }

  static BoxShadow defaultBoxShadow = BoxShadow(
      blurRadius: 18,
      spreadRadius: 0.9,
      offset: const Offset(0, 8),
      color:
          ColorConstants.blackColor.withOpacity(0.4) //const Color(0xFF314F7C),
      );

  static void showLoadingAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: ColorConstants.gradient,
              ),
              boxShadow: [UiHelper.defaultBoxShadow],
              shape: BoxShape.circle,
            ),
            child: LottieBuilder.asset(
              'assets/animations/wait.json',
              width: 250.w,
              height: 250.w,
            ),
          ),
        );
      },
    );
  }

  static Column getDataNotFoundWidget({required String message}) {
    return Column(
      children: [
        Center(
          child: LottieBuilder.asset(
            'assets/animations/data_not_found.json',
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: FontConstants.montserratRegular,
            fontSize: 16.sp,
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  static void showWarningSnackBar(BuildContext context, String message,
      [Duration duration = const Duration(milliseconds: 3500)]) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        content: ListTile(
          leading: Icon(
            Icons.error_rounded,
            color: Colors.redAccent,
            size: 24.w,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          title: RichText(
            text: TextSpan(
              text: message,
              style: TextStyle(
                fontFamily: FontConstants.montserratRegular,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          milliseconds: 1600,
        ),
        content: ListTile(
          leading: Icon(
            Icons.thumb_up_rounded,
            color: Colors.greenAccent,
            size: 24.w,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          title: RichText(
            text: TextSpan(
              text: message,
              style: TextStyle(
                fontFamily: FontConstants.montserratRegular,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget showWaitingData() => LoadingAnimationWidget.staggeredDotsWave(
        color: ColorConstants.blueColor,
        size: 50,
      );
}
