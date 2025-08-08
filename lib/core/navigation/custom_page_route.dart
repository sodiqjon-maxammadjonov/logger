import 'package:flutter/material.dart';

class FadeSlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  FadeSlidePageRoute({required this.child})
      : super(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    child,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      final curve = CurveTween(curve: Curves.easeOutQuint);

      final slideAnimation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(curve).animate(animation);

      final fadeAnimation = FadeTransition(
        opacity: animation,
        child: child,
      );

      return SlideTransition(
        position: slideAnimation,
        child: fadeAnimation,
      );
    },
  );
}