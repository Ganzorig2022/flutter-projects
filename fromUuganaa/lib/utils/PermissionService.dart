import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<bool> getPermissions() async {
    bool allGranted = true;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    statuses.values.toList().forEach(
      (permission) {
        if (permission != PermissionStatus.granted) {
          allGranted = false;
        }
      },
    );
    return Future.value(allGranted);
  }
}
