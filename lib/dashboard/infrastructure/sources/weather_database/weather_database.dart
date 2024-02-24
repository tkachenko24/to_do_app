import 'package:to_do_app/dashboard/infrastructure/sources/weather_database/export.dart';

abstract class WeatherDatabase {
  Future<WeatherModel> fetch({required String lat, required String lon});
}
