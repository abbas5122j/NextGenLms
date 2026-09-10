import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Single shared sidebar used by every Student section.
///
/// IMPORTANT:
/// Do not create another sidebar inside Home, LMS Coding, Courses,
/// Projects, Gamify, Sophia, etc. Use StudentLmsShell instead.
///
/// Navigation indexes:
/// 0  -> Home Hub
/// 1  -> LMS Coding
/// 2  -> Gamify Learnings
/// 3  -> Courses
/// 4  -> Projects
/// 5  -> Sophia AI Tutor
/// 6  -> Voice Assistant
/// 7  -> Payment History
/// 8  -> Quizzes
/// 9  -> Assignment
/// 10 -> Announcement
/// 11 -> Certification
/// 12 -> Report
/// 13 -> ATS Resume Builder
/// 14 -> FAQs
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

  // ============================================================
  // COLORS
  // ============================================================

  static const Color green = Color(0xFF22C55E);
  static const Color orange = Color(0xFFFF5722);
  static const Color red = Color(0xFFEF4444);

  static const Color lightBackground = Colors.white;
  static const Color lightPrimaryText = Color(0xFF0F172A);
  static const Color lightSecondaryText = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightSelected =
      Color(0xFFFFF4EE);

  static const Color darkBackground =
      Color(0xFF131927);
  static const Color darkPrimaryText =
      Colors.white;
  static const Color darkSecondaryText =
      Color(0xFF94A3B8);
  static const Color darkBorder =
      Color(0xFF1E293B);
  static const Color darkSelected =
      Color(0xFF241A16);

  // ============================================================
  // SIDEBAR ITEMS
  // ============================================================

  static const List<Map<String, dynamic>> items = [
    {
      'title': 'Home Hub',
      'icon': Icons.home_outlined,
    },
    {
      'title': 'LMS Coding',
      'icon': Icons.code,
    },
    {
      'title': 'Gamify Learnings',
      'icon': Icons.stars_outlined,
    },
    {
      'title': 'Courses',
      'icon': Icons.menu_book_outlined,
    },
    {
      'title': 'Projects',
      'icon': Icons.work_outline,
    },
    {
      'title': 'Sophia AI Tutor',
      'icon': Icons.psychology_outlined,
    },
    {
      'title': 'Voice Assistant',
      'icon': Icons.mic_none,
    },

    // ==========================================================
    // PAYMENT HISTORY
    // ==========================================================
    {
      'title': 'Payment History',
      'icon': Icons.credit_card,
    },

    {
      'title': 'Quizzes',
      'icon': Icons.help_outline,
    },
    {
      'title': 'Assignment',
      'icon': Icons.assignment_outlined,
    },
    {
      'title': 'Announcement',
      'icon': Icons.campaign_outlined,
    },
    {
      'title': 'Certification',
      'icon': Icons.workspace_premium_outlined,
    },
    {
      'title': 'Report',
      'icon': Icons.bar_chart_outlined,
    },
    {
      'title': 'ATS Resume Builder',
      'icon': Icons.description_outlined,
    },
    {
      'title': 'FAQs',
      'icon': Icons.chat_bubble_outline,
    },
  ];

  // ============================================================
  // THEME COLORS
  // ============================================================

  Color get background =>
      widget.isDarkMode
          ? darkBackground
          : lightBackground;

  Color get primaryText =>
      widget.isDarkMode
          ? darkPrimaryText
          : lightPrimaryText;

  Color get secondaryText =>
      widget.isDarkMode
          ? darkSecondaryText
          : lightSecondaryText;

  Color get border =>
      widget.isDarkMode
          ? darkBorder
          : lightBorder;

  Color get selectedBackground =>
      widget.isDarkMode
          ? darkSelected
          : lightSelected;

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 220,
      ),
      curve: Curves.easeInOut,
      width: isCollapsed ? 70 : 220,
      color: background,
      child: Column(
        children: [
          _buildHeader(),

          // ======================================================
          // MAIN NAVIGATION
          // ======================================================

          Expanded(
            child: _buildNavigation(),
          ),

          // ======================================================
          // BOTTOM ACTIONS
          // ======================================================

          _buildBottomActions(),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 60,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: border,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: isCollapsed
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          if (!isCollapsed)
            Expanded(
              child: _buildLogo(),
            ),

          _buildCollapseButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: green,
            borderRadius:
                BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              'N',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        Flexible(
          child: RichText(
            overflow:
                TextOverflow.ellipsis,
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight:
                    FontWeight.bold,
              ),
              children: const [
                TextSpan(
                  text: 'Next Gen ',
                  style: TextStyle(
                    color: green,
                  ),
                ),
                TextSpan(
                  text: 'LMS',
                  style: TextStyle(
                    color: red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCollapseButton() {
    return IconButton(
      tooltip: isCollapsed
          ? 'Expand sidebar'
          : 'Collapse sidebar',
      icon: Icon(
        isCollapsed
            ? Icons.chevron_right
            : Icons.chevron_left,
        size: 20,
        color: secondaryText,
      ),
      onPressed: () {
        setState(() {
          isCollapsed = !isCollapsed;
        });
      },
    );
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  Widget _buildNavigation() {
    return Scrollbar(
      child: ListView.builder(
        padding:
            const EdgeInsets.symmetric(
          vertical: 8,
        ),
        itemCount: items.length,
        itemBuilder:
            (context, index) {
          final item = items[index];

          final String title =
              item['title'] as String;

          final IconData icon =
              item['icon'] as IconData;

          final bool selected =
              widget.activeIndex == index;

          return _buildNavigationItem(
            index: index,
            title: title,
            icon: icon,
            selected: selected,
          );
        },
      ),
    );
  }

  Widget _buildNavigationItem({
    required int index,
    required String title,
    required IconData icon,
    required bool selected,
  }) {
    return Tooltip(
      message:
          isCollapsed ? title : '',
      waitDuration:
          const Duration(milliseconds: 400),
      child: Container(
        margin:
            const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 1,
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(8),
          color: selected
              ? selectedBackground
              : Colors.transparent,
        ),
        child: ListTile(
          dense: true,
          minLeadingWidth: 24,
          horizontalTitleGap: 10,
          contentPadding:
              EdgeInsets.symmetric(
            horizontal:
                isCollapsed ? 16 : 12,
          ),

          // ------------------------------------------------------
          // ICON
          // ------------------------------------------------------

          leading: Icon(
            icon,
            size: 18,
            color: selected
                ? orange
                : secondaryText,
          ),

          // ------------------------------------------------------
          // TITLE
          // ------------------------------------------------------

          title: isCollapsed
              ? null
              : Text(
                  title,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: selected
                        ? orange
                        : primaryText,
                  ),
                ),

          selected: selected,

          selectedTileColor:
              Colors.transparent,

          // ------------------------------------------------------
          // PAYMENT HISTORY
          // ------------------------------------------------------
          //
          // Payment History is index 7.
          //
          // The sidebar does not directly create the payment
          // screen. It sends index 7 to StudentLmsShell through
          // onItemSelected.
          //
          // StudentLmsShell must then display:
          //
          // PaymentHistoryScreen()
          //
          // for index 7.
          // ------------------------------------------------------

          onTap: () {
            widget.onItemSelected(index);
          },
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM ACTIONS
  // ============================================================

  Widget _buildBottomActions() {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: border,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildBottomItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            color: primaryText,
            onTap: widget.onSettings,
          ),

          _buildBottomItem(
            icon: Icons.logout,
            title: 'Sign Out',
            color: red,
            onTap: widget.onSignOut,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomItem({
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Tooltip(
      message:
          isCollapsed ? title : '',
      child: ListTile(
        dense: true,
        minLeadingWidth: 24,
        horizontalTitleGap: 10,
        contentPadding:
            EdgeInsets.symmetric(
          horizontal:
              isCollapsed ? 16 : 12,
        ),
        leading: Icon(
          icon,
          size: 18,
          color: color,
        ),
        title: isCollapsed
            ? null
            : Text(
                title,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight:
                      title == 'Sign Out'
                          ? FontWeight.w600
                          : FontWeight.w500,
                  color: color,
                ),
              ),
        onTap: onTap,
      ),
    );
  }
}