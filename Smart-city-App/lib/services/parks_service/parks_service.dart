import 'package:bocekilaclama/models/park_model/response_park.dart';
import 'package:bocekilaclama/services/export.dart';

class ParksService extends FecthApi {
  @override
  Future<ParkModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.parks, ParkModel(), Methods.get);
  }
}
