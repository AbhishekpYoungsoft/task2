import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uploaderapp/buttons/round_button.dart';
import 'package:uploaderapp/home_screen.dart';

class VerifyCode extends StatefulWidget {
  // a verification id sent tp phone and this screen so to evalauate
  final String verificationId;
  VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  //controllers
  TextEditingController verifyCodeController = TextEditingController();

  //firebase authentication
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: verifyCodeController,
            decoration: InputDecoration(
                hintText: "6 didgit code",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 10,
          ),
          RoundButton(
              title: 'Verify Code',
              onTap: () async {
                //create a credential instance
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verifyCodeController.text.toString());

                try {
                  await auth.signInWithCredential(credential);
                  Get.to(MyHomePage());
                } catch (e) {
                  print("/////////////////////////////////");
                  print(e.toString());
                  print("/////////////////////////////////");
                }
              })
        ],
      ),
    );
  }
}
