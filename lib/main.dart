import 'package:flutter/material.dart';

void main() {
  runApp(const Doki());
}

class Doki extends StatelessWidget {
  const Doki({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doki',
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
