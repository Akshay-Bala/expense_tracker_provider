
import 'package:flutter/material.dart';

class CommonCategoryOptionWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const CommonCategoryOptionWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 19, color: color),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF303749),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}