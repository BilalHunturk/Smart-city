import 'package:bocekilaclama/core/base/base_models.dart';
import 'package:bocekilaclama/models/time_model/response_time.dart';

class PharmacyModel extends IBaseModel {
  final List<Pharmacy>? pharmacies;

  PharmacyModel({
    this.pharmacies,
  });

  Map<String, dynamic> toJson() => {
        "pharmacies": pharmacies == null
            ? []
            : List<dynamic>.from(pharmacies!.map((x) => x.toJson())),
      };

  @override
  fromJson(Map<String, dynamic> json) => PharmacyModel(
        pharmacies: json["pharmacies"] == null
            ? []
            : List<Pharmacy>.from(
                json["pharmacies"]!.map((x) => Pharmacy.fromJson(x))),
      );
}

class Pharmacy {
  final int? pharmacyId;
  final double? pharmacyLatitude;
  final String? pharmacyLocation;
  final double? pharmacyLongitude;
  final String? pharmacyName;
  final bool? pharmacyOnDuty;
  final WorkTime? workTime;
  final int? workTimeId;

  Pharmacy({
    this.pharmacyId,
    this.pharmacyLatitude,
    this.pharmacyLocation,
    this.pharmacyLongitude,
    this.pharmacyName,
    this.pharmacyOnDuty,
    this.workTime,
    this.workTimeId,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) => Pharmacy(
        pharmacyId: json["pharmacy_id"],
        pharmacyLatitude: json["pharmacy_latitude"]?.toDouble(),
        pharmacyLocation: json["pharmacy_location"],
        pharmacyLongitude: json["pharmacy_longitude"]?.toDouble(),
        pharmacyName: json["pharmacy_name"],
        pharmacyOnDuty: json["pharmacy_on_duty"],
        workTime: json["work_time"] == null
            ? null
            : WorkTime.fromJson(json["work_time"]),
        workTimeId: json["work_time_id"],
      );

  Map<String, dynamic> toJson() => {
        "pharmacy_id": pharmacyId,
        "pharmacy_latitude": pharmacyLatitude,
        "pharmacy_location": pharmacyLocation,
        "pharmacy_longitude": pharmacyLongitude,
        "pharmacy_name": pharmacyName,
        "pharmacy_on_duty": pharmacyOnDuty,
        "work_time": workTime?.toJson(),
        "work_time_id": workTimeId,
      };
}
