import 'package:flutter/material.dart';
import 'package:hive_note/constants.dart';

class ColorItemWidget extends StatelessWidget {
  const ColorItemWidget({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 10),
        width: 70,
        height: 100,
        decoration: ShapeDecoration(
          color: Color(kColors[index].value),
          shape: CircleBorder(
            side: currentIndex == index
                ? const BorderSide(
                    width: 5,
                    color: Colors.white,
                  )
                : BorderSide.none,
          ),
        ),
      );
}
