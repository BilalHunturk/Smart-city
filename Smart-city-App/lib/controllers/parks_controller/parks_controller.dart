import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/models/park_model/response_park.dart';
import 'package:bocekilaclama/services/file.dart';

class ParksController extends GetxController implements ParksService {
  RxBool isloading = true.obs;

  final List<Park> parks = [];

  final ParksService _parksService = ParksService();

  @override
  void onInit() async {
    await fecthData();
    isloading.value = false;
    super.onInit();
  }

  @override
  Future<ParkModel?> fecthData() async {
    ParkModel? response = await _parksService.fecthData();
    parks.addAll(response!.parks!);
    return null;
  }
}
