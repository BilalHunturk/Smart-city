import 'package:bocekilaclama/models/pharmacy_model/response_pharmacy.dart';
import 'package:bocekilaclama/services/export.dart';

class PharmaciesService extends FecthApi {
  @override
  Future<PharmacyModel?> fecthData() async {
    return await NetworkService.instance
        .http(EndpointConstants.pharmacies, PharmacyModel(), Methods.get);
  }
}
