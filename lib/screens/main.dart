import 'package:doki/screens/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(email: 'test@email.com', password: '1234'),
  ));
}

class Doki extends StatelessWidget {
  const Doki({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Doki',
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final String email;
  final String password;

  const HomePage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('홈페이지'),
          ],
        ),
      ),
    );
  }
}
