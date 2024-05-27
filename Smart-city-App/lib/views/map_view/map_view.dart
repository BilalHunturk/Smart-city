import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/views/traffic_view/traffic_view.dart';
import 'package:bocekilaclama/views/widgets/custom_app_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

typedef HitValue = ({String? title, String? subtitle}); // ?

class MapPageView extends StatelessWidget {
  HitValue hitvalue = (subtitle: "", title: "");

  List<LatLng> points = Get.arguments;

  final _circlesRaw = <CircleMarker>[
    CircleMarker(
      point: const LatLng(51.5, -0.09),
      color: Colors.white.withOpacity(0.7),
      borderColor: Colors.black,
      borderStrokeWidth: 2,
      useRadiusInMeter: false,
      radius: 100,
    ),
    CircleMarker(
      point: const LatLng(51.5, -0.09),
      color: Colors.black.withOpacity(0.8),
      borderColor: Colors.black,
      borderStrokeWidth: 2,
      useRadiusInMeter: false,
      radius: 50,
    ),
    CircleMarker(
      point: const LatLng(51.5, -0.09),
      // Dorney Lake is ~2km long
      color: Colors.green.withOpacity(0.7),
      borderColor: Colors.black,
      borderStrokeWidth: 2,
      useRadiusInMeter: false,
      radius: 125,
    ),
    CircleMarker(
      point: const LatLng(51.5, -0.09),
      color: Colors.black.withOpacity(0.8),
      borderColor: Colors.black,
      borderStrokeWidth: 2,
      useRadiusInMeter: false,
      radius: 50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _markerRaw = <Marker>[
      Marker(
          child: SvgPicture.asset(
            "assets/icons/location-pin.svg",
            color: ColorConstants.secondary,
          ),
          point: points.first),
      Marker(
          child: SvgPicture.asset(
            "assets/icons/location-pin.svg",
            color: ColorConstants.secondary,
          ),
          point: points.last),
    ];

    return Scaffold(
      appBar: CustomAppBar(text: "MAP"),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: points.first,
          initialZoom: 11,
        ),
        children: [
          openStreetMapTileLayer,
          PolylineLayer(
            polylineCulling: true,
            polylines: [
              Polyline(
                  points: points,
                  color: ColorConstants.blueColor,
                  strokeWidth: 4,
                  strokeCap: StrokeCap.round,
                  isDotted: false),
            ],
          ),
          MarkerLayer(
              rotate: true, alignment: Alignment.center, markers: _markerRaw),
        ],
      ),
    );
  }

  void _openTouchedCirclesModal(
    String eventType,
    List<HitValue> tappedCircles,
    LatLng coords,
  ) {
    showModalBottomSheet<void>(
      context: Get.context!,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tapped Circle(s)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '$eventType at point: (${coords.latitude.toStringAsFixed(6)}, ${coords.longitude.toStringAsFixed(6)})',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final tappedLineData = tappedCircles[index];
                  return ListTile(
                    leading: index == 0
                        ? const Icon(Icons.vertical_align_top)
                        : index == tappedCircles.length - 1
                            ? const Icon(Icons.vertical_align_bottom)
                            : const SizedBox.shrink(),
                    title: Text(tappedLineData.title!),
                    subtitle: Text(tappedLineData.subtitle!),
                    dense: true,
                  );
                },
                itemCount: tappedCircles.length,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
