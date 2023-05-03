import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.icon,
    required this.isEdit, this.onPressed,
  });

  final String title;
  final IconData icon;
  final bool isEdit;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isEdit) const BackButton(),
          Text(title, style: const TextStyle(fontSize: 24)),
          Container(
            width: 45,
            height: 45,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              iconSize: 28,
              padding: const EdgeInsets.only(),
              icon: Icon(icon),
              onPressed: onPressed,
            ),
          ),
        ],
      );
}
