import 'package:flutter/material.dart';

class StoreItems extends StatelessWidget {
  final List<String> imagePath;
  final int selectedIndex;
  final void Function(int) onSelect;

  const StoreItems({
    super.key,
    required this.imagePath,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 1,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      imagePath[index],
                      width: 50,
                      height: 50,
                    ),
                  ),

                  if (isSelected)
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff69BF70),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '구매',
                          style: TextStyle(
                            fontFamily: 'BlackHanSans-Regular',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
