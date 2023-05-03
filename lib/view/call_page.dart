import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/utils/agora_configs.dart';
import 'package:video_call_app/utils/widgets/custom_app_bar.dart';
import 'package:video_call_app/view%20model/call_view_model.dart';
import 'package:video_call_app/view%20model/landpage_view_model.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  String channelName = "";
  ClientRoleType role = ClientRoleType.clientRoleBroadcaster;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await init();
    });
    super.initState();
  }

  Future<void> init() async {
    channelName = Provider.of<LandPageViewModel>(context, listen: false)
        .getChannelNameController
        .text
        .trim();
    await Provider.of<CallPageViewModel>(context, listen: false)
        .setupVideoSDKEngine(key: scaffoldMessengerKey);
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    Provider.of<CallPageViewModel>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: customAppBar(title: 'Get started with Video Calling'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        children: [
          // Container for the local video
          Container(
            height: 240,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(child: _localPreview()),
          ),
          const SizedBox(height: 10),
          //Container for the Remote video
          Container(
            height: 240,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(child: _remoteVideo()),
          ),
          // Button Row
          Row(
            children: <Widget>[
              Expanded(
                child: Selector<CallPageViewModel, bool>(
                  selector: (p0, p1) => p1.getIsJoind,
                  builder: (context, value, child) => ElevatedButton(
                    onPressed: value
                        ? null
                        : () => {
                              Provider.of<CallPageViewModel>(context,
                                      listen: false)
                                  .join(channelName: channelName)
                            },
                    child: const Text("Join"),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Selector<CallPageViewModel, bool>(
                  selector: (p0, p1) => p1.getIsJoind,
                  builder: (context, value, child) => ElevatedButton(
                    onPressed: value
                        ? () => {
                              Provider.of<CallPageViewModel>(context,
                                      listen: false)
                                  .leave()
                            }
                        : null,
                    child: const Text("Leave"),
                  ),
                ),
              ),
            ],
          ),
          // Button Row ends
        ],
      ),
    );
  }

// Display local video preview
  Widget _localPreview() {
    if (Provider.of<CallPageViewModel>(context, listen: true).getIsJoind) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: Provider.of<CallPageViewModel>(context, listen: true)
              .getRTCEnging!,
          canvas: const VideoCanvas(uid: AgoraConfig.localUid),
        ),
      );
    } else {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo() {
    if (Provider.of<CallPageViewModel>(context, listen: true).getRemoteID !=
        null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: Provider.of<CallPageViewModel>(context, listen: true)
              .getRTCEnging!,
          canvas: VideoCanvas(
              uid: Provider.of<CallPageViewModel>(context, listen: true)
                  .getRemoteID!),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      String msg = '';
      if (Provider.of<CallPageViewModel>(context, listen: true).getIsJoind) {
        msg = 'Waiting for a remote user to join';
      }
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }
}
