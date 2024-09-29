import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableIcons extends StatelessWidget {
  final void Function(BuildContext context) onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  const SlidableIcons({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      icon: icon,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      padding: EdgeInsets.zero,
    );
  }
}
