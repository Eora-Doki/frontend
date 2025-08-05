import 'package:http/http.dart' as http;
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

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('회원가입 성공: id=${data['id']}, email=${data['email']}');
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

  static Future<Map<String, dynamic>?> loginUser(String email, String password) async {
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
        await secureStorage.write(key: 'access_token', value: data['Authorization']);
        await secureStorage.write(key: 'user_id', value: data['id']);
        print('로그인 성공!');
        return data;
      } else {
        print('로그인 실패: ${response.body}');
        return null;
      }
    } catch (e) {
      print('로그인 오류: $e');
      return null;
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

      print('토큰: $token');
      print('아이디: $userId');

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

  Future<List<Map<String, dynamic>>> fetchStores(double latitude, double longitude) async {
    final url = Uri.parse('http://0.0.0.0:8083/stores?latitude=$latitude&longitude=$longitude');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('로드 실패: ${response.statusCode}');
    }
  }

}
