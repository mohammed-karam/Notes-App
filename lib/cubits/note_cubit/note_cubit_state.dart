part of 'note_cubit_cubit.dart';

abstract class NoteCubitState {}

final class NotesCubitInitial extends NoteCubitState {}

final class NotesLoading extends NoteCubitState {}

final class NotesSuccess extends NoteCubitState {
  final List<NoteModel> notes;

  NotesSuccess(this.notes);
}

final class NotesFaliure extends NoteCubitState {
  final String message;

  NotesFaliure(this.message);
}
