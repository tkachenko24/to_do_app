part of 'bloc.dart';

class WeatherState extends Equatable {
  final Status<WeatherFailure, Weather> status;
  final Weather weather;

  const WeatherState({
    required this.status,
    required this.weather,
  });

  factory WeatherState.empty() => WeatherState(
        status: Status.empty(),
        weather: Weather.empty(),
      );

  WeatherState copyWith({
    Status<WeatherFailure, Weather>? status,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weather,
      ];
}
