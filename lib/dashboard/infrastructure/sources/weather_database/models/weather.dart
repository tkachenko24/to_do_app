class WeatherModel {
  final String city;
  final String condition;
  final String temp;
  final String feelsLike;
  final String tempMin;
  final String tempMax;
  final String humidity;

  const WeatherModel({
    required this.city,
    required this.condition,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  factory WeatherModel.empty() {
    return const WeatherModel(
      city: '',
      condition: '',
      temp: '',
      feelsLike: '',
      tempMin: '',
      tempMax: '',
      humidity: '',
    );
  }
  factory WeatherModel.fromMap(Map<String, dynamic> response) {
    print(response);
    return WeatherModel(
      city: response['name'],
      condition: response['weather'][0]['description'],
      temp: response['main']['temp'].toString(),
      feelsLike: response['main']['feels_like'].toString(),
      tempMin: response['main']['temp_min'].toString(),
      tempMax: response['main']['temp_max'].toString(),
      humidity: response['main']['humidity'].toString(),
    );
  }
}
