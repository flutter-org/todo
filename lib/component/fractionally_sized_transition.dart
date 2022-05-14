import 'package:flutter/material.dart';

class FractionallySizedTransition extends AnimatedWidget {
  final Widget? child;

  const FractionallySizedTransition({
    Key? key,
    required Animation<double> factor,
    this.child,
  }) : super(key: key, listenable: factor);

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
