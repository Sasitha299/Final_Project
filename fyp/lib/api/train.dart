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
  final String fromStation;
  final String toStation;
  final String originDepartureTime;
  final String destinationArrivalTime;
  final String expectedSeries;
  final String expectedClass;
  final String activeStatus;
  final String remarks;
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
    required this.fromStation,
    required this.toStation,
    required this.originDepartureTime,
    required this.destinationArrivalTime,
    required this.expectedSeries,
    required this.expectedClass,
    required this.activeStatus,
    required this.remarks,
    this.currentStation,
    this.currentStationTime,
    this.nextStation,
    this.nextStationTime,
  });

  factory Train.fromJson(Map<String, dynamic> json) {
    final departureStation = json['fromStation']?.toString() ??
        json['departure']?.toString() ??
        '';
    final destinationStation = json['toStation']?.toString() ??
        json['destination']?.toString() ??
        '';
    final departureTimeValue = json['originDepartureTime']?.toString() ??
        json['departureTime']?.toString() ??
        '';
    final arrivalTimeValue = json['destinationArrivalTime']?.toString() ??
        json['arrivalTime']?.toString() ??
        '';

    return Train(
      id: json['_id']?.toString() ?? '',
      trainNumber: json['trainNumber']?.toString() ?? '',
      trainName: json['trainName']?.toString() ?? '',
      line: json['line']?.toString() ?? '',
      trainType: json['trainType']?.toString() ?? '',
      fromStation: departureStation,
      toStation: destinationStation,
      originDepartureTime: departureTimeValue,
      destinationArrivalTime: arrivalTimeValue,
      expectedSeries: json['expectedSeries']?.toString() ?? '',
      expectedClass: json['expectedClass']?.toString() ?? '',
      activeStatus: json['activeStatus']?.toString() ?? '',
      remarks: json['remarks']?.toString() ?? '',
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
      'fromStation': fromStation,
      'toStation': toStation,
      'originDepartureTime': originDepartureTime,
      'destinationArrivalTime': destinationArrivalTime,
      'expectedSeries': expectedSeries,
      'expectedClass': expectedClass,
      'activeStatus': activeStatus,
      'remarks': remarks,
      'departure': fromStation,
      'destination': toStation,
      'departureTime': originDepartureTime,
      'arrivalTime': destinationArrivalTime,
      'currentStation': currentStation,
      'currentStationTime': currentStationTime,
      'nextStation': nextStation,
      'nextStationTime': nextStationTime,
    };
  }

  String get departure => fromStation;
  String get destination => toStation;
  String get departureTime => originDepartureTime;
  String get arrivalTime => destinationArrivalTime;

  String get route => '${departure.toUpperCase()} → ${destination.toUpperCase()}';
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

/// Fetches trains from the backend and returns only trains for the given line.
Future<Map<String, dynamic>> fetchTrainsByLine(String line) async {
  final allResult = await fetchAllTrains();
  if (allResult['success'] == true && allResult['data'] is List<Train>) {
    final lowerLine = line.toLowerCase();
    final trains = (allResult['data'] as List<Train>).where((train) {
      final trainLine = train.line.toLowerCase();
      return trainLine.contains(lowerLine);
    }).toList();
    return {'success': true, 'data': trains};
  }
  return allResult;
}
