import 'package:dio/dio.dart';

import '../../shared/constants/uri.dart';
import 'network_service.dart';

class ApiService {
  final Dio dio = Dio();

  NetworkService networkService() {
    dio.options
      ..connectTimeout = const Duration(milliseconds: 50000)
      ..receiveTimeout = const Duration(milliseconds: 50000)
      ..headers = {
        "accept": "application/json",
        "Authorization": "Bearer $accessToken",
      };
    print(dio.options.headers.toString());
    return NetworkService(
      dio,
    );
  }
}
