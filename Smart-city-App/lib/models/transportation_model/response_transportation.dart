import 'package:bocekilaclama/core/base/base_models.dart';
import 'package:bocekilaclama/models/station_model/response_station.dart';

class TransportationModel extends IBaseModel {
  final List<Transportation>? transportations;

  TransportationModel({
    this.transportations,
  });

  Map<String, dynamic> toJson() => {
        "transportations": transportations == null
            ? []
            : List<dynamic>.from(transportations!.map((x) => x.toJson())),
      };

  @override
  fromJson(Map<String, dynamic> json) => TransportationModel(
        transportations: json["transportations"] == null
            ? []
            : List<Transportation>.from(json["transportations"]!
                .map((x) => Transportation.fromJson(x))),
      );
}

class Transportation {
  final List<Station>? stations;
  final int? transportationId;
  final double? transportationLatitude;
  final double? transportationLongitude;
  final String? transportationName;
  final String? transportationPlaque;

  Transportation({
    this.stations,
    this.transportationId,
    this.transportationLatitude,
    this.transportationLongitude,
    this.transportationName,
    this.transportationPlaque,
  });

  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
        stations: json["stations"] == null
            ? []
            : List<Station>.from(
                json["stations"]!.map((x) => Station.fromJson(x))),
        transportationId: json["transportation_id"],
        transportationLatitude: json["transportation_latitude"]?.toDouble(),
        transportationLongitude: json["transportation_longitude"]?.toDouble(),
        transportationName: json["transportation_name"],
        transportationPlaque: json["transportation_plaque"],
      );

  Map<String, dynamic> toJson() => {
        "stations": stations == null
            ? []
            : List<dynamic>.from(stations!.map((x) => x.toJson())),
        "transportation_id": transportationId,
        "transportation_latitude": transportationLatitude,
        "transportation_longitude": transportationLongitude,
        "transportation_name": transportationName,
        "transportation_plaque": transportationPlaque,
      };
}
