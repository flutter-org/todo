import 'package:flutter/material.dart';

class FractionallySizedTransition extends AnimatedWidget {
  final Widget? child;

  FractionallySizedTransition({
    Key? key,
    double beginFactor = 0.1,
    double endFactor = 1.0,
    required AnimationController controller,
    this.child,
  }) : super(key: key, listenable: _buildAnimation(controller));

  static Animation<double> _buildAnimation(AnimationController controller) {
    Animation<double> parentAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceIn,
    );
    Tween<double> tween = Tween<double>(begin: 0.4, end: 0.5);
    Animation<double> animation = tween.animate(parentAnimation);
    return animation;
  }

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable as Animation<double>;
    return FractionallySizedBox(
      widthFactor: animation.value,
      heightFactor: animation.value,
      child: child,
    );
  }
}
