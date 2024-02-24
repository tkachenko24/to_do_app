import 'package:permission_handler/permission_handler.dart'; // Importing permission handler package
import 'package:to_do_app/dashboard/infrastructure/sources/permission/export.dart'; // Importing permissions source

class GeoPermissionPermissionHandlerImplementation extends GeoPermission {
  final Permission source; // Permission source from permission handler

  GeoPermissionPermissionHandlerImplementation({
    required this.source, // Constructor requiring permission source
  });

  @override
  Future<bool> getGeoAccess() async {
    try {
      PermissionStatus request = await source
          .request(); // Requesting permission for accessing location

      return request ==
          PermissionStatus.granted; // Returning true if permission is granted
    } catch (error) {
      throw PermissionException(
          error); // Throwing PermissionException in case of error
    }
  }

  @override
  Future<bool> given() async {
    try {
      PermissionStatus request =
          await source.status; // Getting status of permission

      return request ==
          PermissionStatus.granted; // Returning true if permission is granted
    } catch (error) {
      throw PermissionException(
          error); // Throwing PermissionException in case of error
    }
  }
}
