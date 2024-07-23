import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class FadeInWidget extends StatelessWidget {
  final Widget child;
  final String direction;

  FadeInWidget({required this.child, this.direction = 'left'});

  @override
  Widget build(BuildContext context) {
    return Animator<double>(
      duration: const Duration(seconds: 1),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeIn,
      builder: (context, animatorState, child) {
        double dx = 0, dy = 0;
        switch (direction) {
          case 'left':
            dx = -50 * (1 - animatorState.value);
            break;
          case 'right':
            dx = 50 * (1 - animatorState.value);
            break;
          case 'top':
            dy = -50 * (1 - animatorState.value);
            break;
          case 'bottom':
            dy = 100 * (1 - animatorState.value);
            break;
          case 'bottom1':
            dy = 150 * (1 - animatorState.value);
            break;
        }

        return Opacity(
          opacity: animatorState.value,
          child: Transform.translate(
            offset: Offset(dx, dy),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
