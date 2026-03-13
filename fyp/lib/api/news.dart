import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/conection.dart';

/// Local news item returned from the backend.
class LocalNews {
  final String id;
  final String description;
  final String createdAt;

  LocalNews({
    required this.id,
    required this.description,
    required this.createdAt,
  });

  factory LocalNews.fromJson(Map<String, dynamic> json) {
    return LocalNews(
      id: json['_id']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }
}

/// Train alert item returned from the backend.
class TrainAlert {
  final String id;
  final String trainNumber;
  final String departure;
  final String destination;
  final String time;
  final String news;

  TrainAlert({
    required this.id,
    required this.trainNumber,
    required this.departure,
    required this.destination,
    required this.time,
    required this.news,
  });

  factory TrainAlert.fromJson(Map<String, dynamic> json) {
    return TrainAlert(
      id: json['_id']?.toString() ?? '',
      trainNumber: json['trainNumber']?.toString() ?? '',
      departure: json['departure']?.toString() ?? '',
      destination: json['destination']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      news: json['news']?.toString() ?? '',
    );
  }
}

/// Fetches local news from backend.
/// Returns a map: {'success': bool, 'message': String?, 'data': List<LocalNews>?}
Future<Map<String, dynamic>> fetchLocalNews() async {
  final uri = Uri.parse('${baseurl}api/localnews');
  try {
    final res = await http.get(uri);
    final decoded = res.body.isNotEmpty ? jsonDecode(res.body) : null;

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (decoded is Map && decoded['data'] is List) {
        final news = (decoded['data'] as List)
            .map((e) => LocalNews.fromJson(e as Map<String, dynamic>))
            .toList();
        return {'success': true, 'data': news};
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
          : res.reasonPhrase ?? 'Failed to fetch local news',
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

/// Fetches live train alerts from backend.
/// Returns a map: {'success': bool, 'message': String?, 'data': List<TrainAlert>?}
Future<Map<String, dynamic>> fetchTrainAlerts() async {
  final uri = Uri.parse('${baseurl}api/news');
  try {
    final res = await http.get(uri);
    final decoded = res.body.isNotEmpty ? jsonDecode(res.body) : null;

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (decoded is Map && decoded['data'] is List) {
        final alerts = (decoded['data'] as List)
            .map((e) => TrainAlert.fromJson(e as Map<String, dynamic>))
            .toList();
        return {'success': true, 'data': alerts};
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
          : res.reasonPhrase ?? 'Failed to fetch train alerts',
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
