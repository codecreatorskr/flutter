import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/Screens/firebase_login_screen.dart';
import 'package:my_first_app/blocProvider/bloc_todo_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        return snapshot.data == null
            ? const FirebaseLoginScreen()
            : const BlocTodoScreen();
      },
    );
  }
}
