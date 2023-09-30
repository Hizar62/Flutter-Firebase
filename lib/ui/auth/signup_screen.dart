import 'package:firebaselearning/ui/auth/login_screen.dart';
import 'package:firebaselearning/widgets/round_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    // controller: _emailController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Name', suffix: Icon(Icons.person)),
                  ),
                  TextFormField(
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        helperText: 'info@gmail.com',
                        suffix: Icon(Icons.alternate_email)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        helperText: '[a-z][0-9]',
                        suffix: Icon(Icons.lock)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Sign Up",
                onTap: () {
                  if (_formKey.currentState!.validate()) ;
                }),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
