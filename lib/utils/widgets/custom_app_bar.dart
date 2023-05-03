import 'package:flutter/material.dart';
import 'package:video_call_app/utils/colors.dart';
import 'package:video_call_app/utils/styles.dart';

PreferredSizeWidget customAppBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: AppTextStyles.appbarTextStyle,
    ),
    backgroundColor: AppColors.appbarColor,
    elevation: 0,
    centerTitle: true,
  );
}
