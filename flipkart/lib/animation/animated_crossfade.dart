import 'package:flutter/material.dart';

class AnimatedCrossFadeScreen extends StatefulWidget {
  const AnimatedCrossFadeScreen({super.key});

  @override
  State<AnimatedCrossFadeScreen> createState() =>
      _AnimatedCrossFadeScreenState();
}

class _AnimatedCrossFadeScreenState extends State<AnimatedCrossFadeScreen> {
  final bool _first = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
        onTap: () {
          _first != _first;
          setState(() {});
        },
        child: AnimatedCrossFade(
          duration: const Duration(seconds: 3),
          firstChild: const FlutterLogo(
              style: FlutterLogoStyle.horizontal, size: 100.0),
          secondChild:
              const FlutterLogo(style: FlutterLogoStyle.stacked, size: 500.0),
          crossFadeState:
              _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      )
          // AnimatedCrossFade(
          //   // sizeCurve: Curves.bounceInOut,
          //   // firstCurve: Curves.bounceIn,
          //   // secondCurve: Curves.bounceOut,
          //   reverseDuration: const Duration(seconds: 1),
          //   firstChild: const Text(
          //     'First',
          //     style: TextStyle(fontSize: 50),
          //   ),
          //   secondChild: const Text(
          //     'secondChild',
          //     style: TextStyle(fontSize: 50),
          //   ),
          //   crossFadeState:
          //       change ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          //   duration: const Duration(seconds: 1),
          // ),
          ),
    );
  }
}
