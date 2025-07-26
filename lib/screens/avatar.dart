import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doki/screens/map.dart';

import '../controllers/navigation_controller.dart';

class AvatarPage extends StatelessWidget {
  AvatarPage({super.key});

  final NavigationController controller = Get.put(NavigationController());

  final List<Widget> _pages = const [
    MapPage(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
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
            },
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
