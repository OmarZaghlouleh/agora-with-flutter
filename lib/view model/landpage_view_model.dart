// ignore_for_file: use_build_context_synchronously

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call_app/utils/functions/handle_permission.dart';
import 'package:video_call_app/utils/strings.dart';
import 'package:video_call_app/view/call_page.dart';

class LandPageViewModel with ChangeNotifier {
  final TextEditingController _channelNameController = TextEditingController();
  String _errorMessage = "";
  ClientRoleType _clientRoleType = ClientRoleType.clientRoleBroadcaster;

  void setErrorMessage() {
    _errorMessage = AppStrings.channelNameError;
    notifyListeners();
  }

  void toggleClientRole({required ClientRoleType clientRoleType}) {
    if (clientRoleType == _clientRoleType) return;
    _clientRoleType = clientRoleType;
    notifyListeners();
  }

  void reset() {
    _channelNameController.dispose();
    _errorMessage = "";
    _clientRoleType = ClientRoleType.clientRoleBroadcaster;
  }

  Future<void> go({required BuildContext context}) async {
    if (getChannelNameController.text.isEmpty) {
      setErrorMessage();
    } else {
      await handlePermission(permission: Permission.camera);
      await handlePermission(permission: Permission.microphone);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
              // channelName: getChannelNameController.text.trim(),
              // role: getClientRole,
              ),
        ),
      );
    }
  }

  String get getChannelNameErrorMessage => _errorMessage;
  ClientRoleType get getClientRole => _clientRoleType;
  TextEditingController get getChannelNameController => _channelNameController;
}
