import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'store.dart';
import 'inventory.dart';
import 'avatar.dart';
import '../information/information.dart';
import '../trade/trade.dart';
import '../wishlist/wishlist.dart';
import '../map/map.dart';
import '../../controllers/navigation_controller.dart';

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
    TradePage(),
    AvatarPage(),
    WishlistPage(),
    InfoPage(),
  ];

  final today = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 7),
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.paid, color: Color(0xff69BF70)),
                Text(
                  ' 10',
                  style: TextStyle(
                    fontFamily: 'Jersey15-Regular',
                    color: Color(0xff69BF70),
                    fontSize: 25
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              // 알림 기능 추후 개발
            },
            icon: const Icon(Icons.lightbulb, color: Color(0xff69BF70), size: 35),
          ),
        ],
      ),

      body: Stack(
        children: [
          Obx(() => Positioned.fill(
            child: controller.isModalOpen.value
              ? Transform.translate(
                offset: const Offset(0, -150),
                child: Image.asset(
                  'assets/images/backgrounds/bg_boutique.png',
                  fit: BoxFit.cover,
                ),
              )
            : Image.asset(
              'assets/images/backgrounds/bg_basic.png',
              fit: BoxFit.cover,
              ),
          )),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                margin: const EdgeInsets.only(top: 40),
                width: 150,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xffB2ECB7),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  today,
                  style: const TextStyle(
                    fontFamily: 'BlackHanSans-Regular',
                    color: Color(0xff69BF70),
                  ),
                ),
              ),
            ],
          ),

          Obx(() => AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            bottom: controller.isModalOpen.value ? 250 : 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff69BF70),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (controller.isModalOpen.value) {
                        Navigator.pop(context);
                      } else {
                        controller.setModalOpen(true);
                        await showModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          isScrollControlled: true,
                          barrierColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          backgroundColor: const Color(0xffBFEAC2),
                          builder: (context) => const StoreModal(),
                        ).whenComplete(() {
                          controller.setModalOpen(false);
                        });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '상점',
                        style: TextStyle(
                          fontFamily: 'BlackHanSans-Regular',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff69BF70),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (controller.isModalOpen.value) {
                        Navigator.pop(context);
                      } else {
                        controller.setModalOpen(true);
                        await showModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          isScrollControlled: true,
                          barrierColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          backgroundColor: const Color(0xffBFEAC2),
                          builder: (context) => const InventoryModal(),
                        ).whenComplete(() {
                          controller.setModalOpen(false);
                        });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '인벤토리',
                        style: TextStyle(
                          fontFamily: 'BlackHanSans-Regular',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),

          Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: _pages,
          )),
        ],
      ),

      bottomNavigationBar: Obx(() => Theme(
        data: Theme.of(context).copyWith(
          splashColor: const Color(0xffBFEAC2),
          highlightColor: const Color(0xffBFEAC2),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffB2ECB7),
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xff69BF70),
          onTap: controller.changeIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: '위치'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: '거래'),
            BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: '아바타'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: '위시리스트'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '나의 정보'),
          ],
        ),
      )),
    );
  }
}
