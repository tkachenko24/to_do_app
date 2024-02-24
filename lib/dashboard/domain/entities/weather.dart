import 'package:to_do_app/common/export.dart';
import 'package:to_do_app/dashboard/infrastructure/sources/weather_database/models/export.dart';

class Weather extends Entity {
  final String city;
  final String condition;
  final String temp;
  final String feelsLike;
  final String tempMin;
  final String tempMax;
  final String humidity;

  const Weather({
    required this.city,
    required this.condition,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  Weather copyWith({
    final String? city,
    final String? condition,
    final String? temp,
    final String? feelsLike,
    final String? tempMin,
    final String? tempMax,
    final String? humidity,
  }) {
    return Weather(
      city: city ?? this.city,
      condition: condition ?? this.condition,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      humidity: humidity ?? this.humidity,
    );
  }

  factory Weather.empty() {
    return const Weather(
      city: '',
      condition: '',
      temp: '',
      feelsLike: '',
      tempMin: '',
      tempMax: '',
      humidity: '',
    );
  }

  factory Weather.fromModel(WeatherModel model) {
    return Weather(
      city: model.city,
      condition: model.condition,
      temp: model.temp,
      feelsLike: model.feelsLike,
      tempMin: model.tempMin,
      tempMax: model.tempMax,
      humidity: model.humidity,
    );
  }

  @override
  List<Object?> get props => [
        city,
        condition,
        temp,
        feelsLike,
        tempMin,
        tempMax,
        humidity,
      ];
}
