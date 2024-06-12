import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPPage extends StatefulWidget{

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  var otpNo1Controller = TextEditingController();

  var otpNo2Controller = TextEditingController();

  var otpNo3Controller = TextEditingController();

  var otpNo4Controller = TextEditingController();

  var otpNo5Controller = TextEditingController();

  var otpNo6Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String otp = "463454";

    otp.split("");

    //[4,6,3,4,5,4]

    return Scaffold(
      appBar: AppBar(title: Text('OTP'),),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            mTextField(mController: otpNo1Controller, isFocus: true),
            SizedBox(width: 11),
            mTextField(mController: otpNo2Controller,),
            SizedBox(width: 11),
            mTextField(mController: otpNo3Controller,),
            SizedBox(width: 11),
            mTextField(mController: otpNo4Controller,),
            SizedBox(width: 11),
            mTextField(mController: otpNo5Controller,),
            SizedBox(width: 11),
            mTextField(mController: otpNo6Controller,),
          ],
        ),
      ),
    );
  }

  Widget mTextField({required TextEditingController mController, bool isFocus = false}){
    return SizedBox(
      width: 50,
      child: TextField(
        controller: mController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11)
          )
        ),
        onChanged: (value){
          if(value!=null){
            FocusScope.of(context).nextFocus();
          }
        },
        maxLength: 1,
        maxLines: 1,
        autofocus: isFocus,
      ),
    );
  }
}