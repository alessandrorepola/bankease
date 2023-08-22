import 'package:bankease/src/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            AuthViewModel().signOut(context);
          },
        ),
      ],
      ),
    );
  }
}
