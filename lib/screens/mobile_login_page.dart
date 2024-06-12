import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileLoginPage extends StatefulWidget {
  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  var mobNoController = TextEditingController();

  var otpController = TextEditingController();

  String? mVerificationId;

  @override
  Widget build(BuildContext context) {
    int secs = 60;

    Timer.periodic(Duration(seconds: 1), (timer) {
      if(secs>0) {
        secs--;
      } else {
        // enable btn visibility
      }
    });

   /* Future.delayed(Duration(seconds: 60), (){

    });*/

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: mobNoController,
            ),
            SizedBox(
              height: 11,
            ),
            ElevatedButton(onPressed: ()async{


              await FirebaseAuth.instance.verifyPhoneNumber(
                timeout: Duration(seconds: 60),
                phoneNumber: '+91${mobNoController.text}',
                verificationCompleted: (PhoneAuthCredential credential) {
                  print("Verification Completed");
                },
                verificationFailed: (FirebaseAuthException e) {
                  print("Verification Failed: ${e.message}");
                },
                codeSent: (String verificationId, int? resendToken) {

                  print("SMS code sent to the ${mobNoController.text}");
                  mVerificationId = verificationId;
                  setState((){});

                },
                codeAutoRetrievalTimeout: (String verificationId) {

                },
              );

            }, child: Text('Sent OTP')),
            TextField(
              controller: otpController,
            ),
            SizedBox(
              height: 11,
            ),
            AnimatedOpacity(opacity: mVerificationId!=null? 1 : 0, duration: Duration(seconds: 2), child: ElevatedButton(onPressed: () async{

              String smsCode = otpController.text;

              // Create a PhoneAuthCredential with the code
              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: mVerificationId!, smsCode: smsCode);

              // Sign the user in (or link) with the credential
              var cred = await FirebaseAuth.instance.signInWithCredential(credential);
              print("User logged in : ${cred.user!.uid}");

            }, child: Text('Verify OTP')),)

          ],
        ),
      ),
    );
  }
}
