// import 'dart:html';

// import 'dart:js_interop_unsafe';

import 'package:firebaselearning/ui/auth/signup_screen.dart';
import 'package:firebaselearning/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _emailController.dispose();
  //   _passwordController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Login"),
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
                  title: "Login",
                  onTap: () {
                    if (_formKey.currentState!.validate()) ;
                  }),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
