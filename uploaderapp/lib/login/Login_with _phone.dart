import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uploaderapp/buttons/round_button.dart';
import 'package:uploaderapp/login/verifycode_page.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  //controllers
  TextEditingController phoneNumberController = TextEditingController();
  //firebas objects
  FirebaseAuth auth = FirebaseAuth.instance;

  //validation function
  void Login() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LOGIN")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: "+912356 87900",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RoundButton(
                title: "Login",
                onTap: () async {
                  print("__________________________________xxxxxxxxxxxxxx");
                  //----------------------------------set2
                  await auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        print("//////////////////////////");
                        print(e);
                        print("//////////////////////////");

                        // getErrors.dealultError(
                        //ErrorText.T_PhoneNumber_Error, e.toString());
                      },
                      codeSent:
                          ((String verificationId, int? forceResendingToken) {
                        print(
                            "__________________________________xxxxxxxxxxxxxx");
                        print(verificationId);
                        Get.to(VerifyCode(verificationId: verificationId));
                        // Navigator.push(context, Route)
                        //Get.to(VerifyCodePage(verificationId: verificationId));
                      }),
                      codeAutoRetrievalTimeout: (e) {
                        // getErrors.dealultError(
                        //     getErrors.myDialogBox(ErrorText.T_TIMEOUT),
                        //     e.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
