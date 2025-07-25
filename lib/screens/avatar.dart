import 'package:doki/screens/map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: AvatarPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  int _selectedIndex = 2;
  final List<Widget> _pages = const [
    MapPage(),
    AvatarPage(),
    AvatarPage(),
    AvatarPage(),
    AvatarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffB2ECB7),
        title: const Text(
          'Doki',
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Jersey15-Regular',
            color: Color(0xff69BF70),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // 알림 페이지 추후 개발
              // 안 읽은 알림 있으면 아이콘 변경
            },
            icon: const Icon(
              Icons.notifications,
              color: Color(0xff69BF70),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_basic.png',
              fit: BoxFit.cover,
            ),
          ),


          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),

          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ],
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: const Color(0xffD7FFDA),
          highlightColor: const Color(0xffD7FFDA),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffB2ECB7),
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff69BF70),
          unselectedItemColor: Colors.white,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: '위치',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '거래',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checkroom),
              label: '아바타',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: '위시리스트',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '나의 정보',
            ),
          ],
        ),
      ),
    );
  }
}
