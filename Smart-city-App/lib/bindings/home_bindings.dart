import 'package:bocekilaclama/controllers/events_controller/events_controller.dart';
import 'package:bocekilaclama/controllers/parks_controller/parks_controller.dart';
import 'package:bocekilaclama/controllers/pharmacy_controller/pharmacy_controller.dart';
import 'package:bocekilaclama/controllers/traffics_controller/traffics_controller.dart';
import 'package:bocekilaclama/controllers/transportation_controller/transportation_controller.dart';
import 'package:bocekilaclama/controllers/weather_controller/weather_controller.dart';
import 'package:bocekilaclama/export.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<EventController>(EventController());
    Get.put<WeatherController>(WeatherController());
    Get.put<TrafficsController>(TrafficsController());
    Get.put<ParksController>(ParksController());
    Get.put<TransportationsController>(TransportationsController());
    Get.put<PharmaciesController>(PharmaciesController());
  }
}
