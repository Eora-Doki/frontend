import 'package:flutter/material.dart';

import 'character.dart';

class NicknamePage extends StatefulWidget {
  final String email;
  final String password;

  const NicknamePage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
              height: 180,
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
                    controller: nameController,
                    cursorColor: const Color(0x80000000),
                    decoration: const InputDecoration(
                      labelText: '닉네임을 설정하세요',
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

                  const SizedBox(height: 25),

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
                            builder: (context) => CharacterPage(
                              email: widget.email,
                              password: widget.password,
                              name: nameController.text,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          '다음',
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
