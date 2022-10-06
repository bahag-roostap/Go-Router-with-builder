import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A page that fades in an out.
class FadeTransitionPage<Object> extends CustomTransitionPage<Object> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: animation.drive(_curveTween),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeOutSine);
}

class SlideRoute extends CustomTransitionPage<void> {
  SlideRoute({
    required LocalKey key,
    required Widget child,
    Offset beginOffset = const Offset(1.0, 0.0),
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: beginOffset,
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
