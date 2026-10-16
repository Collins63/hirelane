import 'dart:convert';

import 'package:hirelane/services/config.dart';
import 'package:http/http.dart' as http;

class Searchservice {
  
  Future<List<dynamic>> searchUsers(String query) async {
    final response = await http.get(
      Uri.parse('${Config.apiUrl}/api/users/search/$query'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('${response.body}');
    }
  }
}