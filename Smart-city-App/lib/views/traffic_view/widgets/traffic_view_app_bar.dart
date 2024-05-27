import 'package:bocekilaclama/export.dart';

class CustomAppBarTraffic extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarTraffic({super.key, required this.tabController});

  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      color: ColorConstants.secondary.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TabBar(
            controller: tabController,
            dividerColor: ColorConstants.blueColor.withOpacity(0.2),
            automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(
                child: Center(child: UiHelper.appText("Public Transport")),
              ),
              Tab(
                child: UiHelper.appText("Park & Traffic"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, 150.h);
}
