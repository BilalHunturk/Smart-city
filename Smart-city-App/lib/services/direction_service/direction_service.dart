import 'package:bocekilaclama/models/route_model/response_route.dart';
import 'package:bocekilaclama/services/export.dart';
import 'package:latlong2/latlong.dart';

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
