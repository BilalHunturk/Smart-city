import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/models/pharmacy_model/response_pharmacy.dart';
import 'package:bocekilaclama/services/file.dart';
import 'package:latlong2/latlong.dart';

class PharmaciesController extends GetxController implements PharmaciesService {
  RxBool isLoading = true.obs;

  List<Pharmacy> pharmacies = [];
  LatLng? routpointsPharmacy;

  final PharmaciesService _pharmaciesService = PharmaciesService();
  @override
  void onInit() async {
    await fecthData();
    isLoading.value = false;
    super.onInit();
  }

  @override
  Future<PharmacyModel?> fecthData() async {
    PharmacyModel? response = await _pharmaciesService.fecthData();
    pharmacies = response!.pharmacies!;
    routpointsPharmacy = LatLng(pharmacies.first.pharmacyLatitude!,
        pharmacies.first.pharmacyLongitude!);
    return null;
  }
}
