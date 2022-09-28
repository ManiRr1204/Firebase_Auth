import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class LoginWidget extends StatefulWidget {
  final Function() onClickedSignUp;
  const LoginWidget({super.key, required this.onClickedSignUp});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) => 
            email != null && !EmailValidator.validate(email) 
            ? "Enter a Valid Mail": null,
            decoration: const InputDecoration(
                labelText: "E-mail", prefixIcon: Icon(Icons.email),),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 
            value != null && value.length < 6
            ? "Enter min. 6 digits": null,
            decoration: const InputDecoration(
                labelText: "Password", prefixIcon: Icon(Icons.lock)),
                
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
            onPressed: SignIn,
            icon: Icon(Icons.lock_open),
            label: Text("Sign In"),
          ),
          const SizedBox(
            height: 20,
          ),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: "No Account? ",
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: "Sign Up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary,
                    ))
              ]))
        ],
      ),
    );
  }

  Future SignIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
