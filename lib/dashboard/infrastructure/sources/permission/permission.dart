abstract class GeoPermission {
  Future<bool> getGeoAccess();
  Future<bool> given();
}
