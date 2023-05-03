import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../cubit/notes/notes_cubit.dart';
import '../color_item_widget.dart';

class AddColorWidget extends StatelessWidget {
  const AddColorWidget({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 70,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: kColors.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => context.read<NotesCubit>().selectColor(index),
        child: ColorItemWidget(
          index: index,
          currentIndex: context.watch<NotesCubit>().currentIndex,
        ),
      ),
    ),
  );
}
