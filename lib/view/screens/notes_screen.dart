import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/cubit/notes/notes_cubit.dart';
import 'package:hive_note/view/screens/add_note_screen.dart';
import 'package:hive_note/view/screens/search_screen.dart';
import 'package:hive_note/view/widgets/custom_app_bar.dart';
import 'package:hive_note/view/widgets/empty_widget.dart';

import '../../utils.dart';
import '../widgets/notes_widget/note_animated_list_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getAllNotes();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _buildModalBottomSheet,
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8, right: 24, left: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(
                  title: 'Notes',
                  icon: Icons.search,
                  isEdit: false,
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocConsumer<NotesCubit, NotesState>(
                    listener: (context, state) {
                      if (state is DeleteNoteSuccess) {
                        context.read<NotesCubit>().getAllNotes();
                        Utils.snackBar(context, 'Note Deleted Successfully');
                      }
                      if (state is DeleteNoteError) {
                        debugPrint(state.error.toString());
                      }
                    },
                    builder: (context, state) {
                      final notes = context.read<NotesCubit>().notes;
                      return notes.isEmpty
                          ? const EmptyWidget(
                              icon: Icons.notes,
                              text: 'Add some notes',
                            )
                          : const NotesAnimatedListWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future<dynamic> _buildModalBottomSheet() => showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (context) => const AddNoteScreen(),
      );
}

