import 'package:bocekilaclama/views/traffic_view/pages/park_widget.dart';
import 'package:bocekilaclama/views/traffic_view/widgets/traffic_view_app_bar.dart';
import 'package:bocekilaclama/views/traffic_view/pages/transport_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class TrafficView extends StatefulWidget {
  const TrafficView({super.key});

  @override
  State<TrafficView> createState() => _TrafficViewState();
}

class _TrafficViewState extends State<TrafficView>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarTraffic(
          tabController: _tabController,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [const TransportView(), ParkTrafficWidget()],
        ));
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
