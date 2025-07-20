import 'package:flutter/material.dart';
import 'package:doki/services/api_service.dart';
import 'main.dart';

class CharacterPage extends StatefulWidget {
  final String email;
  final String password;
  final String name;

  const CharacterPage({
    super.key,
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  String selectedCharacter = '';

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
              height: 100,
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
              child: const Column(
                children: [
                  Text(
                    '당신의 최애 캐릭터를 결정해',
                    style: TextStyle(
                      fontFamily: 'BlackHanSans-Regular',
                      color: Color(0x80000000),
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '아바타를 생성하세요',
                    style: TextStyle(
                      fontFamily: 'BlackHanSans-Regular',
                      color: Color(0x80000000),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(40),
              child: Image.asset(
                'assets/images/sf_anya.png',
                width: 200,
                height: 200,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xffB2ECB7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAnimation('스파이패밀리', true),
                      _buildAnimation('진격의거인', true),
                      _buildAnimation('스파이패밀리', true),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: const Color(0xff69BF70),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final success = await ApiService.registerUser(
                    email: widget.email,
                    name: widget.name,
                    password: widget.password,
                    character: selectedCharacter,
                  );
                  if (success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Doki()),
                          (route) => false,
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    '완료',
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
    );
  }
}

// 애니메이션 탭
Widget _buildAnimation(String text, bool selected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: selected ? const Color(0xff69BF70) : const Color(0x8069BF70),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'BlackHanSans-Regular',
        color: selected ? Colors.white : const Color(0x80FFFFFF),
      ),
    ),
  );
}

// 캐릭터 탭
Widget _buildCharacter(String name, String imagePath) {
  return Column(
    children: [
      Image.asset(imagePath, width: 60, height: 60),
      const SizedBox(height: 8),
      Text(
        name,
        style: const TextStyle(
          fontFamily: 'BlackHanSans-Regular',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    ],
  );
}
