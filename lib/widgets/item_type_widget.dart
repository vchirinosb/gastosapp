import 'package:flutter/material.dart';

class ItemTypeWidget extends StatelessWidget {
  Map<String, dynamic> data;
  bool isSelected;
  VoidCallback tap;
  ItemTypeWidget({super.key, 
    required this.data,
    required this.isSelected,
    required this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyan.withOpacity(0.3)
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/${data["image"]}.webp",
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              data["name"],
            ),
          ],
        ),
      ),
    );
  }
}