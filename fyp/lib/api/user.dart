import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/env.dart';

/// Sends signup request to backend.
/// Returns a map: {'success': bool, 'message': String?, 'data': dynamic}
Future<Map<String, dynamic>> signupUser({
  required String fullName,
  required String email,
  required String password,
  required String confirmPassword,
}) async {
  final uri = Uri.parse('${baseurl}api/auth/register');
  final body = jsonEncode({
    'fullName': fullName,
    'email': email,
    'password': password,
    'confirmPassword': confirmPassword,
  });

  try {
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    final decoded = res.body.isNotEmpty ? jsonDecode(res.body) : null;
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return {'success': true, 'data': decoded};
    }

    return {
      'success': false,
      'message': decoded is Map && decoded['message'] != null
          ? decoded['message'].toString()
          : res.reasonPhrase ?? 'Signup failed',
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
