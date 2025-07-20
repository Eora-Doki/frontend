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
  String selectedAnimation = '스파이패밀리';

  final Map<String, List<String>> characterMap = {
    '스파이패밀리': ['아냐', '본드', '로이드'],
    '진격의거인': ['리바이', '옐렌예거', '한지'],
    '장송의프리렌': ['프리렌', '페른', '슈타르크'],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> characters = characterMap[selectedAnimation] ?? [];

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
              padding: const EdgeInsets.all(30),
              child: Image.asset(
                'assets/images/sf_anya.png',
                width: 200,
                height: 200,
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffB2ECB7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAnimation('스파이패밀리'),
                        _buildAnimation('진격의거인'),
                        _buildAnimation('장송의프리렌'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCharacter('아냐', 'assets/images/sf_anya.png'),
                        _buildCharacter('본드', 'assets/images/sf_anya.png'),
                        _buildCharacter('은비', 'assets/images/sf_anya.png'),
                      ],
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, right: 7),
                        child: SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              backgroundColor: const Color(0xff69BF70),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
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
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                '완료',
                                style: TextStyle(
                                  fontFamily: 'BlackHanSans-Regular',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 애니메이션 탭 생성 함수
  Widget _buildAnimation(String animationName) {
    final bool isSelected = selectedAnimation == animationName;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnimation = animationName;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff69BF70) : const Color(0x8069BF70),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          animationName,
          style: TextStyle(
            fontFamily: 'BlackHanSans-Regular',
            color: isSelected ? Colors.white : const Color(0x80FFFFFF),
          ),
        ),
      ),
    );
  }

  // 캐릭터 탭 생성 함수
  Widget _buildCharacter(String name, String imagePath) {
    return Column(
      children: [
        Image.asset(imagePath, width: 80, height: 80),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'BlackHanSans-Regular',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

