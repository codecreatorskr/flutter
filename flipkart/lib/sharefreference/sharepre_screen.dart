import 'dart:developer';

import 'package:flutter/material.dart';

class SharedPreScreen extends StatefulWidget {
  const SharedPreScreen({super.key});

  @override
  State<SharedPreScreen> createState() => _SharedPreScreenState();
}

class _SharedPreScreenState extends State<SharedPreScreen> {
  final controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sharedpreference'),
      ),
      body: Column(
        children: [
          Text(controller.text),
          TextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            style: const TextStyle(),
          ),
          ElevatedButton(
            onPressed: () {
              String text = controller.text.toString();
              final texts = text;
              log(texts);
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }
}
