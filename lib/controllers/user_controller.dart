import 'package:get/get.dart';

class UserController extends GetxController {
  var character = ''.obs;

  void setCharacter(String value) {
    character.value = value;
  }
}
