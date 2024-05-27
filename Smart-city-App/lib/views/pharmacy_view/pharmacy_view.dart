import 'package:bocekilaclama/controllers/pharmacy_controller/pharmacy_controller.dart';
import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/views/traffic_view/traffic_view.dart';
import 'package:bocekilaclama/views/widgets/custom_app_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class PharmacyView extends GetView<PharmaciesController> {
  const PharmacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Pharmacy",
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Obx(
          () => controller.isLoading.value
              ? UiHelper.showWaitingData()
              : Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          height: Get.height,
                          width: Get.width,
                          color: ColorConstants.blackColor,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 12.h, left: 8.w, right: 8.w),
                              child: ListView.separated(
                                  itemBuilder: (context, index) => Container(
                                        decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                opacity: 0.08,
                                                image: AssetImage(
                                                    "assets/images/eczane.png"),
                                                fit: BoxFit.cover),
                                            color: ColorConstants.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                        height: 100,
                                        width: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            UiHelper.appText(
                                                controller.pharmacies[index]
                                                    .pharmacyName!,
                                                index: 1),
                                            Container(
                                              padding: EdgeInsets.all(5.w),
                                              decoration: BoxDecoration(
                                                  color: controller
                                                          .pharmacies[index]
                                                          .pharmacyOnDuty!
                                                      ? Colors.green
                                                      : ColorConstants
                                                          .secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.w)),
                                              child: UiHelper.appText(
                                                  controller.pharmacies[index]
                                                          .pharmacyOnDuty!
                                                      ? "Open"
                                                      : "Close",
                                                  color: ColorConstants
                                                      .whiteColor),
                                            ),
                                            UiHelper.appText(controller
                                                .pharmacies[index]
                                                .pharmacyLocation!),
                                            UiHelper.appText(
                                                "${pharmacyDateFormat.format(controller.pharmacies[index].workTime!.workTimeStart!)}-${pharmacyDateFormat.format(controller.pharmacies[index].workTime!.workTimeEnd!)}"),
                                          ],
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      UiHelper.defaultSpaceHeight,
                                  itemCount: controller.pharmacies.length)),
                        )),
                    Expanded(
                        flex: 7,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: controller.routpointsPharmacy!,
                            initialZoom: 13,
                          ),
                          children: [
                            openStreetMapTileLayer,
                            MarkerLayer(
                                markers: controller.pharmacies
                                    .map(
                                      (e) => Marker(
                                          child: CircleAvatar(
                                              child: Image.asset(
                                                  "assets/images/eczane.png")),
                                          point: LatLng(e.pharmacyLatitude!,
                                              e.pharmacyLongitude!)),
                                    )
                                    .toList())
                          ],
                        ))
                  ],
                ),
        ),
      ),
    );
  }
}

DateFormat get pharmacyDateFormat => DateFormat("HH:mm");
