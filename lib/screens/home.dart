import 'package:doki/screens/avatar.dart';
import 'package:doki/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NavigationController controller = Get.put(NavigationController());

  final List<Widget> _pages = const [
    MapPage(),
    MapPage(),
    AvatarPage(),
    MapPage(),
    MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Color(0xff69BF70)),
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
          Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: _pages,
          )),
        ],
      ),

      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xffB2ECB7),
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: const Color(0xff69BF70),
        unselectedItemColor: Colors.white,
        onTap: controller.changeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: '위치'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '거래'),
          BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: '아바타'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: '위시리스트'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '나의 정보'),
        ],
      )),
    );
  }
}
