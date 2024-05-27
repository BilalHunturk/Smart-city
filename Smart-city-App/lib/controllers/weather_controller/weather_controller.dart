import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/models/weather_model/response_weather.dart';
import 'package:bocekilaclama/services/file.dart';

class WeatherController extends GetxController implements WeatherService {
  RxBool isLoading = true.obs;
  List<Weather> weatherList = [];
  final WeatherService _weatherService = WeatherService();

  @override
  void onInit() async {
    await fecthData();
    isLoading.value = false;
    super.onInit();
  }

  @override
  Future<WeatherModel?> fecthData() async {
    WeatherModel? sonuc = await _weatherService.fecthData();
    weatherList = sonuc!.weather!;
    await apiDelay;
    return null;
  }
}
