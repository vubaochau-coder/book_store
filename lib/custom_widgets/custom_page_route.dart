import 'package:flutter/material.dart';

class PageRouteSlideTransition extends PageRouteBuilder {
  final Widget child;

  PageRouteSlideTransition({
    required this.child,
  }) : super(pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
