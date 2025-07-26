import 'package:doki/screens/start.dart';
import 'package:flutter/material.dart';
import 'package:doki/services/api_service.dart';

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
  String selectedCharacterImage = 'assets/images/sf_anya.png';

  final Map<String, List<Map<String, String>>> characterMap = {
    '스파이패밀리': [
      {'name': '아냐', 'image': 'assets/images/sf_anya.png'},
      {'name': '본드', 'image': 'assets/images/sf_bond.png'},
      {'name': '로이드', 'image': 'assets/images/sf_loid.png'},
    ],
    '진격의거인': [
      {'name': '리바이', 'image': 'assets/images/at_levi.png'},
      {'name': '옐렌예거', 'image': 'assets/images/at_yeager.png'},
      {'name': '한지', 'image': 'assets/images/at_hange.png'},
    ],
    '장송의프리렌': [
      {'name': '프리렌', 'image': 'assets/images/fr_frieren.png'},
      {'name': '페른', 'image': 'assets/images/fr_fern.png'},
      {'name': '슈타르크', 'image': 'assets/images/fr_stark.png'},
    ],
  };

  @override
  void initState() {
    super.initState();
    final characters = characterMap[selectedAnimation];
    if (characters != null && characters.isNotEmpty) {
      selectedCharacter = characters[0]['name']!;
      selectedCharacterImage = characters[0]['image']!;
    }
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
            Transform.translate(
              offset: const Offset(0, 20),
              child: const Text(
                'Doki',
                style: TextStyle(
                  fontSize: 110,
                  fontFamily: 'Jersey15-Regular',
                  color: Color(0xff69BF70),
                ),
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
                selectedCharacterImage,
                width: 180,
                height: 180,
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
                      children: characterMap[selectedAnimation]!.map((character) {
                        return _buildCharacter(character['name']!, character['image']!);
                      }).toList(),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, right: 7),
                        child: SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              backgroundColor: const Color(0xff69BF70),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
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
                                  MaterialPageRoute(builder: (context) => const StartPage()),
                                    (route) => false,
                                );
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 3),
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
          final characters = characterMap[animationName];
          if (characters != null && characters.isNotEmpty) {
            selectedCharacter = characters[0]['name']!;
            selectedCharacterImage = characters[0]['image']!;
          } else {
            selectedCharacter = '';
            selectedCharacterImage = 'assets/images/sf_anya.png';
          }
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
    final bool isSelected = selectedCharacter == name;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCharacter = name;
          selectedCharacterImage = imagePath;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: isSelected
                  ? Border.all(color: Colors.white, width: 3)
                  : null,
            ),
            child: Image.asset(imagePath, width: 80, height: 80),
          ),
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
      ),
    );
  }
}

