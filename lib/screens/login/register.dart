import 'package:flutter/material.dart';

import 'nickname.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              height: 260,
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

                  const SizedBox(height: 16),

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

                  const SizedBox(height: 30),

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
                          MaterialPageRoute(
                            builder: (context) => NicknamePage(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            fontFamily: 'BlackHanSans-Regular',
                            fontSize: 23,
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
    );
  }
}

