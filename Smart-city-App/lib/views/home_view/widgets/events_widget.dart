import 'package:bocekilaclama/controllers/events_controller/events_controller.dart';
import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/models/event_model/response_event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class Events extends GetView<EventController> {
  const Events({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.status.value
          ? SizedBox(
              height: 300, child: Center(child: UiHelper.showWaitingData()))
          : EventsWidget(eventModel: controller.eventModel),
    );
  }
}

class EventsWidget extends StatelessWidget {
  const EventsWidget({super.key, required this.eventModel});
  final List<Event>? eventModel;
  @override
  Widget build(BuildContext context) {
    return GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 0.w,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 24.w,
            childAspectRatio: 160.w / 200.h,
            mainAxisSpacing: 12.h,
            crossAxisCount: 2),
        children: [
          ...List.generate(
            eventModel!.length,
            (index) => Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 7,
                    )
                  ],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      opacity: 1,
                      image: CachedNetworkImageProvider(
                          eventModel![index].eventPhoto!)),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent.withOpacity(0.01),
                            ColorConstants.secondary.withOpacity(0.7)
                          ],
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 50.h,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            UiHelper.appText(eventModel![index].eventName!,
                                color: ColorConstants.whiteColor),
                            UiHelper.appText(
                                eventDateFormat.format(eventModel![index]
                                    .workTime!
                                    .workTimeStart!),
                                color: ColorConstants.whiteColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filled(
                        style: IconButton.styleFrom(
                            backgroundColor: Color(0xFFF7AF5E)),
                        color: ColorConstants.whiteColor,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/favorite.svg",
                          color: ColorConstants.whiteColor,
                          height: 20,
                          width: 20,
                        )),
                  )
                ],
              ),
            ),
          )
        ]);
  }
}

DateFormat get eventDateFormat => DateFormat("dd MMMM\n HH:mm");
