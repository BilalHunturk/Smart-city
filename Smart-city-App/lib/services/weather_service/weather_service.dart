import 'package:bocekilaclama/models/weather_model/response_weather.dart';
import 'package:bocekilaclama/services/export.dart';

class WeatherService extends FecthApi {
  @override
  Future<WeatherModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.weather, WeatherModel(), Methods.get);
  }
}
