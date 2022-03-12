import 'package:dio/dio.dart';
import 'package:exam_planner/model/directions.dart';
import 'package:exam_planner/util/.env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  static Future<Directions?> getDirections(
      LatLng origin, LatLng destination) async {
    final response = await Dio().get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
      'destination': '${destination.latitude}, ${destination.longitude}',
      'key': googleAPIKey,
    });

    if (response.statusCode == 200 && response.data["status"] == "OK") {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
