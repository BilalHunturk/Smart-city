import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/models/route_model/response_route.dart';
import 'package:bocekilaclama/models/transportation_model/response_transportation.dart';
import 'package:bocekilaclama/services/direction_service/direction_service.dart';
import 'package:bocekilaclama/services/transportation_service/transportation_service.dart';
import 'package:latlong2/latlong.dart';

class TransportationsController extends GetxController
    implements TransPortationsService, DirectionService {
  RxBool isLoading = true.obs;

  final List<Transportation> transportations = [];
  List<LatLng> routpointsTransportation = [];

  final TransPortationsService _transPortationsService =
      TransPortationsService();
  final DirectionService _directionService = DirectionService();

  double stationLatitude(int index, bool first) =>
      transportations[index].stations![first ? 0 : 1].stationLatitude!;

  double stationLongitude(int index, bool first) =>
      transportations[index].stations![first ? 0 : 1].stationLongitude!;

  String stationName(int index, bool first) =>
      transportations[index].stations![first ? 0 : 1].stationName!;

  @override
  void onInit() async {
    await fecthData();
    isLoading.value = false;
    super.onInit();
  }

  @override
  Future<TransportationModel?> fecthData() async {
    TransportationModel? response = await _transPortationsService.fecthData();
    transportations.addAll(response!.transportations!);
    return response;
  }

  @override
  Future<RouteModel> getDirection(List<LatLng> routpoints) async {
    RouteModel? response = await _directionService.getDirection(routpoints);
    routpointsTransportation = response.routes!.first.geometry!.coordinates!
        .map((element) => LatLng(element.last, element.first))
        .toList();
    return response;
  }

  Future getDirectionForTransportation(index) async {
    LatLng firstLatLng = LatLng(
      stationLatitude(index, true),
      stationLongitude(index, true),
    );
    LatLng lastLatLng = LatLng(
      stationLatitude(index, false),
      stationLongitude(index, false),
    );
    List<LatLng> routpoints = [firstLatLng, lastLatLng];
    await getDirection(routpoints);
  }
}
