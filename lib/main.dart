import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/utils/strings.dart';
import 'package:video_call_app/view%20model/call_view_model.dart';
import 'package:video_call_app/view%20model/landpage_view_model.dart';
import 'package:video_call_app/view/landpage_view.dart';

void main() {
  runApp(const CallingApp());
}

class CallingApp extends StatelessWidget {
  const CallingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LandPageViewModel()),
        ChangeNotifierProvider(create: (context) => CallPageViewModel()),
      ],
      child: const MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        home: LandPage(),
      ),
    );
  }
}
