import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

part 'note_cubit_state.dart';

class NoteCubit extends Cubit<NoteCubitState> {
  NoteCubit() : super(NotesCubitInitial());

  late List<NoteModel> notes;
  fetchAllNotes() {
    emit(NotesLoading());
    try {
      var noteBox = Hive.box<NoteModel>(kNotesBox);
      notes = noteBox.values.toList();
      emit(NotesSuccess(notes));
    } catch (e) {
      emit(NotesFaliure(e.toString()));
      NotesFaliure(e.toString());
      notes = [];
    }
  }
}
