import 'package:bocekilaclama/models/traffic_model/response_traffic.dart';
import 'package:bocekilaclama/services/export.dart';

class TrafficsService extends FecthApi {
  @override
  Future<TrafficsModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.traffics, TrafficsModel(), Methods.get);
  }
}
