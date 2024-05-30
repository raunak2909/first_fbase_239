import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_fbase_239/user_model.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();

  FirebaseAuth fireAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('Create Account',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 21,
            ),

            ///name
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                label: Text('Name'),
                hintText: 'Enter your name here..',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),

            ///email
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                label: Text('Email'),
                hintText: 'Enter your email here..',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),

            ///mobNo
            TextField(
              controller: mobNoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.call),
                label: Text('Mobile No'),
                hintText: 'Enter your Mobile no here..',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),

            ///age
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_month_rounded),
                label: Text('Age'),
                hintText: 'Enter your age here..',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),

            ///gender
            TextField(
              controller: genderController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.accessibility_sharp),
                label: Text('Gender'),
                hintText: 'Enter your gender here..',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),

            ///pass
            TextField(
              controller: passController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                label: Text('Password'),
                hintText: 'Enter your password here..',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            ElevatedButton(onPressed: () async {
              try {
                var cred = await fireAuth.createUserWithEmailAndPassword(
                    email: emailController.text.toString(),
                    password: passController.text.toString());

                print('UID: ${cred.user!.uid}');


                UserModel newUser = UserModel(
                    name: nameController.text.toString(),
                    email: emailController.text.toString(),
                    gender: genderController.text.toString(),
                    age: int.parse(ageController.text.toString()),
                    mobNo: mobNoController.text.toString());

                firebaseFirestore.collection("users").doc(cred.user!.uid).set(newUser.toDoc()).then((value){
                  print("User is added");
                  Navigator.pop(context);
                });


              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
                print("FireError: $e");
              } catch (e) {
                print("Error: $e");
              }

              ///sign up successfully
              ///

            }, child: Text('Sign Up'))

          ],
        ),
      ),
    );
  }
}
