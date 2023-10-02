import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/ui/auth/verify_code.dart';
import 'package:firebaselearning/utils/utils.dart';
import 'package:firebaselearning/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final TextEditingController phoneNumberController = TextEditingController();

  final auth = FirebaseAuth.instance;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(children: [
          const SizedBox(
            height: 80,
          ),
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: '+92 312-5678990',
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          RoundButton(
              title: "Login",
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: phoneNumberController.text,
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      Utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                    codeSent: (String VerificationId, int? Token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyWithCode(
                                    VerificationId: VerificationId,
                                  )));
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    });
              })
        ]),
      ),
    );
  }
}
