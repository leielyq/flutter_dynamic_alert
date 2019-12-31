import 'dart:async';

import 'package:flutter/services.dart';

class FlutterLeielyqDynamicAlert {
  static const MethodChannel _channel =
      const MethodChannel('flutter_leielyq_dynamic_alert');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
