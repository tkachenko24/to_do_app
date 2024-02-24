part of 'bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeather extends WeatherEvent {
  const FetchWeather();

  @override
  List<Object?> get props => [];
}
