import 'dart:convert';

class JwtHelper {
  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    return payloadMap;
  }

  static String? getUsernameFromToken(String? token) {
    if (token == null) return null;
    try {
      final payload = parseJwt(token);
      return payload['username'] ?? payload['name'] ?? payload['email'];
    } catch (e) {
      print('Error parsing JWT: $e');
      return null;
    }
  }
}