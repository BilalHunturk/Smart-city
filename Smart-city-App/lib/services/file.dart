import 'package:bocekilaclama/core/base/base_models.dart';
import 'package:bocekilaclama/core/constants/endpoint_contants.dart';
import 'package:bocekilaclama/models/event_model/response_event.dart';
import 'package:bocekilaclama/models/park_model/response_park.dart';
import 'package:bocekilaclama/models/pharmacy_model/response_pharmacy.dart';
import 'package:bocekilaclama/models/route_model/response_route.dart';
import 'package:bocekilaclama/models/traffic_model/response_traffic.dart';
import 'package:bocekilaclama/models/transportation_model/response_transportation.dart';
import 'package:bocekilaclama/models/weather_model/response_weather.dart';
import 'package:bocekilaclama/services/general_service/network_service.dart';
import 'package:latlong2/latlong.dart';

Future get apiDelay => Future.delayed(const Duration(seconds: 3));

class EventService extends FecthApi {
  @override
  Future<EventModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.events, EventModel(), Methods.get);
  }
}

class WeatherService extends FecthApi {
  @override
  Future<WeatherModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.weather, WeatherModel(), Methods.get);
  }
}

class TrafficsService extends FecthApi implements DirectionService {
  @override
  Future<TrafficsModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.traffics, TrafficsModel(), Methods.get);
  }

  @override
  Future<RouteModel> getDirection(List<LatLng> routpoints) async {
    return await DirectionService().getDirection(routpoints);
  }
}

class ParksService extends FecthApi {
  @override
  Future<ParkModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.parks, ParkModel(), Methods.get);
  }
}

class TransPortationsService extends FecthApi implements DirectionService {
  @override
  Future<TransportationModel?> fecthData() async {
    return await NetworkService.instance.http(
        EndpointConstants.transportations, TransportationModel(), Methods.get);
  }

  @override
  Future<RouteModel> getDirection(List<LatLng> routpoints) async {
    return await DirectionService().getDirection(routpoints);
  }
}

class PharmaciesService extends FecthApi {
  @override
  Future<PharmacyModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.pharmacies, PharmacyModel(), Methods.get);
  }
}

class DirectionService {
  Future<RouteModel> getDirection(List<LatLng> routpoints) async {
    var v1 = routpoints.first.latitude;
    var v2 = routpoints.first.longitude;
    var v3 = routpoints.last.latitude;
    var v4 = routpoints.last.longitude;

    var url =
        'http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full';
    return await NetworkService.instance
        .http("", RouteModel(), Methods.get, anotherUrl: url);
  }
}
