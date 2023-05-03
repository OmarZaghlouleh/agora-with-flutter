import 'package:permission_handler/permission_handler.dart';
import 'package:video_call_app/utils/functions/debug_print.dart';

Future<void> handlePermission({required Permission permission}) async {
  final result = await permission.request();
  debugLog(message: "Permission State: ${result.name}");
}
