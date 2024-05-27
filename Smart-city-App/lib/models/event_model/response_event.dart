import 'package:bocekilaclama/core/base/base_models.dart';
import 'package:bocekilaclama/models/time_model/response_time.dart';

class EventModel extends IBaseModel {
  List<Event>? events;

  EventModel({this.events});

  @override
  fromJson(Map<String, dynamic> json) => EventModel(
      events: List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))));

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

class Event {
  final int? eventId;
  final bool? eventIsLiked;
  final String? eventLocation;
  final String? eventName;
  final String? eventPhoto;
  final WorkTime? workTime;
  final int? workTimeId;

  Event({
    this.eventId,
    this.eventIsLiked,
    this.eventLocation,
    this.eventName,
    this.eventPhoto,
    this.workTime,
    this.workTimeId,
  });

  @override
  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "event_is_liked": eventIsLiked,
        "event_location": eventLocation,
        "event_name": eventName,
        "event_photo": eventPhoto,
        "work_time": workTime?.toJson(),
        "work_time_id": workTimeId,
      };

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json["event_id"],
        eventIsLiked: json["event_is_liked"],
        eventLocation: json["event_location"],
        eventName: json["event_name"],
        eventPhoto: json["event_photo"],
        workTime: json["work_time"] == null
            ? null
            : WorkTime.fromJson(json["work_time"]),
        workTimeId: json["work_time_id"],
      );
}
