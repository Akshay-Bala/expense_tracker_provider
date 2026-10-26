
import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color background;
  final Color foreground;

  const CommonIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.background = Colors.white,
    this.foreground = const Color(0xFF303749),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFE9EBF2)),
          ),
          child: Icon(icon, size: 19, color: foreground),
        ),
      ),
    );
  }
}