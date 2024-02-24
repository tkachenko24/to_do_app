class PermissionException implements Exception {
  final Object error;
  const PermissionException(this.error);
}
