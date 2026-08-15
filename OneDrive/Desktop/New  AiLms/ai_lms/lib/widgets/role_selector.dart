import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onRoleSelected;

  const RoleSelector({
    super.key,
    required this.selectedIndex,
    required this.onRoleSelected,
  });

  static final List<Map<String, dynamic>> roles = [
    {'title': 'Student', 'icon': Icons.school_outlined, 'color': Colors.redAccent},
    {'title': 'College', 'icon': Icons.account_balance_outlined, 'color': Colors.amber.shade800},
    {'title': 'Instructor', 'icon': Icons.work_outline, 'color': Colors.brown},
    {'title': 'Admin', 'icon': Icons.military_tech_outlined, 'color': Colors.orangeAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT PORTAL ROLE',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: const Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: List.generate(roles.length, (index) {
              final isSelected = selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onRoleSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : [],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          roles[index]['icon'],
                          size: 16,
                          color: isSelected ? roles[index]['color'] : const Color(0xFF64748B),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          roles[index]['title'],
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? roles[index]['color'] : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}