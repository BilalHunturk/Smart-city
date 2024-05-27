import 'package:bocekilaclama/controllers/transportation_controller/transportation_controller.dart';
import 'package:bocekilaclama/core/constants/navigation_constants.dart';
import 'package:bocekilaclama/export.dart';
import 'package:latlong2/latlong.dart';

class TransportView extends GetView<TransportationsController> {
  const TransportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Container()
          : ListView.separated(
              padding: EdgeInsets.all(12.h),
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) => Container(
                height: 170.h,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        end: Alignment.bottomRight,
                        begin: Alignment.bottomLeft,
                        colors: ColorConstants.gradient),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: ColorConstants.secondary,
                                  boxShadow: [UiHelper.defaultBoxShadow],
                                  borderRadius: BorderRadius.circular(12.r),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          ColorConstants.blackColor
                                              .withOpacity(0.8),
                                          BlendMode.srcOver),
                                      image: const NetworkImage(
                                          "https://trthaberstatic.cdn.wp.trt.com.tr/resimler/1594000/elektrikli-arac-aa-1594820.jpg"))),
                            ),
                            Center(
                                child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                UiHelper.appText(
                                    controller.transportations[index]
                                        .transportationName!,
                                    index: 1,
                                    color: ColorConstants.whiteColor),
                                UiHelper.appText(
                                    controller.transportations[index]
                                        .transportationPlaque!,
                                    index: 1,
                                    color: ColorConstants.whiteColor),
                              ],
                            )),
                          ],
                        )),
                    Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                UiHelper.appText(
                                  "(${controller.stationName(index, true)} - ${controller.stationName(index, false)})",
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await controller
                                          .getDirectionForTransportation(index);
                                      Get.toNamed(
                                          NavigationConstants.mapPageview,
                                          arguments: controller
                                              .routpointsTransportation);
                                    },
                                    child: UiHelper.appText("Click for Route",
                                        index: 1)),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(children: timeList),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              itemCount: controller.transportations.length,
              separatorBuilder: (context, index) => UiHelper.defaultSpaceHeight,
            ),
    );
  }
}

List<Widget> get timeList => [
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00',
      '20:00',
      '21:00',
      '22:00',
      '23:00'
    ]
        .map(
          (e) => Container(
            height: 24.h,
            margin: EdgeInsets.only(right: 8.w),
            decoration: BoxDecoration(
              color: ColorConstants.whiteColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Center(
                child: UiHelper.appText(e),
              ),
            ),
          ),
        )
        .toList();
