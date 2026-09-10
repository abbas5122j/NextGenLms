import 'package:flutter/material.dart';

/// Reusable whole-app page transition.
///
/// Put this around the content area of any persistent app shell. The shell
/// (sidebar/top bar) stays fixed while only the active page wipes in/out.
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
      layoutBuilder: (currentChild, previousChildren) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
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
