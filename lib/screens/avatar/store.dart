import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'store_items.dart';
import '../../controllers/user_controller.dart';

class StoreModal extends StatefulWidget {
  const StoreModal({super.key});

  @override
  State<StoreModal> createState() => _StoreModalState();
}

class _StoreModalState extends State<StoreModal> {
  int selectedIndex = 0;
  String selectedCategory = '아바타';
  List<String> itemList = [];

  final userController = Get.find<UserController>();

  final List<String> avatarList = [
    'assets/images/avatars/sf_anya.png',
    'assets/images/avatars/sf_loid.png',
    'assets/images/avatars/sf_bond.png',
  ];

  final List<String> conceptList = [
    'assets/images/concepts/sf_anya_1.png',
    'assets/images/concepts/sf_anya_2.png',
    'assets/images/concepts/sf_anya_3.png',
    'assets/images/concepts/sf_anya_4.png',
  ];

  final List<String> backgroundList = [
    'assets/images/backgrounds/bg_at.png',
    'assets/images/backgrounds/bg_fr.png',
    'assets/images/backgrounds/bg_sf.png',
  ];

  // 처음 열었을 때 아바타 리스트 보여줌
  @override
  void initState() {
    super.initState();
    itemList = avatarList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      decoration: const BoxDecoration(
        color: Color(0xffB2ECB7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            const Text(
              '※기본 아바타를 보유하고 있어야 컨셉을 구매할 수 있습니다!',
              style: TextStyle(
                fontFamily: 'BlackHanSans-Regular',
                color: Colors.white,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff69BF70),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = '아바타';
                      });
                    },
                    child: const Text(
                      '아바타',
                      style: TextStyle(
                        fontFamily: 'BlackHanSans-Regular',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 30),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff69BF70),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = '컨셉';
                        itemList = conceptList;
                        selectedIndex = -1;
                      });
                    },
                    child: const Text(
                      '컨셉',
                      style: TextStyle(
                        fontFamily: 'BlackHanSans-Regular',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 30),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff69BF70),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = '배경';
                        itemList = backgroundList;
                        selectedIndex = -1;
                      });
                    },
                    child: const Text(
                      '배경',
                      style: TextStyle(
                        fontFamily: 'BlackHanSans-Regular',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: StoreItems(
                    imagePath: itemList,
                    selectedIndex: selectedIndex,
                    onSelect: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}