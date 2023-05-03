// ignore_for_file: use_build_context_synchronously

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call_app/api_services/token.dart';
import 'package:video_call_app/utils/agora_configs.dart';
import 'package:video_call_app/utils/functions/debug_print.dart';

class CallPageViewModel with ChangeNotifier {
  String _channelName = "";
  int? _remoteUid;
  bool _isJoined = false;
  RtcEngine? _rtcEngine;

  Future<void> setupVideoSDKEngine(
      {required GlobalKey<ScaffoldMessengerState> key}) async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    _rtcEngine = createAgoraRtcEngine();
    await _rtcEngine!
        .initialize(const RtcEngineContext(appId: AgoraConfig.appId));

    await _rtcEngine!.enableVideo();

    // Register the event handler
    _rtcEngine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              message:
                  "Local user uid:${connection.localUid} joined the channel",
              key: key);

          _isJoined = true;
          notifyListeners();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage(
              message: "Remote user uid:$remoteUid joined the channel",
              key: key);

          _remoteUid = remoteUid;
          notifyListeners();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage(
              message: "Remote user uid:$remoteUid left the channel", key: key);

          _remoteUid = null;
          notifyListeners();
        },
      ),
    );
  }

  showMessage(
      {required String message,
      required GlobalKey<ScaffoldMessengerState> key}) {
    key.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void join({required String channelName}) async {
    await _rtcEngine!.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    final token = await Token.generateToken(channelName: channelName);

    await _rtcEngine!.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: AgoraConfig.localUid,
    );
  }

  void leave() {
    _isJoined = false;
    _remoteUid = null;
    notifyListeners();
    _rtcEngine!.leaveChannel();
  }

  @override
  void dispose() async {
    await _rtcEngine!.leaveChannel();
    _rtcEngine!.release();
    super.dispose();
  }

  String get getChannelName => _channelName;
  int? get getRemoteID => _remoteUid;
  bool get getIsJoind => _isJoined;
  RtcEngine? get getRTCEnging => _rtcEngine;
}
