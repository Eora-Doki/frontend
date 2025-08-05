import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import './controllers/user_controller.dart';
import './screens/login/start.dart';

void main() {
  Get.put(UserController());
  runApp(const Doki());
}

class Doki extends StatelessWidget {
  const Doki({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}
