import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/view/widgets/add_note_widget/add_note_form_widget.dart';

import '../../cubit/notes/notes_cubit.dart';
import '../../utils.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) => AnimatedPadding(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.only(
          right: 16,
          left: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is AddNoteError) {
              debugPrint(state.error.toString());
            }
            if (state is AddNoteSuccess) {
              Navigator.pop(context);
              context.read<NotesCubit>()
                ..getAllNotes()
                ..scrollDown();
              Utils.snackBar(context, 'Note Add Successfully');
            }
          },
          builder: (context, state) {
            if (state is AddNoteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddNoteError) {
              return const Center(child: Text('Error'));
            } else {
              return const AddNoteFormWidget();
            }
          },
        ),
      );
}
