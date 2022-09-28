import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOut extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Signed In As", style: TextStyle(fontSize: 16),),
          Text(user.email!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(
          height: 30,
        ),
        ElevatedButton.icon(
          onPressed: () => FirebaseAuth.instance.signOut(),
          icon: const Icon(Icons.arrow_back),
          label: const Text("Sign Out"),
        ),
        ],
      ),
    );
  }
}
