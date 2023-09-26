import 'package:flutter/material.dart';

class MoodBlockWidget extends StatelessWidget {
  final double edge;
  final bool isSelected;
  final String emoji;
  const MoodBlockWidget({
    super.key,
    required this.edge,
    required this.isSelected,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: edge / 8,
      height: edge / 8,
      decoration: BoxDecoration(
        color: isSelected ? Colors.amber.shade100 : Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 2.0),
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Center(
        child: Text(
          emoji,
        ),
      ),
    );
  }
}
