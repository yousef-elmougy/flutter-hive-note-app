import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/notes/notes_cubit.dart';
import '../note_item.dart';

class NotesAnimatedListWidget extends StatelessWidget {
  const NotesAnimatedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NotesCubit>().notes;
    return AnimatedList(
      key: context.read<NotesCubit>().listKey,
      controller: context.read<NotesCubit>().controller,
      physics: const AlwaysScrollableScrollPhysics(),
      initialItemCount: notes.length,
      itemBuilder: (context, index, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: NoteItem(
          note: notes[index],
          onDelete: () => context.read<NotesCubit>().deleteNote(
                index,
                NoteItem(note: notes[index]),
              ),
        ),
      ),
    );
  }
}
