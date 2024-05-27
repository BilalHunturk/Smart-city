import 'package:bocekilaclama/core/base/base_models.dart';

class WeatherModel extends IBaseModel {
  final List<Weather>? weather;

  WeatherModel({
    this.weather,
  });

  Map<String, dynamic> toJson() => {
        "weather": weather == null
            ? []
            : List<dynamic>.from(weather!.map((x) => x.toJson())),
      };

  @override
  fromJson(Map<String, dynamic> json) => WeatherModel(
        weather: json["weather"] == null
            ? []
            : List<Weather>.from(
                json["weather"]!.map((x) => Weather.fromJson(x))),
      );
}

class Weather {
  final DateTime? weatherDay;
  final WeatherDetail? weatherDetail;
  final int? weatherDetailId;
  final int? weatherId;
  final String? weatherLocation;

  Weather({
    this.weatherDay,
    this.weatherDetail,
    this.weatherDetailId,
    this.weatherId,
    this.weatherLocation,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        weatherDay: json["weather_day"] == null
            ? null
            : DateTime.parse(json["weather_day"]),
        weatherDetail: json["weather_detail"] == null
            ? null
            : WeatherDetail.fromJson(json["weather_detail"]),
        weatherDetailId: json["weather_detail_id"],
        weatherId: json["weather_id"],
        weatherLocation: json["weather_location"],
      );

  Map<String, dynamic> toJson() => {
        "weather_day":
            "${weatherDay!.year.toString().padLeft(4, '0')}-${weatherDay!.month.toString().padLeft(2, '0')}-${weatherDay!.day.toString().padLeft(2, '0')}",
        "weather_detail": weatherDetail?.toJson(),
        "weather_detail_id": weatherDetailId,
        "weather_id": weatherId,
        "weather_location": weatherLocation,
      };
}

class WeatherDetail {
  final int? weatherDetailId;
  final int? weatherDetailTemperature;
  final DateTime? weatherDetailTime;
  final String? weatherDetailType;

  WeatherDetail({
    this.weatherDetailId,
    this.weatherDetailTemperature,
    this.weatherDetailTime,
    this.weatherDetailType,
  });

  factory WeatherDetail.fromJson(Map<String, dynamic> json) => WeatherDetail(
        weatherDetailId: json["weather_detail_id"],
        weatherDetailTemperature: json["weather_detail_temperature"],
        weatherDetailTime: json["weather_detail_time"] == null
            ? null
            : DateTime.parse(json["weather_detail_time"]),
        weatherDetailType: json["weather_detail_type"],
      );

  Map<String, dynamic> toJson() => {
        "weather_detail_id": weatherDetailId,
        "weather_detail_temperature": weatherDetailTemperature,
        "weather_detail_time": weatherDetailTime?.toIso8601String(),
        "weather_detail_type": weatherDetailType,
      };
}
