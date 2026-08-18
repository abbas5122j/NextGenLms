import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared top bar matching the LMS Coding interface.
class StudentTopBar extends StatelessWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final VoidCallback? onNotifications;
  final ValueChanged<String>? onSearch;

  const StudentTopBar({
    super.key,
    required this.userName,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    this.onNotifications,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary =
        isDarkMode ? Colors.white : const Color(0xFF0F172A);
    final textSub =
        isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final cardBg =
        isDarkMode ? const Color(0xFF131927) : Colors.white;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: cardBg,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onChanged: onSearch,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: textPrimary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search courses, projects, concepts...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF94A3B8),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 16,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(
              isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.dark_mode_outlined,
              size: 20,
              color: isDarkMode
                  ? Colors.amber
                  : const Color(0xFF64748B),
            ),
            onPressed: onToggleDarkMode,
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Notifications',
            icon: Icon(
              Icons.notifications_none,
              size: 20,
              color: textSub,
            ),
            onPressed: onNotifications,
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFFF6B35),
            child: Text(
              userName.isNotEmpty
                  ? userName[0].toUpperCase()
                  : 'A',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              Text(
                'Student',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: textSub,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
