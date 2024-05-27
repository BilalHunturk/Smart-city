import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/models/route_model/response_route.dart';
import 'package:bocekilaclama/models/traffic_model/response_traffic.dart';
import 'package:bocekilaclama/services/file.dart';
import 'package:latlong2/latlong.dart';

class TrafficsController extends GetxController implements TrafficsService {
  RxBool isloading = true.obs;

  final List<Traffic> traffics = [];

  List<LatLng> routpointsTraffic = [];

  Map<double, List<LatLng>> routpointsMap = {};

  final TrafficsService _trafficsService = TrafficsService();

  double stationLatitude(int index, bool first) =>
      traffics[index].stations![first ? 0 : 1].stationLatitude!;

  double stationLongitude(int index, bool first) =>
      traffics[index].stations![first ? 0 : 1].stationLongitude!;

  RxDouble crowdSituation = 0.0.obs;

  @override
  void onInit() async {
    await fecthData();
    isloading.value = false;

    for (var element in traffics) {
      crowdSituation.value = element.crowdSituation!;
      await getDirectionForTraffic(traffics.indexOf(element));
    }

    update();
    super.onInit();
  }

  @override
  Future<TrafficsModel?> fecthData() async {
    TrafficsModel? response = await _trafficsService.fecthData();
    traffics.addAll(response!.traffics!);
    return null;
  }

  void addRoutePoints(List<LatLng> points) {
    int nextKey = routpointsMap.length + 1;
    routpointsMap[crowdSituation.value] = points;
  }

  @override
  Future<RouteModel> getDirection(List<LatLng> routpoints) async {
    RouteModel? response = await _trafficsService.getDirection(routpoints);
    routpointsTraffic = [];

    routpointsTraffic = response.routes!.first.geometry!.coordinates!
        .map((element) => LatLng(element.last, element.first))
        .toList();

    addRoutePoints(routpointsTraffic);
    return response;
  }

  Future getDirectionForTraffic(index) async {
    LatLng firstLatLng = LatLng(
      stationLatitude(index, true),
      stationLongitude(index, true),
    );
    LatLng lastLatLng = LatLng(
      stationLatitude(index, false),
      stationLongitude(index, false),
    );

    List<LatLng> routpoints = [firstLatLng, lastLatLng];
    print(routpoints);
    await getDirection(routpoints);
  }
}
