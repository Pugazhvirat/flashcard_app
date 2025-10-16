import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isAnswered;
  final bool isCorrect;
  final VoidCallback onTap;
  final bool isDark; // add this

  const OptionTile({
    required this.option,
    required this.isSelected,
    required this.isAnswered,
    required this.isCorrect,
    required this.onTap,
    this.isDark = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    if (!isAnswered) {
      bgColor = isDark ? Colors.grey[800]! : Colors.white;
    } else if (isSelected) {
      bgColor = isCorrect ? Colors.green : Colors.red;
    } else {
      bgColor = isDark ? Colors.grey[700]! : Colors.grey[200]!;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? Colors.white54 : Colors.grey),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
