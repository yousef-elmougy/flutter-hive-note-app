import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/cubit/notes/notes_cubit.dart';
import 'package:hive_note/view/widgets/empty_widget.dart';
import 'package:hive_note/view/widgets/note_item.dart';
import 'package:hive_note/view/widgets/text_form_field_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: TextFormFieldWidget(
          controller: controller,
          border: InputBorder.none,
          autofocus: true,
          hintText: 'Search',
          onChanged: _onChanged,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: _clearText,
          ),
        ),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          final notes = context.read<NotesCubit>().notesSearched;
          return query.isEmpty
              ? const EmptyWidget(icon: Icons.search, text: 'Search note')
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) =>
                      NoteItem(note: notes[index], isSearch: true,query: query),
                );
        },
      ),
    );

  void _clearText() {
    query = '';
    controller.clear();
    setState(() {});
  }

  void _onChanged(String value) {
    query = value;
    context.read<NotesCubit>().searchNote(query);
  }
}
