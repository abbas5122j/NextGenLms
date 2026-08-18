import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Single shared sidebar used by every Student section.
///
/// IMPORTANT:
/// Do not create another sidebar inside Home, LMS Coding, Courses,
/// Projects, Gamify, Sophia, etc. Use StudentLmsShell instead.
class StudentSidebar extends StatefulWidget {
  final int activeIndex;
  final bool isDarkMode;
  final ValueChanged<int> onItemSelected;
  final VoidCallback? onSignOut;
  final VoidCallback? onSettings;

  const StudentSidebar({
    super.key,
    required this.activeIndex,
    required this.isDarkMode,
    required this.onItemSelected,
    this.onSignOut,
    this.onSettings,
  });

  @override
  State<StudentSidebar> createState() => _StudentSidebarState();
}

class _StudentSidebarState extends State<StudentSidebar> {
  bool isCollapsed = false;

  static const items = <Map<String, dynamic>>[
    {'title': 'Home Hub', 'icon': Icons.home_outlined},
    {'title': 'LMS Coding', 'icon': Icons.code},
    {'title': 'Gamify Learnings', 'icon': Icons.stars_outlined},
    {'title': 'Courses', 'icon': Icons.menu_book_outlined},
    {'title': 'Projects', 'icon': Icons.work_outline},
    {'title': 'Sophia AI Tutor', 'icon': Icons.psychology_outlined},
    {'title': 'Voice Assistant', 'icon': Icons.mic_none},
    {'title': 'Payment History', 'icon': Icons.credit_card},
    {'title': 'Quizzes', 'icon': Icons.help_outline},
    {'title': 'Assignment', 'icon': Icons.assignment_outlined},
    {'title': 'Announcement', 'icon': Icons.campaign_outlined},
    {'title': 'Certification', 'icon': Icons.workspace_premium_outlined},
    {'title': 'Report', 'icon': Icons.bar_chart_outlined},
  ];

  Color get background =>
      widget.isDarkMode ? const Color(0xFF131927) : Colors.white;

  Color get primaryText =>
      widget.isDarkMode ? Colors.white : const Color(0xFF0F172A);

  Color get secondaryText =>
      widget.isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

  Color get border =>
      widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isCollapsed ? 70 : 220,
      color: background,
      child: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: border)),
            ),
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (!isCollapsed)
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'N',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          children: const [
                            TextSpan(
                              text: 'Next Gen ',
                              style: TextStyle(color: Color(0xFF22C55E)),
                            ),
                            TextSpan(
                              text: 'LMS',
                              style: TextStyle(color: Color(0xFFEF4444)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                IconButton(
                  icon: Icon(
                    isCollapsed
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                    size: 20,
                    color: secondaryText,
                  ),
                  onPressed: () {
                    setState(() => isCollapsed = !isCollapsed);
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final selected = widget.activeIndex == index;

                return Tooltip(
                  message: isCollapsed ? item['title'] as String : '',
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: 24,
                    leading: Icon(
                      item['icon'] as IconData,
                      size: 18,
                      color: selected
                          ? const Color(0xFFFF5722)
                          : secondaryText,
                    ),
                    title: isCollapsed
                        ? null
                        : Text(
                            item['title'] as String,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: selected
                                  ? const Color(0xFFFF5722)
                                  : primaryText,
                            ),
                          ),
                    selected: selected,
                    selectedTileColor: widget.isDarkMode
                        ? const Color(0xFF241A16)
                        : const Color(0xFFFFF4EE),
                    onTap: () => widget.onItemSelected(index),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: border)),
            ),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  minLeadingWidth: 24,
                  leading: const Icon(
                    Icons.settings_outlined,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                  title: isCollapsed
                      ? null
                      : Text(
                          'Settings',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryText,
                          ),
                        ),
                  onTap: widget.onSettings,
                ),
                ListTile(
                  dense: true,
                  minLeadingWidth: 24,
                  leading: const Icon(
                    Icons.logout,
                    size: 18,
                    color: Color(0xFFEF4444),
                  ),
                  title: isCollapsed
                      ? null
                      : Text(
                          'Sign Out',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFEF4444),
                          ),
                        ),
                  onTap: widget.onSignOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
