import 'package:flutter/material.dart';

class HeroWidgetAnimation extends StatelessWidget {
  const HeroWidgetAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HeroWidget(
                image: 'assets/images/dp.webp',
              ),
            ),
          );
        },
        child: Center(
          child: Hero(
            tag: 'transition',
            child: Image.asset(
              'assets/images/dp.webp',
              height: 100,
              width: 100,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroWidget extends StatelessWidget {
  final String image;
  const HeroWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'transition',
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
