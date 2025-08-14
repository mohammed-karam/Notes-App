abstract class AddNotesStates {}

class AddNotesInitial extends AddNotesStates {}

class AddNotesLoading extends AddNotesStates {}

class AddNotesSuccess extends AddNotesStates {}

class AddNotesFailure extends AddNotesStates {
  final String message;

  AddNotesFailure(this.message);
}
