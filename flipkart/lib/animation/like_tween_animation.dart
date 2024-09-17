import 'dart:developer';

import 'package:flutter/material.dart';

class LikeTweenAnimation extends StatefulWidget {
  const LikeTweenAnimation({super.key});

  @override
  State<LikeTweenAnimation> createState() => _LikeTweenAnimationState();
}

class _LikeTweenAnimationState extends State<LikeTweenAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  bool like = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // final curve =
    //     CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    final curve = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut));

    _colorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(curve);

    _controller.addListener(() {
      log(_colorAnimation.value.toString(), name: 'conrollerlistener');
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        like = true;
      } else if (status == AnimationStatus.dismissed) {
        like = false;
      }
      log(status.toString(), name: 'status');
    });

    // _sizeAnimation = TweenSequence<double>(
    //   [
    //     TweenSequenceItem(tween: Tween<double>(begin: 50, end: 70), weight: 50),
    //     TweenSequenceItem(
    //         tween: Tween<double>(begin: 70, end: 50), weight: 100),
    //   ],
    // ).animate(curve);

    _sizeAnimation = Tween<double>(begin: 50, end: 70).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Animation',
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _colorAnimation,
              builder: (BuildContext context, Widget? child) {
                return IconButton(
                  onPressed: () {
                    like ? _controller.reverse() : _controller.forward();
                    // setState(() {
                    //   like = !like;
                    // });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: _colorAnimation.value,
                    size: _sizeAnimation.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
