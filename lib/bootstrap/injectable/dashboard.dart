import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_do_app/bootstrap/modules/export.dart';
import 'package:to_do_app/dashboard/export.dart';
import '../../dashboard/infrastructure/repositories/export.dart';
import 'injectable.dart';

class DashboardInjectable extends Injectable {
  static String dio = 'WEATHER-DIO';

  @override
  Future<void> register(GetIt it) async {
    it.registerLazySingleton<Dio>(
      () {
        Dio public = it.get<Dio>();
        Dio dio = Network.clone(public);
        return dio;
      },
      instanceName: dio,
    );

    it.registerLazySingleton<NotesDatabase>(
      () => NotesDatabaseHiveImplementation(
        storage: it.get(),
        convert: NoteConverter(),
      ),
    );

    it.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImplementation(
        source: it.get(),
        convert: NoteConverter(),
      ),
    );

    it.registerLazySingleton<WeatherDatabase>(
      () => WeatherDatabaseDioImplementation(
        client: it.get(),
      ),
    );

    it.registerLazySingleton<ConnectivityDatabase>(
      () => ConnectivityDatabaseConnectivityPlusImplementation(
        source: Connectivity(),
      ),
    );

    it.registerLazySingleton<GeolocationDatabase>(
      () => GeolocationDatabaseGeolocatorImplementation(
        source: Geolocator(),
      ),
    );

    it.registerLazySingleton<GeoPermission>(
      () => GeoPermissionPermissionHandlerImplementation(
        source: Permission.locationWhenInUse,
      ),
    );

    it.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImplementation(
        source: it.get(),
        internet: it.get(),
        geolocation: it.get(),
        permission: it.get(),
      ),
    );
  }
}
