import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<void> registerUser({
    required String email,
    required String name,
    required String password,
    required String character,
  }) async {
    final url = Uri.parse('http://localhost:8083/user/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'name': name,
        'password': password,
        'character': character,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('회원가입 성공: ${data['message']}');
    } else {
      print('회원가입 실패: ${response.statusCode} ${response.body}');
    }
  }
}
