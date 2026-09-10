import 'package:flutter/material.dart';

class AppPageTransition extends StatelessWidget {
  final Object pageKey;
  final Widget child;
  final Duration duration;

  const AppPageTransition({
    super.key,
    required this.pageKey,
    required this.child,
    this.duration = const Duration(milliseconds: 460),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: const Duration(milliseconds: 360),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      layoutBuilder: (current, previous) => Stack(
        fit: StackFit.expand,
        children: [...previous, if (current != null) current],
      ),
      transitionBuilder: (child, animation) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: curved.value,
              child: child,
            ),
          ),
        );
      },
      child: KeyedSubtree(key: ValueKey(pageKey), child: child),
    );
  }
}
