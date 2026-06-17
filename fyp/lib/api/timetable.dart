import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/conection.dart';

/// Timetable model - represents a train stop at a station
class Timetable {
  final String id;
  final String trainNumber;
  final String line;
  final String station;
  final String stopStatus;
  final String timeAtStation;
  final String arrivalTime;
  final String departureTime;
  final String direction;
  final List<int> runningDays;
  final String trainType;
  final String activeStatus;
  final String createdAt;
  final String updatedAt;

  Timetable({
    required this.id,
    required this.trainNumber,
    required this.line,
    required this.station,
    required this.stopStatus,
    required this.timeAtStation,
    required this.arrivalTime,
    required this.departureTime,
    required this.direction,
    required this.runningDays,
    required this.trainType,
    required this.activeStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    final runningDaysData = json['runningDays'];
    List<int> days = [];

    if (runningDaysData is List) {
      days = runningDaysData.map((e) => (e is int) ? e : int.tryParse(e.toString()) ?? 0).toList();
    }

    return Timetable(
      id: json['_id']?.toString() ?? '',
      trainNumber: json['trainNumber']?.toString() ?? '',
      line: json['line']?.toString() ?? '',
      station: json['station']?.toString() ?? '',
      stopStatus: json['stopStatus']?.toString() ?? '',
      timeAtStation: json['timeAtStation']?.toString() ?? '',
      arrivalTime: json['arrivalTime']?.toString() ?? '',
      departureTime: json['departureTime']?.toString() ?? '',
      direction: json['direction']?.toString() ?? '',
      runningDays: days,
      trainType: json['trainType']?.toString() ?? '',
      activeStatus: json['activeStatus']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'trainNumber': trainNumber,
      'line': line,
      'station': station,
      'stopStatus': stopStatus,
      'timeAtStation': timeAtStation,
      'arrivalTime': arrivalTime,
      'departureTime': departureTime,
      'direction': direction,
      'runningDays': runningDays,
      'trainType': trainType,
      'activeStatus': activeStatus,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

/// Fetches all timetable entries from the backend.
/// Returns a map with keys: 'success' (bool), 'message' (String), 'data' (List)
Future<Map<String, dynamic>> fetchAllTimetables() async {
  final uri = Uri.parse('${baseurl}api/timetables');

  try {
    final res = await http.get(uri);

    final decoded = res.body.isNotEmpty ? jsonDecode(res.body) : null;

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (decoded is Map && decoded['data'] is List) {
        final timetables = (decoded['data'] as List)
            .map((e) => Timetable.fromJson(e as Map<String, dynamic>))
            .toList();
        return {'success': true, 'data': timetables};
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
          : res.reasonPhrase ?? 'Failed to fetch timetables',
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

/// Fetches timetable entries for a specific station.
Future<Map<String, dynamic>> fetchTimetableByStation(String station) async {
  final allResult = await fetchAllTimetables();
  if (allResult['success'] == true && allResult['data'] is List<Timetable>) {
    final lowerStation = station.toLowerCase();
    final timetables = (allResult['data'] as List<Timetable>).where((entry) {
      return entry.station.toLowerCase().contains(lowerStation);
    }).toList();
    return {'success': true, 'data': timetables};
  }
  return allResult;
}

/// Fetches timetable entries for a specific line.
Future<Map<String, dynamic>> fetchTimetableByLine(String line) async {
  final allResult = await fetchAllTimetables();
  if (allResult['success'] == true && allResult['data'] is List<Timetable>) {
    final lowerLine = line.toLowerCase();
    final timetables = (allResult['data'] as List<Timetable>).where((entry) {
      return entry.line.toLowerCase().contains(lowerLine);
    }).toList();
    return {'success': true, 'data': timetables};
  }
  return allResult;
}
