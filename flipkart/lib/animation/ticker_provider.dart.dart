import 'dart:math';

import 'package:flutter/material.dart';

class TrickerProviderAnimation extends StatefulWidget {
  const TrickerProviderAnimation({super.key});

  @override
  State<TrickerProviderAnimation> createState() =>
      _TrickerProviderAnimationState();
}

class _TrickerProviderAnimationState extends State<TrickerProviderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      // lowerBound: 0,
      // upperBound: 1,
      duration: const Duration(seconds: 3),
    )..forward();
    _animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        child: GestureDetector(
          onTap: () {
            controller.reverse();
            // controller.stop();
          },
          onDoubleTap: () {
            controller.repeat();
          },
          child: Center(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.value.toString(),
              ),
              const SizedBox(height: 50),
              Transform.rotate(
                angle: controller.value * 2 * pi,
                child: child,
              ),
              const SizedBox(height: 20),
              //scaletrans
              GestureDetector(
                onTap: () {
                  controller.repeat(reverse: true);
                },
                onDoubleTap: () {
                  controller.stop();
                },
                child: ScaleTransition(
                  scale: _animation,
                  child: Image.asset(
                    'assets/images/avatar.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
