import 'package:bocekilaclama/core/base/base_models.dart';
import 'package:bocekilaclama/models/station_model/response_station.dart';

class TrafficsModel extends IBaseModel {
  final List<Traffic>? traffics;

  TrafficsModel({
    this.traffics,
  });

  Map<String, dynamic> toJson() => {
        "traffics": traffics == null
            ? []
            : List<dynamic>.from(traffics!.map((x) => x.toJson())),
      };

  @override
  fromJson(Map<String, dynamic> json) => TrafficsModel(
        traffics: json["traffics"] == null
            ? []
            : List<Traffic>.from(
                json["traffics"]!.map((x) => Traffic.fromJson(x))),
      );
}

class Traffic {
  final double? crowdSituation;
  final int? stationId;
  final List<Station>? stations;
  final int? trafficId;

  Traffic({
    this.crowdSituation,
    this.stationId,
    this.stations,
    this.trafficId,
  });

  factory Traffic.fromJson(Map<String, dynamic> json) => Traffic(
        crowdSituation: json["crowd_situation"]?.toDouble(),
        stationId: json["station_id"],
        stations: json["stations"] == null
            ? []
            : List<Station>.from(
                json["stations"]!.map((x) => Station.fromJson(x))),
        trafficId: json["traffic_id"],
      );

  Map<String, dynamic> toJson() => {
        "crowd_situation": crowdSituation,
        "station_id": stationId,
        "stations": stations == null
            ? []
            : List<dynamic>.from(stations!.map((x) => x.toJson())),
        "traffic_id": trafficId,
      };
}
