import 'package:to_do_app/dashboard/infrastructure/export.dart';

abstract class GeolocationDatabase {
  Future<GeolocationModel> get();
}
