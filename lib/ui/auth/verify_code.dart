import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/ui/posts/post_screen.dart';
import 'package:firebaselearning/utils/utils.dart';
import 'package:firebaselearning/widgets/round_button.dart';
import 'package:flutter/material.dart';

class VerifyWithCode extends StatefulWidget {
  final String VerificationId;
  const VerifyWithCode({super.key, required this.VerificationId});

  @override
  State<VerifyWithCode> createState() => _VerifyWithCode();
}

class _VerifyWithCode extends State<VerifyWithCode> {
  final TextEditingController verifyDigitController = TextEditingController();

  final auth = FirebaseAuth.instance;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Veify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(children: [
          const SizedBox(
            height: 80,
          ),
          TextFormField(
            controller: verifyDigitController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Enter Your OTP',
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          RoundButton(
              title: "Verify",
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });

                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.VerificationId,
                    smsCode: verifyDigitController.text.toString());

                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostScreen()));
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                }
              })
        ]),
      ),
    );
  }
}
