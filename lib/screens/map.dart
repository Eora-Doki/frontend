import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'ㅎㅇ',
            )
          ],
        ),
      ),


      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: const Color(0xffD7FFDA),
          highlightColor: const Color(0xffD7FFDA),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffB2ECB7),
          currentIndex: 2,
          selectedItemColor: const Color(0xff69BF70),
          unselectedItemColor: Colors.white,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
                break;
              case 4:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
                break;
            }
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
