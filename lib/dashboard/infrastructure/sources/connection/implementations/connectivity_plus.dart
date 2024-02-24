import 'package:connectivity_plus/connectivity_plus.dart'; // Importing Connectivity Plus for network connectivity
import 'package:to_do_app/dashboard/infrastructure/export.dart'; // Importing dashboard infrastructure

class ConnectivityDatabaseConnectivityPlusImplementation
    extends ConnectivityDatabase {
  final Connectivity
      source; // Connectivity Plus instance for network connectivity

  ConnectivityDatabaseConnectivityPlusImplementation({
    required this.source, // Constructor requiring Connectivity Plus instance
  });

  @override
  Future<bool> persist() async {
    try {
      ConnectivityResult result =
          await source.checkConnectivity(); // Checking network connectivity
      return result !=
          ConnectivityResult.none; // Returning true if there is connectivity
    } catch (error) {
      throw WeatherException(
          error); // Throwing WeatherException in case of error
    }
  }
}
