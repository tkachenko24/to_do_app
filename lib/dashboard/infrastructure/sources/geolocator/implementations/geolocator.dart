import 'package:to_do_app/dashboard/infrastructure/export.dart'; // Importing dashboard infrastructure
import 'package:geolocator/geolocator.dart'; // Importing Geolocator for geolocation

class GeolocationDatabaseGeolocatorImplementation extends GeolocationDatabase {
  final Geolocator source; // Geolocator instance for geolocation

  GeolocationDatabaseGeolocatorImplementation({
    required this.source, // Constructor requiring Geolocator instance
  });

  @override
  Future<GeolocationModel> get() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy
              .medium); // Getting current position using Geolocator

      return GeolocationModel(
        lon: position.longitude.toString(), // Converting longitude to string
        lat: position.latitude.toString(), // Converting latitude to string
      );
    } catch (error) {
      throw GeolocatorException(
          error); // Throwing GeolocatorException in case of error
    }
  }
}
