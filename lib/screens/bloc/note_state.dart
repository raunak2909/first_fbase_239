part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitialState extends NoteState {}
final class NoteLoadingState extends NoteState {}
final class NoteLoadedState extends NoteState {
  List<Map<String, dynamic>> arrNotes;
  NoteLoadedState({required this.arrNotes});
}
final class NoteErrorState extends NoteState {
  String errorMsg;
  NoteErrorState({required this.errorMsg});
}
