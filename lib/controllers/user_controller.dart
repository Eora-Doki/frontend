import 'package:get/get.dart';

class UserController extends GetxController {
  RxList<String> ownedAvatars = <String>[
    'sf_anya',
    'sf_bond',
  ].obs;

  void setCharacter(String value) {
    character.value = value;
  }

  RxString character = 'sf_anya'.obs;
  RxInt coin = 10.obs;
}
