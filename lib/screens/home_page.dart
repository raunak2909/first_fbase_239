import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_fbase_239/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference mUsers;

  @override
  Widget build(BuildContext context) {
    mUsers = firestore.collection("users");

    return Scaffold(
      appBar: AppBar(title: Text('Firebase App')),
      body: FutureBuilder(
        future: firestore.collection("users").get(),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newUser = UserModel(
              name: "Ramanujan",
              email: "ramanu@gmail.com",
              gender: "Male",
              address: "svfnvjsfnvjfsnvfs",
              age: 25,
              mobNo: "8877887788");

          mUsers
              .add(newUser.toDoc())
              .then((value) => print("DocId: ${value.id}"), onError: (e) {
            print("Error: $e");
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
