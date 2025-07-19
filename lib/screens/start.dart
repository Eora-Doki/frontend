import 'package:flutter/material.dart';
import 'package:doki/screens/login.dart';
import 'package:doki/screens/register.dart';

void main() {
  runApp(const Start());
}

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Doki',
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
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
                fontSize: 140,
                fontFamily: 'Jersey15-Regular',
                color: Color(0xff69BF70),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  SizedBox(
                    width: 280,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: const Color(0xff69BF70),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            fontFamily: 'BlackHanSans-Regular',
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 15),

                  SizedBox(
                    width: 280,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: const Color(0xff69BF70),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Register()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 5),
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
