import 'package:bocekilaclama/controllers/weather_controller/weather_controller.dart';
import 'package:bocekilaclama/export.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends GetView<WeatherController> {
  const WeatherWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? WeatherCard(itemCount: 6)
          : SizedBox(
              height: 145.h,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 125.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              color: ColorConstants.secondary.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              UiHelper.appText(
                                  "${controller.weatherList[index].weatherDetail!.weatherDetailTemperature}°C",
                                  index: 2,
                                  color: ColorConstants.whiteColor),
                              Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/${controller.weatherList[index].weatherDetail!.weatherDetailType}.svg")),
                              UiHelper.appText(
                                  DateFormat("EEE")
                                      .format(controller
                                          .weatherList[index].weatherDay!)
                                      .toUpperCase(),
                                  index: 2,
                                  color: ColorConstants.whiteColor),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => 0.w.horizontalSpace,
                  itemCount: controller.weatherList.length),
            ),
    );
  }
}

class WeatherCard extends SizedBox {
  WeatherCard({super.key, required int itemCount})
      : super(
          height: 145.h,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        height: 125.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: ColorConstants.secondary.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12.r)),
                        child: null),
                  ),
              separatorBuilder: (context, index) => 0.w.horizontalSpace,
              itemCount: itemCount),
        );
}
