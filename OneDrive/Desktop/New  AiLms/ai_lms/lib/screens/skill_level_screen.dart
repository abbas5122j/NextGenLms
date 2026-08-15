import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillLevelScreen extends StatefulWidget {
  final String userName;
  final String selectedCourseTitle;
  final VoidCallback onChangeTrack;
  final ValueChanged<String> onContinue;

  const SkillLevelScreen({
    super.key,
    required this.userName,
    required this.selectedCourseTitle,
    required this.onChangeTrack,
    required this.onContinue,
  });

  @override
  State<SkillLevelScreen> createState() => _SkillLevelScreenState();
}

class _SkillLevelScreenState extends State<SkillLevelScreen> {
  int? selectedLevelIndex;

  final List<Map<String, dynamic>> levels = [
    {
      'id': 'beginner',
      'title': 'Beginner',
      'badge': 'Foundational',
      'badgeColor': const Color(0xFFDCFCE7),
      'badgeTextColor': const Color(0xFF166534),
      'icon': Icons.eco_outlined,
      'iconBg': const Color(0xFFDCFCE7),
      'iconColor': const Color(0xFF16A34A),
      'description':
          'Brand new or still learning basics. Get a full foundational level-by-level study roadmap immediately.',
    },
    {
      'id': 'intermediate',
      'title': 'Intermediate',
      'badge': 'AI Level Evaluator',
      'badgeColor': const Color(0xFFFFEDD5),
      'badgeTextColor': const Color(0xFFC2410C),
      'icon': Icons.bolt_outlined,
      'iconBg': const Color(0xFFFFEDD5),
      'iconColor': const Color(0xFFEA580C),
      'description':
          'Understand syntax but want validation. Sophia (AI Evaluation) conducts a technical screening & built-in logic test.',
    },
    {
      'id': 'advanced',
      'title': 'Advanced',
      'badge': 'Elite Level-Test',
      'badgeColor': const Color(0xFFF3E8FF),
      'badgeTextColor': const Color(0xFF6B21A8),
      'icon': Icons.emoji_events_outlined,
      'iconBg': const Color(0xFFF3E8FF),
      'iconColor': const Color(0xFF9333EA),
      'description':
          "Expert builder. Pass Sophia's high-fidelity professional level-test and logic compiler challenge to lock advanced starting level.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 820,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECE5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'SAAS PLACEMENT GATEKEEPER',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFFF6B35),
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  'Define Your Current Skill Level',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B)),
                    children: [
                      TextSpan(text: 'Welcome ${widget.userName}! Tell us your technical experience with '),
                      TextSpan(
                        text: widget.selectedCourseTitle.toUpperCase(),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                      const TextSpan(text: ' to calibrate your learning path.'),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 650;
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: List.generate(levels.length, (index) {
                        final level = levels[index];
                        final isSelected = selectedLevelIndex == index;

                        return GestureDetector(
                          onTap: () => setState(() => selectedLevelIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isWide ? 220 : double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFFE2E8F0),
                                width: isSelected ? 2.0 : 1.0,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFFFF6B35).withValues(alpha: 0.1),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: level['iconBg'],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(level['icon'], size: 20, color: level['iconColor']),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: level['badgeColor'],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        level['badge'],
                                        style: GoogleFonts.inter(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: level['badgeTextColor'],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                Text(
                                  level['title'],
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  level['description'],
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),

                const SizedBox(height: 36),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: widget.onChangeTrack,
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, size: 14, color: Color(0xFF475569)),
                          const SizedBox(width: 4),
                          Text(
                            'Change Track',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: selectedLevelIndex != null
                            ? () => widget.onContinue(levels[selectedLevelIndex!]['id'])
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B35),
                          disabledBackgroundColor: const Color(0xFFE2E8F0),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Continue',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: selectedLevelIndex != null ? Colors.white : const Color(0xFF94A3B8),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: selectedLevelIndex != null ? Colors.white : const Color(0xFF94A3B8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}