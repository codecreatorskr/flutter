import 'package:flutter/material.dart';

class StaggredAnimationScreen extends StatefulWidget {
  const StaggredAnimationScreen({super.key});

  @override
  State<StaggredAnimationScreen> createState() =>
      _StaggredAnimationScreenState();
}

class _StaggredAnimationScreenState extends State<StaggredAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> _sizeAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _positionedAnimation;
  late Animation<double> _paddingAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _sizeAnimation = Tween<double>(begin: 80, end: 200).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.25),
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.75, 1)));
    _paddingAnimation = Tween<double>(begin: 30, end: 0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.75, 1)));
    _positionedAnimation = Tween<double>(begin: 0, end: 100).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.25, 0.50)));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Staggered Animation',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      controller.forward();
                    },
                    onDoubleTap: () {
                      controller.reverse();
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: _sizeAnimation.value,
                      width: 80 + (_sizeAnimation.value / 4),
                      color: Colors.orange,
                      child: Container(
                        alignment: Alignment.center,
                        height: _positionedAnimation.value,
                        width: 80 + (_sizeAnimation.value / 4),
                        color: Colors.blueGrey,
                        child: Padding(
                            padding: EdgeInsets.only(
                              top: _paddingAnimation.value,
                            ),
                            child: Text(
                              'saurabh',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white
                                    .withOpacity(_fadeAnimation.value),
                              ),
                            )),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
