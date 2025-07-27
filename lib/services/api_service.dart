import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<bool> registerUser({
    required String email,
    required String name,
    required String password,
    required String character,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://0.0.0.0:8083/user/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
          'character': character,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('회원가입 성공: ${data['message']}');
        return true;
      } else {
        print('회원가입 실패: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      print("회원가입 오류: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://0.0.0.0:8083/user/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('로그인 성공: ${data['Authorization']}');
        return data;
      } else {
        print('로그인 실패: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print("로그인 오류: $e");
      return null;
    }
  }

  static Future<bool> resetPassword(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://0.0.0.0:8083/user/reset_password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('비밀번호 변경 성공');
        return true;
      } else {
        print('비밀번호 변경 실패: ${response.body}');
        return false;
      }
    } catch (e) {
      print('비밀번호 변경 오류: $e');
      return false;
    }
  }
}
