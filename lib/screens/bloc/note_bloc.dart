import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {

  FirebaseFirestore firestore;

  static const COLLECTION_USER_KEY = "users";
  static const COLLECTION_NOTE_KEY = "notes";


  NoteBloc({required this.firestore}) : super(NoteInitialState()) {
    on<AddNoteEvent>((event, emit) async {
      emit(NoteLoadingState());
      CollectionReference mUsersNotes = firestore
          .collection(COLLECTION_USER_KEY)
          .doc(event.uid)
          .collection(COLLECTION_NOTE_KEY);

      await mUsersNotes
          .add({
        "title" : event.title,
        "desc" : event.desc
      });

      QuerySnapshot<Object?> mData = await mUsersNotes.get();

      List<Map<String, dynamic>> mNotes = [];

      for(QueryDocumentSnapshot eachNote in mData.docs){
        mNotes.add(eachNote.data() as Map<String, dynamic>);
      }
      emit(NoteLoadedState(arrNotes: mNotes));

    });

    on<FetchAllNotes>((event, emit) async{
      emit(NoteLoadingState());

      CollectionReference mUsersNotes = firestore
          .collection(COLLECTION_USER_KEY)
          .doc(event.uid)
          .collection(COLLECTION_NOTE_KEY);

      QuerySnapshot<Object?> mData = await mUsersNotes.get();

        List<Map<String, dynamic>> mNotes = [];

        for(QueryDocumentSnapshot eachNote in mData.docs){
          mNotes.add(eachNote.data() as Map<String, dynamic>);
        }
        emit(NoteLoadedState(arrNotes: mNotes));

    });
  }
}
