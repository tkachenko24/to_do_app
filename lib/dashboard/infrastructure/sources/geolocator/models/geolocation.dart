class GeolocationModel {
  final String lon;
  final String lat;

  const GeolocationModel({
    required this.lon,
    required this.lat,
  });

  factory GeolocationModel.empty() {
    return const GeolocationModel(
      lon: '',
      lat: '',
    );
  }
}
