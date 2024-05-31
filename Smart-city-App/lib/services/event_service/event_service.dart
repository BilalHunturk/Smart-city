import 'package:bocekilaclama/models/event_model/response_event.dart';
import 'package:bocekilaclama/services/export.dart';

class EventService extends FecthApi {
  @override
  Future<EventModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.events, EventModel(), Methods.get);
  }
}
