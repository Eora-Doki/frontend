import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
        Uri.parse('http://0.0.0.0:8083/users/register'),
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

  static Future<bool> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://0.0.0.0:8083/users/login'),
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
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('accessToken', data['Authorization']);
        await prefs.setString('userId', data['id']);

        print('로그인 성공!');
        return true;
      } else {
        print('로그인 실패: ${response.body}');
        return false;
      }
    } catch (e) {
      print('로그인 오류: $e');
      return false;
    }
  }

  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static Future<bool> resetPassword(String email, String password) async {
    try {
      final token = await secureStorage.read(key: 'access_token');
      final userId = await secureStorage.read(key: 'user_id');

      final response = await http.patch(
        Uri.parse('http://0.0.0.0:8083/users/$userId/password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
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

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
