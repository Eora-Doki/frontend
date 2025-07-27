import 'package:flutter/material.dart';

class InventoryModal extends StatelessWidget {
  const InventoryModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Color(0xffB2ECB7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Center(
        child: Text(
          '인벤토리',
          style: TextStyle(fontSize: 24, fontFamily: 'BlackHanSans-Regular'),
        ),
      ),
    );
  }
}