import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/cubit/notes/notes_cubit.dart';
import 'package:hive_note/model/note.dart';
import 'package:hive_note/utils.dart';
import 'package:hive_note/view/widgets/text_form_field_widget.dart';

import '../button_widget.dart';
import 'add_color_widget.dart';

class AddNoteFormWidget extends StatefulWidget {
  const AddNoteFormWidget({super.key});

  @override
  State<AddNoteFormWidget> createState() => _AddNoteFormWidgetState();
}

class _AddNoteFormWidgetState extends State<AddNoteFormWidget> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? title, content;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: [
              const SizedBox(height: 24),
              TextFormFieldWidget(
                hintText: 'title',
                onSaved: (value) => title = value,
              ),
              const SizedBox(height: 24),
              TextFormFieldWidget(
                hintText: 'content',
                maxLine: 5,
                onSaved: (value) => content = value,
              ),
              const SizedBox(height: 24),
              const AddColorWidget(),
              const SizedBox(height: 24),
              ButtonWidget(
                onPressed: _addNote,
                title: 'Add',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );

  void _addNote() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final note = Note(
        title: title!,
        content: content!,
        date: Utils.toDateTime(DateTime.now()),
        color: context.read<NotesCubit>().colorValue,
      );
      context.read<NotesCubit>().addNote(note);
    } else {
      setState(() => autoValidateMode = AutovalidateMode.always);
    }
  }
}
