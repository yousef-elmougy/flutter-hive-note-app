import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/cubit/notes/notes_cubit.dart';
import 'package:hive_note/utils.dart';
import 'package:hive_note/view/widgets/custom_app_bar.dart';
import 'package:hive_note/view/widgets/edit_note_widget/edit_color_widget.dart';
import 'package:hive_note/view/widgets/text_form_field_widget.dart';

import '../../model/note.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.note});

  final Note note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late String title, content;

  @override
  void initState() {
    super.initState();
    title = widget.note.title;
    content = widget.note.content;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 8, right: 24, left: 24),
            child: Column(
              children: [
                CustomAppBar(
                  title: 'Edit Note',
                  icon: Icons.check,
                  isEdit: true,
                  onPressed: _editNote,
                ),
                const SizedBox(height: 48),
                TextFormFieldWidget(
                  initialValue: widget.note.title,
                  onChanged: (value) => title = value,
                ),
                const SizedBox(height: 24),
                TextFormFieldWidget(
                  initialValue: widget.note.content,
                  maxLine: 5,
                  onChanged: (value) => content = value,
                ),
                const SizedBox(height: 48),
                EditColorWidget(note: widget.note),
              ],
            ),
          ),
        ),
      );

  void _editNote() {
    widget.note.title = title;
    widget.note.content = content;
    widget.note.save();
    Navigator.pop(context);
    context.read<NotesCubit>().getAllNotes();
    Utils.snackBar(context, 'Note Edited Successfully');
  }
}
