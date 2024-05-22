import 'package:flutter/material.dart';
import 'package:flutter_moving_background/enums/animation_types.dart';
import 'package:flutter_moving_background/flutter_moving_background.dart';

class CirclesBackground extends StatelessWidget {
  const CirclesBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MovingBackground(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      animationType: AnimationType.translation,
      duration: const Duration(seconds: 35),
      circles: const [
        MovingCircle(
          color: Colors.lightBlue,
          radius: 100,
        ),
        MovingCircle(
          color: Colors.blue,
          radius: 100,
        ),
        MovingCircle(
          color: Colors.green,
          radius: 100,
        ),
        MovingCircle(
          color: Colors.purple,
          radius: 100,
        ),
        MovingCircle(
          color: Colors.lightGreen,
          radius: 100,
        ),
        MovingCircle(
          color: Colors.deepPurple,
          radius: 100,
        ),
        MovingCircle(
          color: Colors.lime,
          radius: 100,
        ),
      ],
      child: child,
    );
  }
}
