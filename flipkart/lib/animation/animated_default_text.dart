import 'package:flutter/material.dart';

class AnimateddefaultText extends StatefulWidget {
  const AnimateddefaultText({super.key});

  @override
  State<AnimateddefaultText> createState() => _AnimateddefaultTextState();
}

class _AnimateddefaultTextState extends State<AnimateddefaultText> {
  bool change = false;

  // @override
  // void initState() {
  //   super.initState();
  //   change != change;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedDefaultTextStyle(
          style: change
              ? const TextStyle(fontSize: 20, color: Colors.green)
              : const TextStyle(fontSize: 50, color: Colors.red),
          duration: const Duration(seconds: 1),
          child: GestureDetector(
            onTap: () {
              change != change;
              setState(() {});
            },
            child: const Text(
              'data',
            ),
          ),
        ),
      ),
    );
  }
}
