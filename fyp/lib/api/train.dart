import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/conection.dart';

/// Train model returned from the API.
class Train {
  final String id;
  final String trainNumber;
  final String trainName;
  final String line;
  final String trainType;
  final String departure;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  String? currentStation;
  String? currentStationTime;
  String? nextStation;
  String? nextStationTime;

  Train({
    required this.id,
    required this.trainNumber,
    required this.trainName,
    required this.line,
    required this.trainType,
    required this.departure,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    this.currentStation,
    this.currentStationTime,
    this.nextStation,
    this.nextStationTime,
  });

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      id: json['_id']?.toString() ?? '',
      trainNumber: json['trainNumber']?.toString() ?? '',
      trainName: json['trainName']?.toString() ?? '',
      line: json['line']?.toString() ?? '',
      trainType: json['trainType']?.toString() ?? '',
      departure: json['departure']?.toString() ?? '',
      destination: json['destination']?.toString() ?? '',
      departureTime: json['departureTime']?.toString() ?? '',
      arrivalTime: json['arrivalTime']?.toString() ?? '',
      currentStation: json['currentStation']?.toString(),
      currentStationTime: json['currentStationTime']?.toString(),
      nextStation: json['nextStation']?.toString(),
      nextStationTime: json['nextStationTime']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'trainNumber': trainNumber,
      'trainName': trainName,
      'line': line,
      'trainType': trainType,
      'departure': departure,
      'destination': destination,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'currentStation': currentStation,
      'currentStationTime': currentStationTime,
      'nextStation': nextStation,
      'nextStationTime': nextStationTime,
    };
  }

  String get route =>
      '${departure.toUpperCase()} → ${destination.toUpperCase()}';
}

/// Fetches all trains from the backend.
/// Returns a map: {'success': bool, 'message': String?, 'data': List<Train>?}
Future<Map<String, dynamic>> fetchAllTrains() async {
  final uri = Uri.parse('${baseurl}api/trains');

  try {
    final res = await http.get(uri);

    final decoded = res.body.isNotEmpty ? jsonDecode(res.body) : null;

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (decoded is Map && decoded['data'] is List) {
        final trains = (decoded['data'] as List)
            .map((e) => Train.fromJson(e as Map<String, dynamic>))
            .toList();
        return {'success': true, 'data': trains};
      }

      return {
        'success': false,
        'message': 'Unexpected response format from server.',
      };
    }

    return {
      'success': false,
      'message': decoded is Map && decoded['message'] != null
          ? decoded['message'].toString()
          : res.reasonPhrase ?? 'Failed to fetch trains',
    };
  } on SocketException catch (_) {
    return {
      'success': false,
      'message':
          'Network error: unable to reach server. Check your internet or server URL.',
    };
  } catch (e) {
    return {'success': false, 'message': e.toString()};
  }
}
