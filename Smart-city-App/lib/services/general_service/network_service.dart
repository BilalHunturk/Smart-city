import 'dart:convert';
import 'package:bocekilaclama/core/base/base_models.dart';
import 'package:bocekilaclama/core/constants/app_constants.dart';
import 'package:http/http.dart' as https;

enum Methods {
  get,
  post,
}

class NetworkService {
  static final NetworkService _instance = NetworkService._init();
  static NetworkService get instance => _instance;

  NetworkService._init();

  Future<dynamic> http<T extends IBaseModel>(
    String path,
    IBaseModel model,
    Methods method, {
    String? anotherUrl,
    Object? body,
  }) async {
    var url = Uri.parse(anotherUrl ?? "${AppConstants.baseURL}$path");

    https.Response? response;

    switch (method) {
      case Methods.get:
        response = await https.get(url).timeout(
              const Duration(seconds: AppConstants.responseTimeout),
              onTimeout: () => https.Response('Timeout', 408),
            );
        break;
      case Methods.post:
        response = await https.post(url, body: jsonEncode(body)).timeout(
              const Duration(seconds: AppConstants.responseTimeout),
              onTimeout: () => https.Response('Timeout', 408),
            );
        break;
    }

    if (response.statusCode == 200) {
      return jsonBodyParser<T>(model, response.body);
    } else if (response.statusCode == 401) {
    } else {
      return jsonBodyParser<T>(model, response.body);
    }
  }

  dynamic jsonBodyParser<T>(IBaseModel model, String body) {
    final Map<String, dynamic> jsonBody = jsonDecode(body);
    return model.fromJson(jsonBody);
  }
}
