import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({super.key, required this.onClickedSignIn});

  @override
  State<SignUpWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: emailController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              labelText: "E-mail", prefixIcon: Icon(Icons.email)),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
              labelText: "Password", prefixIcon: Icon(Icons.lock)),
        ),
        const SizedBox(
          height: 40,
        ),
        ElevatedButton.icon(
          onPressed: SignUp,
          icon: Icon(Icons.arrow_forward),
          label: Text("Sign Up"),
        ),
        const SizedBox(
          height: 20,
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: "Are You Have an Account? ",
                children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignIn,
                  text: "Log In",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                  ))
            ]))
      ],
    );
  }

  Future SignUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
