import 'package:to_do_app/common/helpers/export.dart';
import 'package:to_do_app/dashboard/domain/export.dart';

abstract class WeatherRepository {
  TryFuture<WeatherFailure, Weather> fetch();
}
