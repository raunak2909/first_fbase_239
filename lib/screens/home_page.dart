import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_fbase_239/screens/bloc/note_bloc.dart';
import 'package:first_fbase_239/screens/user_on_boarding/sign_in_page.dart';
import 'package:first_fbase_239/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference mUsersNotes;
  String? uid;
  static const COLLECTION_USER_KEY = "users";
  static const COLLECTION_NOTE_KEY = "notes";

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  getUserId() async {
    var prefs = await SharedPreferences.getInstance();
    uid = prefs.getString(SignInPage.PREF_USER_ID_KEY);
    context.read<NoteBloc>().add(FetchAllNotes(uid: uid!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase App')),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (_, state) {
          if (state is NoteLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is NoteErrorState) {
            return Center(
              child: Text('Error: ${state.errorMsg}'),
            );
          }

          if (state is NoteLoadedState) {
            return ListView.builder(
                itemCount: state.arrNotes.length,
                itemBuilder: (_, index) {
                  //Map<String, dynamic> data = snapshots.data!.docs[index].data();
                  var nTitle = state.arrNotes[index]['title'];
                  var nDesc = state.arrNotes[index]['desc'];
                  return ListTile(
                    title: Text(nTitle),
                    subtitle: Text(nDesc),
                  );
                });
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /*var newUser = UserModel(
              name: "Ramanujan",
              email: "ramanu@gmail.com",
              gender: "Male",
              age: 25,
              mobNo: "8877887788");*/

          context.read<NoteBloc>().add(AddNoteEvent(
              uid: uid!,
              title: "New Note from BLOC",
              desc: "Note added successfully!!"));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
