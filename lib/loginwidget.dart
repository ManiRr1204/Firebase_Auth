import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
          onPressed: SignIn,
          icon: Icon(Icons.lock_open),
          label: Text("Sign In"),
        ),
      ],
    );
  }

  Future SignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      
        email: emailController.text.trim(),
        password: passwordController.text.trim());

  }
}
