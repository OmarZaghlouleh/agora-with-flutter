import 'dart:convert';

import 'package:http/http.dart' as http;

class Token {
  Token._();

  static Future<String> generateToken({required String channelName}) async {
    final response = await http.get(Uri.parse(
        "https://agora-token-server-6qwm.onrender.com/rtc/$channelName/publisher/uid/0/?expiry=3600"));

    final token = jsonDecode(response.body)['rtcToken'];
    return token;
  }
}
