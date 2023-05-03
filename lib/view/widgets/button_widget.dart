import 'package:flutter/material.dart';

import '../../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: kPrimaryColor),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    ),
  );
}
