import 'package:to_do_app/common/helpers/failure.dart';

class WeatherFailure extends Failure {
  final Object error;
  const WeatherFailure(this.error);
}
