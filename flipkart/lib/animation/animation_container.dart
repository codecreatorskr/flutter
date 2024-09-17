import 'package:flutter/material.dart';

class AnimationContainer extends StatefulWidget {
  const AnimationContainer({super.key});

  @override
  State<AnimationContainer> createState() => _AnimationContainerState();
}

class _AnimationContainerState extends State<AnimationContainer> {
  bool change = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'container',
        child: Center(
          child: AnimatedContainer(
            width: change ? 300 : 50,
            height: change ? 300 : 50,
            duration: const Duration(seconds: 3),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dp.webp'),
                fit: BoxFit.fill,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  change = !change;
                });
              },
              // child: CircleAvatar(
              //   backgroundImage: const AssetImage('assets/images/dp.webp'),
              //   radius: change ? 100 : 200,
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
