part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

class AddNoteEvent extends NoteEvent{
  String title;
  String desc;
  String uid;

  AddNoteEvent({required this.uid, required this.title, required this.desc});
}

class FetchAllNotes extends NoteEvent{
  String uid;

  FetchAllNotes({required this.uid});
}
