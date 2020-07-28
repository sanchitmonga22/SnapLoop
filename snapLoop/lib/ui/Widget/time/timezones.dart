import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart';
import "package:timezone/data/latest.dart";

class TimeHelperService {
  static Future<DateTime> convertToLocal(DateTime time) async {
    initializeTimeZones();
    String _timezone = await FlutterNativeTimezone.getLocalTimezone();
    if (_timezone == time.timeZoneName) {
      return time;
    }
    return TZDateTime.from(time, getLocation(_timezone));
  }
}
