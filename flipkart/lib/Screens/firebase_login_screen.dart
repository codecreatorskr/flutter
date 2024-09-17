import 'package:flutter/material.dart';
import 'package:my_first_app/Screens/login_phone.dart';
import 'package:my_first_app/Screens/signup_screen.dart';
import 'package:my_first_app/api_services/firebase_api.dart';

class FirebaseLoginScreen extends StatefulWidget {
  const FirebaseLoginScreen({super.key});

  @override
  State<FirebaseLoginScreen> createState() => _FirebaseLoginScreenState();
}

class _FirebaseLoginScreenState extends State<FirebaseLoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    passController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                controller: emailController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'password is required';
                  }
                  return null;
                },
                controller: passController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your Password',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  FirebaseApi.instance
                      .login(emailController.text, passController.text);

                  // FirebaseApi.instance.getUser();
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  FirebaseApi.instance.signInWithGoogle();
                },
                child: const Text('Login With Google'),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPhoneScreen(),
                      ));
                },
                child: const Text('Login With Phone'),
              ),
              const SizedBox(height: 25),

              // ElevatedButton(
              //   onPressed: () {
              //     FirebaseAuth.instance.userChanges();
              //   },
              //   child: const Text('update'),
              // ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreenFirebase(),
                      ),
                      (route) => false);
                },
                child: const Text('Don\'t have an account? sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
