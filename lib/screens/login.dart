import 'package:doki/screens/password.dart';
import 'package:doki/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:doki/services/api_service.dart';
import 'main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> handleLogin() async {
    final email = emailController.text;
    final password = passwordController.text;

    final token = await ApiService.loginUser(email: email, password: password);

    if (token != null) {
      print("로그인 성공: $token");
      await secureStorage.write(key: 'access_token', value: token);
      return true;
    } else {
      print("로그인 실패");
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Doki',
                style: TextStyle(
                  fontSize: 110,
                  fontFamily: 'Jersey15-Regular',
                  color: Color(0xff69BF70),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                width: 280,
                height: 420,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xffD9D9D9),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      cursorColor: const Color(0x80000000),
                      decoration: const InputDecoration(
                        labelText: '이메일',
                        labelStyle: TextStyle(
                          fontFamily: 'BlackHanSans-Regular',
                          color: Color(0x80000000),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x80000000))
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x80000000))
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      cursorColor: const Color(0x80000000),
                      decoration: const InputDecoration(
                        labelText: '비밀번호',
                        labelStyle: TextStyle(
                          fontFamily: 'BlackHanSans-Regular',
                          color: Color(0x80000000),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x80000000))
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x80000000))
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PasswordPage())
                          );
                        },
                        child: const Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                            fontFamily: 'BlackHanSans-Regular',
                            color: Color(0x80000000),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 280,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          backgroundColor: const Color(0xff69BF70),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          final success = await handleLogin();
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            );
                          } else {
                            // 실패하는 경우
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '로그인',
                            style: TextStyle(
                              fontFamily: 'BlackHanSans-Regular',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xffD9D9D9),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      '계정을 생성하여',
                      style: TextStyle(
                        fontFamily: 'BlackHanSans-Regular',
                        fontSize: 15,
                        color: Color(0x80000000),
                      ),
                    ),
                    const Text(
                      '서비스를 이용하세요',
                      style: TextStyle(
                        fontFamily: 'BlackHanSans-Regular',
                        fontSize: 15,
                        color: Color(0x80000000),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: 280,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          backgroundColor: const Color(0xff69BF70),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                              fontFamily: 'BlackHanSans-Regular',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
