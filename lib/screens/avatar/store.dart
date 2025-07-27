import 'package:flutter/material.dart';

class StoreModal extends StatelessWidget {
  const StoreModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      decoration: const BoxDecoration(
        color: Color(0xffB2ECB7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Center(
        child: Text(
          '상점',
          style: TextStyle(fontSize: 24, fontFamily: 'BlackHanSans-Regular'),
        ),
      ),
    );
  }
}