import 'package:bocekilaclama/controllers/parks_controller/parks_controller.dart';
import 'package:bocekilaclama/controllers/traffics_controller/traffics_controller.dart';
import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/views/traffic_view/traffic_view.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ParkTrafficWidget extends StatelessWidget {
  ParkTrafficWidget({super.key});

  final MapController controller = MapController();

  @override
  Widget build(BuildContext context) {
    final ParksController parksController = Get.find();
    final TrafficsController trafficsController = Get.find();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height,
                child: FlutterMap(
                  mapController: controller,
                  options: MapOptions(
                    minZoom: 1,
                    initialCenter: LatLng(
                        parksController.parks.first.station!.stationLatitude!,
                        parksController.parks.first.station!.stationLongitude!),
                    initialZoom: 13,
                  ),
                  children: [
                    openStreetMapTileLayer,
                    Obx(
                      () => parksController.isloading.value
                          ? Container()
                          : MarkerLayer(
                              markers: parksController.parks
                                  .map((e) => Marker(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/icons/park_maker.svg",
                                            color: e.parkFull! < 5
                                                ? Colors.green.withOpacity(0.7)
                                                : Colors.green.withOpacity(1),
                                          ),
                                        ),
                                        point: LatLng(
                                            e.station!.stationLatitude!,
                                            e.station!.stationLongitude!),
                                      ))
                                  .toList()),
                    ),
                    GetBuilder<TrafficsController>(builder: (controller) {
                      var spolylines = trafficsController.routpointsMap.entries
                          .map((e) => Polyline(
                                points: e.value,
                                color: e.key < 0.6
                                    ? Colors.red.withOpacity(0.7)
                                    : Colors.red,
                                strokeWidth: 4,
                                strokeCap: StrokeCap.round,
                              ))
                          .toList();
                      return trafficsController.routpointsTraffic.isEmpty
                          ? Container()
                          : PolylineLayer(
                              polylineCulling: true,
                              polylines: spolylines,
                            );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
