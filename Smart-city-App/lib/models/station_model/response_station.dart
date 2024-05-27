class Station {
  final int? stationId;
  final double? stationLatitude;
  final double? stationLongitude;
  final String? stationName;

  Station({
    this.stationId,
    this.stationLatitude,
    this.stationLongitude,
    this.stationName,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        stationId: json["station_id"],
        stationLatitude: json["station_latitude"]?.toDouble(),
        stationLongitude: json["station_longitude"]?.toDouble(),
        stationName: json["station_name"],
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
        "station_latitude": stationLatitude,
        "station_longitude": stationLongitude,
        "station_name": stationName,
      };
}
