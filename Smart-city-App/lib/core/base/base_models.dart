abstract class IBaseModel<T> {
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}

abstract class FecthApi<T extends IBaseModel> {
  Future<T?> fecthData();
}
