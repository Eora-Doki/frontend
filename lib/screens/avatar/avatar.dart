import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../controllers/navigation_controller.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<UserController>()) {
      Get.put(UserController());
    }
    if (!Get.isRegistered<NavigationController>()) {
      Get.put(NavigationController());
    }

    final userController = Get.find<UserController>();
    final navigationController = Get.find<NavigationController>();

    return Center(
      child: Obx(() {
        final offsetY = navigationController.isModalOpen.value ? -5.0 : 100.0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, offsetY, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(0, -50),
                child: Image.asset(
                    'assets/images/avatars/${userController.character.value.isNotEmpty ? userController.character.value : 'sf_bond'}.png',
                  height: 150
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
