import 'dart:developer';

import 'package:flutter/foundation.dart';

void debugPrint({required dynamic message}) {
  if (kDebugMode) print(message);
}

void debugLog({required dynamic message}) {
  if (kDebugMode) log(message.toString());
}
