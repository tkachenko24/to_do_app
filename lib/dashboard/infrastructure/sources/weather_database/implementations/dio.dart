import 'package:to_do_app/bootstrap/modules/export.dart'; // Importing app bootstrap modules
import 'package:to_do_app/dashboard/infrastructure/export.dart'; // Importing dashboard infrastructure
import 'package:dio/dio.dart'; // Importing Dio for HTTP requests

class WeatherDatabaseDioImplementation extends WeatherDatabase {
  final Dio client; // Dio client for HTTP requests

  WeatherDatabaseDioImplementation({
    required this.client, // Constructor requiring Dio client
  });

  static const String appid =
      '4bc5ef725bee86f29b7c5a7622c0900b'; // API key for weather data

  @override
  Future<WeatherModel> fetch({required String lon, required String lat}) async {
    try {
      Response response = await client.get(
          'data/2.5/weather?lat=$lat&lon=$lon&appid=$appid&units=metric'); // Making HTTP GET request to fetch weather data

      return WeatherModel.fromMap(
          response.data); // Parsing response data into WeatherModel object
    } catch (error) {
      throw WeatherException(
          error); // Throwing WeatherException in case of error
    }
  }
}
