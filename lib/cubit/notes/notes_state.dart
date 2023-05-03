part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

/// get notes
class GetNotesSuccess extends NotesState {}

/// add note
class AddNoteSuccess extends NotesState {}

class AddNoteLoading extends NotesState {}

class AddNoteError extends NotesState {
  final String error;

  AddNoteError(this.error);
}

/// delete note
class DeleteNoteSuccess extends NotesState {}

class DeleteNoteLoading extends NotesState {}

class DeleteNoteError extends NotesState {
  final String error;

  DeleteNoteError(this.error);
}

/// select color
class SelectColor extends NotesState {}

/// search note
class SearchNote extends NotesState {}
