import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../model/note.dart';
import '../color_item_widget.dart';

class EditColorWidget extends StatefulWidget {
  const EditColorWidget({super.key, required this.note});

  final Note note;

  @override
  State<EditColorWidget> createState() => _EditColorWidgetState();
}

class _EditColorWidgetState extends State<EditColorWidget> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = kColors.indexOf(Color(widget.note.color));
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: kColors.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => _editColor(index),
            child: ColorItemWidget(index: index, currentIndex: currentIndex),
          ),
        ),
      );

  void _editColor(int index) {
    currentIndex = index;
    widget.note.color = kColors[index].value;
    setState(() {});
  }
}
