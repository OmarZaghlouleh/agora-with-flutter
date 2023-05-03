import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_call_app/utils/colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle appbarTextStyle = GoogleFonts.cairo(
    color: AppColors.primaryColor,
    fontSize: 20,
  );

  static TextStyle buttonTextStyle = GoogleFonts.cairo(
    color: AppColors.buttonTextColor,
    fontSize: 20,
  );
}
