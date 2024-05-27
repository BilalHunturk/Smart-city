import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/models/event_model/response_event.dart';
import 'package:bocekilaclama/services/file.dart';

class EventController extends GetxController implements EventService {
  RxBool status = true.obs;
  List<Event>? eventModel = [];
  final EventService _eventService = EventService();

  @override
  void onInit() async {
    await fecthData();
    status.value = false;
    super.onInit();
  }

  @override
  Future<EventModel?> fecthData() async {
    try {
      var responseModel = await _eventService.fecthData();
      eventModel = responseModel?.events!;
      await apiDelay;
      return null;
    } catch (e) {
      return null;
    }
  }
}
