import 'package:bocekilaclama/models/transportation_model/response_transportation.dart';
import 'package:bocekilaclama/services/export.dart';

class TransPortationsService extends FecthApi {
  @override
  Future<TransportationModel?> fecthData() async {
    return await NetworkService.instance.http(
        EndpointConstants.transportations, TransportationModel(), Methods.get);
  }
}
