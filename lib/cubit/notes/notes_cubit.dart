import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';
import '../../model/note.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  final controller = ScrollController();
  int currentIndex = 0;
  int colorValue = kColors[0].value;
  List<Note> notes = [];
  List<Note> notesSearched = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  void getAllNotes() {
    notes = Hive.box<Note>(kNoteBox).values.toList();
    emit(GetNotesSuccess());
  }

  void searchNote(String query) {
    notesSearched = Hive.box<Note>(kNoteBox)
        .values
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()) ||
            element.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(SearchNote());
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (controller.hasClients) {
          await controller.animateTo(
            controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
        }
      });

  void selectColor(int index) {
    currentIndex = index;
    colorValue = kColors[index].value;
    emit(SelectColor());
  }

  Future<void> addNote(Note note) async {
    emit(AddNoteLoading());
    try {
      await Hive.box<Note>(kNoteBox).add(note);
      listKey.currentState?.insertItem(notes.length, duration: const Duration(seconds: 1));
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteError(e.toString()));
    }
  }

  Future<void> deleteNote(int index, Widget widget) async {
    emit(DeleteNoteLoading());
    try {
      await notes[index].delete();
      listKey.currentState!.removeItem(
          index,
          (context, animation) =>
              SizeTransition(sizeFactor: animation, child: widget));
      emit(DeleteNoteSuccess());
    } catch (e) {
      emit(DeleteNoteError(e.toString()));
    }
  }
}
