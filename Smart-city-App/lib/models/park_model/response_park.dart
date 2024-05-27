import 'package:bocekilaclama/core/base/base_models.dart';
import '../station_model/response_station.dart';

class ParkModel extends IBaseModel {
  final List<Park>? parks;

  ParkModel({
    this.parks,
  });

  Map<String, dynamic> toJson() => {
        "parks": parks == null
            ? []
            : List<dynamic>.from(parks!.map((x) => x.toJson())),
      };

  @override
  fromJson(Map<String, dynamic> json) => ParkModel(
        parks: json["parks"] == null
            ? []
            : List<Park>.from(json["parks"]!.map((x) => Park.fromJson(x))),
      );
}

class Park {
  final int? parkFull;
  final int? parkId;
  final String? parkName;
  final Station? station;
  final int? stationId;

  Park({
    this.parkFull,
    this.parkId,
    this.parkName,
    this.station,
    this.stationId,
  });

  factory Park.fromJson(Map<String, dynamic> json) => Park(
        parkFull: json["park_full"],
        parkId: json["park_id"],
        parkName: json["park_name"],
        station:
            json["station"] == null ? null : Station.fromJson(json["station"]),
        stationId: json["station_id"],
      );

  Map<String, dynamic> toJson() => {
        "park_full": parkFull,
        "park_id": parkId,
        "park_name": parkName,
        "station": station?.toJson(),
        "station_id": stationId,
      };
}
