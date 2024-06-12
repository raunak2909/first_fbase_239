import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_fbase_239/firebase_options.dart';
import 'package:first_fbase_239/screens/bloc/note_bloc.dart';
import 'package:first_fbase_239/screens/home_page.dart';
import 'package:first_fbase_239/screens/mobile_login_page.dart';
import 'package:first_fbase_239/screens/otp_page.dart';
import 'package:first_fbase_239/screens/profile_page.dart';
import 'package:first_fbase_239/screens/storage_page.dart';
import 'package:first_fbase_239/screens/user_on_boarding/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(BlocProvider(
    create: (context) => NoteBloc(firestore: FirebaseFirestore.instance),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OTPPage(),
    );
  }
}
