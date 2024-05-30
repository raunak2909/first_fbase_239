import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_fbase_239/screens/home_page.dart';
import 'package:first_fbase_239/screens/user_on_boarding/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static const String PREF_USER_ID_KEY = "uid";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 21,
            ),
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
            ElevatedButton(
                onPressed: () {
                  try {
                    firebaseAuth
                        .signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passController.text.toString())
                        .then((value) async{
                      print("User Logged in: ${value.user!.uid}");

                      ///shared pref
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString(PREF_USER_ID_KEY, value.user!.uid);

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                    });
                  } on FirebaseAuthException catch (e) {
                    print('Error: Invalid Credentials!!');
                  } catch (e) {
                    print('Error: $e');
                  }
                },
                child: Text('Login')),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ));
                },
                child: Text('Don\'t have an account, Create Now')),
          ],
        ),
      ),
    );
  }
}
