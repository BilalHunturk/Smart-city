import 'package:bocekilaclama/export.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key, required String text})
      : super(
          backgroundColor: ColorConstants.secondary.withOpacity(0.1),
          title: Center(child: UiHelper.appText(text, index: 0)),
        );
}
