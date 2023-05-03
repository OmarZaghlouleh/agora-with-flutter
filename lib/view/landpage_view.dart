import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:video_call_app/utils/assets.dart';
import 'package:video_call_app/utils/colors.dart';
import 'package:video_call_app/utils/strings.dart';
import 'package:video_call_app/utils/styles.dart';
import 'package:video_call_app/utils/widgets/custom_app_bar.dart';
import 'package:video_call_app/view%20model/landpage_view_model.dart';

class LandPage extends StatelessWidget {
  const LandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppStrings.appTitle),
      body: Column(
        children: [
          const Expanded(
            flex: 4,
            child: Image(
              image: AssetImage(AppAssets.landingImage),
            ),
          ),
          Expanded(
            child: Selector<LandPageViewModel,
                Tuple2<String, TextEditingController>>(
              selector: (p0, p1) => Tuple2(
                  p1.getChannelNameErrorMessage, p1.getChannelNameController),
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: value.item2,
                  decoration: InputDecoration(
                    hintText: AppStrings.channelName,
                    errorText: value.item1.isEmpty ? null : value.item1,
                  ),
                ),
              ),
            ),
          ),
          // Expanded(
          //   child:
          //       Selector<LandPageViewModel, Tuple2<ClientRoleType, Function>>(
          //     selector: (p0, p1) =>
          //         Tuple2(p1.getClientRole, p1.toggleClientRole),
          //     builder: (context, value, child) => RadioListTile(
          //       title: const Text(AppStrings.broadcaster),
          //       value: ClientRoleType.clientRoleBroadcaster,
          //       groupValue: value.item1,
          //       onChanged: (_) {
          //         value.item2(
          //             clientRoleType: ClientRoleType.clientRoleBroadcaster);
          //       },
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child:
          //       Selector<LandPageViewModel, Tuple2<ClientRoleType, Function>>(
          //     selector: (p0, p1) =>
          //         Tuple2(p1.getClientRole, p1.toggleClientRole),
          //     builder: (context, value, child) => RadioListTile(
          //       title: const Text(AppStrings.audience),
          //       value: ClientRoleType.clientRoleAudience,
          //       groupValue: value.item1,
          //       onChanged: (_) {
          //         value.item2(
          //             clientRoleType: ClientRoleType.clientRoleAudience);
          //       },
          //     ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Provider.of<LandPageViewModel>(context, listen: false)
                      .go(context: context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.go,
                      style: AppTextStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
