import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_fbase_239/screens/user_on_boarding/sign_in_page.dart';
import 'package:first_fbase_239/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference mUsers;
  String? uid;
  static const COLLECTION_USER_KEY = "users";
  static const COLLECTION_NOTE_KEY = "notes";

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  getUserId() async{
    var prefs = await SharedPreferences.getInstance();
    uid = prefs.getString(SignInPage.PREF_USER_ID_KEY);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    mUsers = firestore.collection(COLLECTION_USER_KEY).doc(uid).collection(COLLECTION_NOTE_KEY);

    return Scaffold(
      appBar: AppBar(title: Text('Firebase App')),
      body: uid != null ? FutureBuilder(
        future: firestore.collection(COLLECTION_USER_KEY).doc(uid).collection(COLLECTION_NOTE_KEY).get(),
        builder: (_, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshots.hasError) {
            return Center(
              child: Text('Error: ${snapshots.error}'),
            );
          }

          if (snapshots.hasData) {
            return ListView.builder(
                itemCount: snapshots.data!.size,
                itemBuilder: (_, index) {
                  //Map<String, dynamic> data = snapshots.data!.docs[index].data();
                  UserModel eachModel =
                      UserModel.fromDoc(snapshots.data!.docs[index].data());
                  return ListTile(
                    title: Text('${eachModel.name}'),
                    subtitle: Text('${eachModel.email}'),
                  );
                });
          }

          return Container();
        },
      ) : Center(child: CircularProgressIndicator(),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newUser = UserModel(
              name: "Ramanujan",
              email: "ramanu@gmail.com",
              gender: "Male",
              age: 25,
              mobNo: "8877887788");

          mUsers
              .add(newUser.toDoc())
              .then((value) {
                print("DocId: ${value.id}");
                setState(() {

                });
          }, onError: (e) {
            print("Error: $e");
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
