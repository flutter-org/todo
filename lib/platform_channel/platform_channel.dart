import 'package:flutter/services.dart';
import 'package:todo/model/todo.dart';

class PlatformChannel {
  static const MethodChannel _channel = MethodChannel('com.Story5.todo.channel');

  static Future<Location> getCurrentLocation() async {
    Map? locationMap = await _channel.invokeMethod<Map>('getCurrentLocation');
    return Location(
      latitude: double.parse(locationMap?['latitude']),
      longitude: double.parse(locationMap?['longitude']),
      description: locationMap?['description'],
    );
  }
}
