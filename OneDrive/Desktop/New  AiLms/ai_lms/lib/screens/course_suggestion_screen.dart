import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/course_data.dart';

class CourseSuggestionScreen extends StatefulWidget {
  final String? initialSelectedBranch;
  final VoidCallback onBack;
  final ValueChanged<String> onNext;

  const CourseSuggestionScreen({
    super.key,
    this.initialSelectedBranch,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<CourseSuggestionScreen> createState() => _CourseSuggestionScreenState();
}

class _CourseSuggestionScreenState extends State<CourseSuggestionScreen> {
  late String selectedBranch;
  int selectedCourseIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedBranch != null &&
        branchCourseSuggestions.containsKey(widget.initialSelectedBranch)) {
      selectedBranch = widget.initialSelectedBranch!;
    } else {
      selectedBranch = branchCourseSuggestions.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> currentCourses =
        branchCourseSuggestions[selectedBranch] ?? branchCourseSuggestions.values.first;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sophia will run a course-specific aptitude assessment tailored to your chosen path.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selected Branch:',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedBranch,
                          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFFF6B35), size: 20),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFF6B35),
                          ),
                          items: branchCourseSuggestions.keys.map((branch) {
                            return DropdownMenuItem(
                              value: branch,
                              child: Text(branch),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                selectedBranch = val;
                                selectedCourseIndex = 0;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: List.generate(currentCourses.length, (index) {
                    final isSelected = selectedCourseIndex == index;
                    return _buildCourseCard(
                      index: index,
                      course: currentCourses[index],
                      isSelected: isSelected,
                    );
                  }),
                ),

                const SizedBox(height: 48),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: widget.onBack,
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, size: 16, color: Color(0xFF475569)),
                          const SizedBox(width: 6),
                          Text(
                            'Back',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          final selectedCourseMap = currentCourses[selectedCourseIndex];
                          widget.onNext(selectedCourseMap['title'] ?? 'Full-Stack Web Development');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B35),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
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

  Widget _buildCourseCard({
    required int index,
    required Map<String, String> course,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => setState(() => selectedCourseIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFFE2E8F0),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? const Color(0xFFFF6B35).withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F172A),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Center(
                    child: _buildCardMockGraphic(course['type']!),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'SELECTED',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['title']!,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    course['tags']!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(color: Color(0xFFF1F5F9), height: 1),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Specific Track',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 14, color: Color(0xFFFF6B35)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardMockGraphic(String type) {
    if (type == 'web') {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  _dot(Colors.redAccent), const SizedBox(width: 4),
                  _dot(Colors.amber), const SizedBox(width: 4),
                  _dot(Colors.green),
                ]),
                const SizedBox(height: 8),
                Container(width: 80, height: 4, color: Colors.blueAccent),
                const SizedBox(height: 4),
                Container(width: 50, height: 4, color: Colors.pinkAccent),
              ],
            ),
            const SizedBox(width: 20),
            const Icon(Icons.code, size: 36, color: Colors.cyanAccent),
          ],
        ),
      );
    } else if (type == 'ai') {
      return const Icon(Icons.hub_outlined, size: 44, color: Colors.orangeAccent);
    } else if (type == 'flutter') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blueAccent, width: 1.5),
            ),
            child: const Icon(Icons.change_history, size: 24, color: Colors.amber),
          ),
        ],
      );
    } else {
      return const Icon(Icons.terminal_outlined, size: 40, color: Colors.lightGreenAccent);
    }
  }

  Widget _dot(Color color) {
    return Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}