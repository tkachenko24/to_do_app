import 'package:to_do_app/common/helpers/export.dart'; // Importing common helpers
import 'package:to_do_app/dashboard/domain/export.dart'; // Importing dashboard domain
import 'package:to_do_app/dashboard/infrastructure/export.dart'; // Importing dashboard infrastructure

class WeatherRepositoryImplementation implements WeatherRepository {
  final WeatherDatabase source; // Weather database source
  final ConnectivityDatabase
      internet; // Connectivity database for internet connection
  final GeolocationDatabase geolocation; // Geolocation database
  final GeoPermission permission; // Geolocation permission

  WeatherRepositoryImplementation({
    required this.source, // Required weather database source
    required this.internet, // Required connectivity database for internet connection
    required this.geolocation, // Required geolocation database
    required this.permission, // Required geolocation permission
  });

  @override
  TryFuture<WeatherFailure, Weather> fetch() async {
    bool geoPermissionGranted = await permission
        .getGeoAccess(); // Check if geolocation permission is granted
    bool internetConnectionPersist =
        await internet.persist(); // Check if internet connection persists

    try {
      if (geoPermissionGranted) {
        // If geolocation permission is granted
        if (internetConnectionPersist) {
          // If internet connection persists
          GeolocationModel geo = await geolocation.get(); // Get geolocation
          WeatherModel model = await source.fetch(
            // Fetch weather data using geolocation
            lat: geo.lat,
            lon: geo.lon,
          );
          return Try.success(
              Weather.fromModel(model)); // Return success with weather data
        } else {
          // If internet connection does not persist
          return Try.failed(
            const WeatherFailure(
                'internet'), // Return failure with internet connection error
          );
        }
      } else {
        // If geolocation permission is not granted
        return Try.failed(
          const WeatherFailure(
              'permission'), // Return failure with geolocation permission error
        );
      }
    } catch (err) {
      return Try.failed(
        WeatherFailure(err), // Return failure with error
      );
    }
  }
}
