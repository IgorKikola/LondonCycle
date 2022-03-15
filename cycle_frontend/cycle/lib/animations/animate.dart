import 'package:flutter/material.dart';

class Animations {
  static grow(Animation<double> _animation, Animation<double> _secondaryAnimation, Widget _child) {
    return ScaleTransition(
      child: _child,
      scale: Tween<double>(end: 1.0, begin: 0.5)
          .animate(CurvedAnimation(parent: _animation, curve: Interval(0.00, 0.50, curve: Curves.linear))),
    );
  }
  static fade(Animation<double> _animation, Animation<double> _secondaryAnimation, Widget _child) {
    return FadeTransition(
      child: _child,
      alwaysIncludeSemantics: true,
      opacity: Tween<double>(end: 1.0, begin: 0)
          .animate(CurvedAnimation(parent: _animation, curve: Interval(0.50, 1.00, curve: Curves.linear))),
    );
  }
}
