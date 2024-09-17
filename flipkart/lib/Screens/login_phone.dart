import 'package:flutter/material.dart';
import 'package:my_first_app/Screens/otp_verification_screen.dart';
import 'package:my_first_app/api_services/firebase_api.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  TextEditingController countryController = TextEditingController();

  var phone = '';

  @override
  void initState() {
    super.initState();
    countryController.text = '+91';
  }

  @override
  void dispose() {
    countryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      controller: countryController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Enter phone number",
                      ),
                      onChanged: (value) {
                        phone = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseApi.instance.phoneVerify(countryController.text, phone);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpVerificationScreen(),
                    ));
              },
              child: const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
