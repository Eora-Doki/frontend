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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: GridView.builder(
        itemCount: imagePath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),

              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Image.asset(
                      imagePath[index],
                      width: 80,
                      height: 80,
                    ),
                  ),

                  if (isSelected)
                    Positioned(
                      bottom: -13,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xff69BF70),
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
