import 'package:flutter/material.dart';

import 'student_sidebar.dart';
import 'student_top_bar.dart';

/// ONE application shell for every Student screen.
///
/// The sidebar and top bar are created here exactly once.
/// Every feature screen supplies only its content through [child].
class StudentLmsShell extends StatelessWidget {
  final int activeIndex;
  final String userName;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final ValueChanged<int> onSidebarSelected;
  final VoidCallback? onSignOut;
  final VoidCallback? onSettings;
  final Widget child;

  const StudentLmsShell({
    super.key,
    required this.activeIndex,
    required this.userName,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onSidebarSelected,
    required this.child,
    this.onSignOut,
    this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final background =
        isDarkMode ? const Color(0xFF090D16) : const Color(0xFFF4F6FB);

    return Scaffold(
      backgroundColor: background,
      body: Row(
        children: [
          StudentSidebar(
            activeIndex: activeIndex,
            isDarkMode: isDarkMode,
            onItemSelected: onSidebarSelected,
            onSignOut: onSignOut,
            onSettings: onSettings,
          ),
          Expanded(
            child: Column(
              children: [
                StudentTopBar(
                  userName: userName,
                  isDarkMode: isDarkMode,
                  onToggleDarkMode: onToggleDarkMode,
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
