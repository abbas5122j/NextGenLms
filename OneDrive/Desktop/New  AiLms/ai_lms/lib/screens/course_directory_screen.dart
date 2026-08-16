import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/course_data.dart';
import '../models/course_model.dart';

class CourseDirectoryScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback? onToggleDarkMode;
  final ValueChanged<int>? onSelectSidebarIndex;
  final VoidCallback? onSignOut;
  final bool showSidebar;
  

  const CourseDirectoryScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onSelectSidebarIndex,
    this.onSignOut,
    this.showSidebar = true,
  });

  @override
  State<CourseDirectoryScreen> createState() =>
      _CourseDirectoryScreenState();
}

class _CourseDirectoryScreenState
    extends State<CourseDirectoryScreen> {
  // The LMS shell/sidebar is owned by the parent application.
  // This screen only swaps its CONTENT between directory and details.
  Course? selectedCourse;
  int detailTab = 0;
  // ==========================================================
  // BRANCHES
  // ==========================================================

  final List<BranchFilter> branches = const [
    BranchFilter(
      label: 'CSE',
      code: 'CSE',
      icon: Icons.computer_outlined,
      count: 8,
    ),
    BranchFilter(
      label: 'IT',
      code: 'IT',
      icon: Icons.language_outlined,
      count: 6,
    ),
    BranchFilter(
      label: 'ECE',
      code: 'ECE',
      icon: Icons.bolt_outlined,
      count: 6,
    ),
    BranchFilter(
      label: 'EEE',
      code: 'EEE',
      icon: Icons.power_outlined,
      count: 6,
    ),
    BranchFilter(
      label: 'ME',
      code: 'ME',
      icon: Icons.settings_outlined,
      count: 6,
    ),
    BranchFilter(
      label: 'CE',
      code: 'CE',
      icon: Icons.construction_outlined,
      count: 6,
    ),
    BranchFilter(
      label: 'CH',
      code: 'CH',
      icon: Icons.science_outlined,
      count: 6,
    ),
    BranchFilter(
      label: 'AE',
      code: 'AE',
      icon: Icons.flight_outlined,
      count: 6,
    ),
    BranchFilter(
      label: 'ALL',
      code: 'ALL',
      icon: Icons.apps_outlined,
      count: 0,
    ),
  ];

  String selectedBranch = 'CSE';

  String searchQuery = '';

  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color orange = Color(0xFFFF6B35);

  static const Color background =
      Color(0xFFF4F6FB);

  static const Color darkBanner =
      Color(0xFF111827);

  static const Color textDark =
      Color(0xFF111827);

  static const Color textMuted =
      Color(0xFF64748B);

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final dark = widget.isDarkMode;
    final bgColor = dark ? const Color(0xFF090D16) : background;
    final cardColor = dark ? const Color(0xFF131927) : Colors.white;
    final primaryText = dark ? Colors.white : textDark;
    final secondaryText =
        dark ? const Color(0xFF94A3B8) : textMuted;

    return Scaffold(
      backgroundColor: bgColor,
      body: selectedCourse == null
          ? _buildDirectoryContent(cardColor, primaryText, secondaryText)
          : _buildCourseDetailContent(
              selectedCourse!,
              cardColor,
              primaryText,
              secondaryText,
            ),
      floatingActionButton: _buildSophiaButton(),
    );
  }

  Widget _buildDirectoryContent(
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    final courses = _getFilteredCourses();

    return Column(
      children: [
        _buildHeader(cardColor, primaryText, secondaryText),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 18, 28, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBranchFilters(
                  primaryText,
                  secondaryText,
                  cardColor,
                ),
                const SizedBox(height: 24),
                if (courses.isEmpty)
                  _buildEmptyState(primaryText, secondaryText)
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = constraints.maxWidth < 600
                          ? 1
                          : constraints.maxWidth < 900
                              ? 2
                              : 3;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount: courses.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          mainAxisExtent:
                              columns == 3 ? 370 : 390,
                        ),
                        itemBuilder: (context, index) =>
                            _buildCourseCard(
                          courses[index],
                          primaryText,
                          secondaryText,
                          cardColor,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // INLINE COURSE DETAILS
  //
  // No Drawer, NavigationRail, sidebar or second LMS shell is
  // created here. The existing application sidebar stays exactly
  // where it is; only the content area changes.
  // ==========================================================

  Widget _buildCourseDetailContent(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _backToDirectory,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 17,
                    color: Color(0xFFFF5261),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'BACK TO DIRECTORY',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFFF5261),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _detailHero(
            course,
            cardColor,
            primaryText,
            secondaryText,
          ),
          const SizedBox(height: 18),
          _detailTabs(secondaryText),
          const SizedBox(height: 20),
          _detailBody(
            course,
            cardColor,
            primaryText,
            secondaryText,
          ),
        ],
      ),
    );
  }

  Widget _detailHero(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 26, 28, 25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF1E293B)
              : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 850;
          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: orange.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _detailBranch(course),
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: orange,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                course.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: compact ? 27 : 31,
                  height: 1.08,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${course.lessonsCount} Lessons • ${course.duration} • Certified Learning Path Syllabus',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: secondaryText,
                ),
              ),
            ],
          );

          final actions = Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => _launchPlayer(course),
                icon: const Icon(
                  Icons.ondemand_video_outlined,
                  size: 16,
                ),
                label: const Text('Launch Player'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6268),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _practiceQuiz(course),
                icon: const Icon(
                  Icons.menu_book_outlined,
                  size: 16,
                ),
                label: const Text('Take Practice Quiz'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF151922),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                info,
                const SizedBox(height: 18),
                actions,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: info),
              const SizedBox(width: 25),
              actions,
            ],
          );
        },
      ),
    );
  }

  Widget _detailTabs(Color secondaryText) {
    const labels = [
      '📌 Next Class & Pinned Assignment',
      '📚 Prescribed Textbooks',
      'Overview & Scope',
      'Module Curriculum',
      'Peer Reviews',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(labels.length, (index) {
          final active = detailTab == index;
          return InkWell(
            onTap: () => setState(() => detailTab = index),
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 8, 22, 13),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: active
                        ? const Color(0xFFFF5261)
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                labels[index],
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight:
                      active ? FontWeight.w800 : FontWeight.w600,
                  color: active
                      ? const Color(0xFFFF5261)
                      : secondaryText,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _detailBody(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    switch (detailTab) {
      case 1:
        return _booksTab(
          course,
          cardColor,
          primaryText,
          secondaryText,
        );
      case 2:
        return _overviewTab(
          course,
          cardColor,
          primaryText,
          secondaryText,
        );
      case 3:
        return _modulesTab(
          course,
          cardColor,
          primaryText,
          secondaryText,
        );
      case 4:
        return _reviewsTab(
          course,
          cardColor,
          primaryText,
          secondaryText,
        );
      default:
        return _nextClassTab(
          course,
          cardColor,
          primaryText,
          secondaryText,
        );
    }
  }

  Widget _nextClassTab(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    final d = _detailsFor(course);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(28, 26, 28, 28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF075B83),
                Color(0xFF151A4D),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _darkPill('SCHEDULED NEXT DAY CLASS'),
                  Text(
                    'Instructor: ${d.instructor}',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                d.nextClass,
                style: GoogleFonts.inter(
                  fontSize: 19,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, c) {
                  final narrow = c.maxWidth < 800;
                  final objective = _darkBox(
                    'CLASS LEARNING OBJECTIVE',
                    d.objective,
                    const Color(0xFF3EE6E3),
                  );
                  final prep = _darkBox(
                    'PREPARATION & PRE-READING NOTES',
                    d.preparation,
                    const Color(0xFFFFE600),
                  );

                  if (narrow) {
                    return Column(
                      children: [
                        objective,
                        const SizedBox(height: 12),
                        prep,
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: objective),
                      const SizedBox(width: 16),
                      Expanded(child: prep),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Google Meet link is not configured yet.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    size: 16,
                  ),
                  label: const Text(
                    'Join Live Scheduled Google Meet Class',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0BA9ED),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    textStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _assignmentCard(
          course,
          cardColor,
          primaryText,
          secondaryText,
          d,
        ),
      ],
    );
  }

  Widget _darkPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0B78A9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 8,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _darkBox(
    String title,
    String text,
    Color titleColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .055),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: .12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 10.5,
              height: 1.45,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _assignmentCard(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
    _DetailData d,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF55DAB7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INSTRUCTED BY ${d.instructor.toUpperCase()}',
            style: GoogleFonts.inter(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF00A978),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '📌 Class Assignment: ${d.assignment}',
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? const Color(0xFF172033)
                  : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              d.assignmentText,
              style: GoogleFonts.inter(
                fontSize: 10,
                height: 1.45,
                color: secondaryText,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 18,
            runSpacing: 10,
            children: [
              Text(
                'Due Date: Tomorrow, 11:59 PM',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF00A978),
                ),
              ),
              Text(
                'Points: 100 Marks',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF6D28D9),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Assignment submission is ready to connect.',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.description_outlined,
                  size: 15,
                ),
                label: const Text('Submit Assignment Solution'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _booksTab(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    final d = _detailsFor(course);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.menu_book_outlined,
              color: Color(0xFF7C3AED),
            ),
            const SizedBox(width: 8),
            Text(
              'Prescribed Reference Books & Reading List',
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: primaryText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, c) {
            final columns = c.maxWidth > 900 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: d.books.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 205,
              ),
              itemBuilder: (context, i) {
                final book = d.books[i];
                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: widget.isDarkMode
                          ? const Color(0xFF263244)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        book[0],
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF7C3AED),
                        ),
                      ),
                      const SizedBox(height: 11),
                      Text(
                        book[1],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: primaryText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Authors: ${book[2]}',
                        style: GoogleFonts.inter(
                          fontSize: 9.5,
                          color: secondaryText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Text(
                          '📌 Recommended Reading: ${book[3]}',
                          style: GoogleFonts.inter(
                            fontSize: 9.5,
                            height: 1.4,
                            color: const Color(0xFF6D28D9),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '↗ Access Reference Book / PDF',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _overviewTab(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    final d = _detailsFor(course);

    return LayoutBuilder(
      builder: (context, c) {
        final stacked = c.maxWidth < 850;

        final left = Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: widget.isDarkMode
                  ? const Color(0xFF263244)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course Objectives & Scope',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                d.overview,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  height: 1.55,
                  color: secondaryText,
                ),
              ),
              const Divider(height: 30),
              Text(
                'KEY LEARNING OUTCOMES',
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 10),
              ...d.outcomes.map(
                (x) => Padding(
                  padding: const EdgeInsets.only(bottom: 11),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Color(0xFF10B981),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          x,
                          style: GoogleFonts.inter(
                            fontSize: 10.5,
                            height: 1.4,
                            color: secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

        final right = Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: widget.isDarkMode
                  ? const Color(0xFF263244)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sideField(
                'TARGET LEVEL',
                d.level,
                primaryText,
                secondaryText,
              ),
              const Divider(height: 26),
              _sideField(
                'TARGET AUDIENCE',
                d.audience,
                primaryText,
                secondaryText,
              ),
              const Divider(height: 26),
              _sideField(
                'PREREQUISITES',
                d.prerequisites,
                primaryText,
                secondaryText,
              ),
              const Divider(height: 26),
              Text(
                'SKILLS & FRAMEWORKS',
                style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  color: secondaryText,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: d.skills
                    .map(
                      (x) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6)
                              .withValues(alpha: .06),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF8B5CF6)
                                .withValues(alpha: .2),
                          ),
                        ),
                        child: Text(
                          x,
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF6D28D9),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );

        if (stacked) {
          return Column(
            children: [
              left,
              const SizedBox(height: 16),
              right,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: left),
            const SizedBox(width: 18),
            Expanded(child: right),
          ],
        );
      },
    );
  }

  Widget _sideField(
    String label,
    String value,
    Color primaryText,
    Color secondaryText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 8,
            fontWeight: FontWeight.w800,
            color: secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 10,
            height: 1.45,
            color: primaryText,
          ),
        ),
      ],
    );
  }

  Widget _modulesTab(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Showing ${course.modules.length} Modules for ${course.title}',
          style: GoogleFonts.inter(
            fontSize: 10,
            color: secondaryText,
          ),
        ),
        const SizedBox(height: 14),
        ...course.modules.asMap().entries.map(
          (entry) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 13),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isDarkMode
                    ? const Color(0xFF263244)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 17,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF10B981),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Module ${entry.key + 1}: ${entry.value.title}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ),
                  ),
                  Text(
                    '${entry.value.lessonsCount} Lessons • ${entry.value.duration}',
                    style: GoogleFonts.inter(
                      fontSize: 8,
                      color: secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _reviewsTab(
    Course course,
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    final reviews = [
      'Outstanding content for ${course.title}! The Ask AI sidebar in the player helped me clarify so many concepts.',
      'Very thorough syllabus. The module roadmap aligns perfectly with our semester requirements.',
      'Clear explanations, great code/simulation examples, and clean structured curriculum modules.',
    ];
    const names = [
      'Rahul Sahu',
      'Oliver Platt',
      'Ananya Sharma',
    ];

    return Column(
      children: List.generate(
        reviews.length,
        (i) => Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: widget.isDarkMode
                  ? const Color(0xFF263244)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      names[i],
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reviews[i],
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        height: 1.45,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '★★★★★',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFF7A2F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // COURSE-SPECIFIC DESCRIPTIONS
  // ==========================================================

  _DetailData _detailsFor(Course course) {
    final t = course.title.toLowerCase();

    if (t.contains('react') || t.contains('web')) {
      return const _DetailData(
        instructor: 'Instructor Kumar',
        nextClass:
            'React 18 Concurrent Rendering, Suspense & Fiber Reconciliation',
        objective:
            'Master how Fiber trees split rendering work into frame chunks without blocking main browser thread or user input.',
        preparation:
            'Review Chapter 3 on useEffect lifecycle cleanups. Open your LMS Code Playground prior to class start.',
        assignment:
            'Custom Suspense Loader with Error Boundary Retry',
        assignmentText:
            'Build a modular React Suspense container wrapper supporting dynamic fallback skeleton states, error boundary catches, and automated exponential backoff retries.',
        overview:
            'Master modern web frontend architectures, React 18 state hooks, Tailwind CSS, and TypeScript. This course provides hands-on engineering experience in building high-performance single-page applications and deploying scalable production runtimes.',
        level: 'INTERMEDIATE / ADVANCED',
        audience:
            'Software Engineering & Computer Science students wanting production-ready web frontend skills.',
        prerequisites:
            'Basic understanding of HTML5, CSS, and JavaScript ES6 fundamentals.',
        skills: [
          'React 18',
          'TypeScript',
          'Tailwind CSS',
          'Vite',
          'Zustand',
          'Context API',
        ],
        outcomes: [
          'Architect modular React component hierarchies with strict TypeScript interfaces.',
          'Manage complex asynchronous state flows using Zustand, Context API, and TanStack Query.',
          'Build responsive design systems using utility-first Tailwind CSS.',
          'Configure Vite production build bundles and deploy resilient client-server applications.',
        ],
        books: [
          [
            '2ND EDITION (O’REILLY MEDIA)',
            'Learning React: Modern Patterns for Developing Applications',
            'Alex Banks & Eve Porcello',
            'Chapters 6 & 8: State Management, Custom Hooks & Concurrent Mode',
          ],
          [
            '1ST EDITION (O’REILLY MEDIA)',
            'Programming TypeScript: Making Your JavaScript Applications Scale',
            'Boris Cherny',
            'Chapters 4 & 5: Advanced Types, Generics & React Interfaces',
          ],
          [
            'REFERENCE',
            'React Official Documentation',
            'React Core Team',
            'React 18 rendering, hooks, Suspense and modern component patterns.',
          ],
        ],
      );
    }

    if (t.contains('python') ||
        t.contains('machine') ||
        t.contains('data')) {
      return const _DetailData(
        instructor: 'Instructor Kumar',
        nextClass:
            'PyTorch Training Pipelines, Data Tensors & Model Evaluation',
        objective:
            'Build reliable data-to-model pipelines and understand tensors, training loops, validation and evaluation.',
        preparation:
            'Review NumPy broadcasting, Pandas groupby operations, train-test splitting and basic neural-network terminology.',
        assignment:
            'End-to-End ML Dataset Pipeline',
        assignmentText:
            'Create a reproducible Python pipeline that cleans a dataset, prepares features, trains a baseline model, evaluates it and reports important metrics.',
        overview:
            'Build practical expertise in Python data processing, machine learning, neural networks, PyTorch workflows and modern generative AI applications.',
        level: 'INTERMEDIATE / ADVANCED',
        audience:
            'AI/ML, Data Science and Computer Science students building practical machine-learning skills.',
        prerequisites:
            'Basic Python programming, probability fundamentals and introductory linear algebra.',
        skills: [
          'Python',
          'Pandas',
          'NumPy',
          'Scikit-learn',
          'PyTorch',
          'LLMs',
        ],
        outcomes: [
          'Clean, transform, visualize and validate real-world datasets.',
          'Build supervised machine-learning pipelines with appropriate evaluation metrics.',
          'Implement neural-network training workflows using PyTorch.',
          'Understand practical LLM and generative-AI application patterns.',
        ],
        books: [
          [
            'REFERENCE',
            'Python for Data Analysis',
            'Wes McKinney',
            'Pandas, data cleaning, transformation, grouping and analysis.',
          ],
          [
            'REFERENCE',
            'Hands-On Machine Learning',
            'Aurélien Géron',
            'Feature engineering, model evaluation and practical ML workflows.',
          ],
          [
            'REFERENCE',
            'Deep Learning with PyTorch',
            'PyTorch Community',
            'Tensor operations, model training, optimization and evaluation.',
          ],
        ],
      );
    }

    if (t.contains('java')) {
      return const _DetailData(
        instructor: 'Instructor Kumar',
        nextClass:
            'Spring Boot REST APIs, Dependency Injection & Production Configuration',
        objective:
            'Design maintainable Spring Boot services using dependency injection, REST controllers, validation, persistence and production configuration.',
        preparation:
            'Review Java OOP, collections, interfaces, exceptions, JDBC basics and HTTP request/response concepts.',
        assignment:
            'Production-Ready Spring Boot Microservice',
        assignmentText:
            'Build a Spring Boot REST service with layered architecture, validation, persistence, centralized exception handling and container-ready configuration.',
        overview:
            'Develop production-grade backend applications using modern Java, Spring Boot, database persistence, REST APIs, testing and Docker-based deployment.',
        level: 'INTERMEDIATE',
        audience:
            'Java developers and Computer Science students preparing for backend engineering roles.',
        prerequisites:
            'Core Java, OOP, collections, exception handling, SQL and basic HTTP concepts.',
        skills: [
          'Java 21',
          'Spring Boot',
          'REST APIs',
          'PostgreSQL',
          'JPA',
          'Docker',
        ],
        outcomes: [
          'Build layered Spring Boot applications using dependency injection.',
          'Design REST endpoints with validation and consistent error handling.',
          'Persist application data using JPA and relational databases.',
          'Package backend services using production-oriented Docker workflows.',
        ],
        books: [
          [
            'REFERENCE',
            'Spring Start Here',
            'Laurentiu Spilca',
            'Dependency injection, Spring beans, configuration and application architecture.',
          ],
          [
            'REFERENCE',
            'Effective Java',
            'Joshua Bloch',
            'Core Java design practices, APIs, objects and maintainable code.',
          ],
          [
            'REFERENCE',
            'Spring Boot Reference Documentation',
            'Spring Team',
            'Production configuration, web applications, data access and deployment.',
          ],
        ],
      );
    }

    if (t.contains('flutter') ||
        t.contains('dart') ||
        t.contains('mobile')) {
      return const _DetailData(
        instructor: 'Instructor Kumar',
        nextClass:
            'Flutter Widget Architecture, State Management & Responsive Layouts',
        objective:
            'Build maintainable Flutter screens with reusable widgets, responsive layouts, navigation and predictable application state.',
        preparation:
            'Review Dart classes, null safety, async/await, Flutter widget lifecycle and basic navigation.',
        assignment:
            'Responsive Flutter Course Dashboard',
        assignmentText:
            'Build a responsive Flutter dashboard using reusable widgets, adaptive layouts, navigation and local state while keeping the UI consistent across desktop and mobile sizes.',
        overview:
            'Develop cross-platform applications using Dart and Flutter with clean widget architecture, responsive layouts, state management and production-ready navigation.',
        level: 'INTERMEDIATE',
        audience:
            'Mobile application developers and Computer Science students learning cross-platform engineering.',
        prerequisites:
            'Basic Dart programming and familiarity with object-oriented programming.',
        skills: [
          'Flutter',
          'Dart',
          'Widgets',
          'State Management',
          'Responsive UI',
        ],
        outcomes: [
          'Compose reusable Flutter widgets and scalable screen structures.',
          'Implement responsive interfaces for desktop, tablet and mobile.',
          'Manage navigation and application state cleanly.',
          'Prepare Flutter applications for production builds and deployment.',
        ],
        books: [
          [
            'REFERENCE',
            'Flutter Documentation',
            'Flutter Team',
            'Widgets, responsive layouts, navigation and application architecture.',
          ],
          [
            'REFERENCE',
            'Dart Language Tour',
            'Dart Team',
            'Null safety, classes, collections and asynchronous programming.',
          ],
          [
            'REFERENCE',
            'Flutter in Action',
            'Eric Windmill',
            'Flutter widget composition, state and navigation.',
          ],
        ],
      );
    }

    return _DetailData(
      instructor: 'Instructor Kumar',
      nextClass: '${course.title} — Core Concepts & Implementation',
      objective:
          'Build a strong conceptual foundation and apply the course topics through practical engineering exercises.',
      preparation:
          'Review the previous module and complete the introductory exercises before the next class.',
      assignment: 'Practical ${course.title} Project',
      assignmentText:
          'Complete a practical implementation covering the major concepts from the current module and submit a short explanation of your design decisions.',
      overview: course.description,
      level: 'INTERMEDIATE',
      audience:
          'Computer Science and Engineering students developing practical engineering skills.',
      prerequisites:
          'Basic programming knowledge and familiarity with the course domain.',
      skills: course.tags.isEmpty
          ? const ['Core Concepts', 'Practical Skills']
          : course.tags,
      outcomes: const [
        'Understand the core concepts covered throughout the course.',
        'Apply the concepts through structured practical exercises.',
        'Build a small portfolio-ready implementation.',
        'Review and assess your own learning progress.',
      ],
      books: const [
        [
          'REFERENCE',
          'Course Reference Material',
          'Next Gen LMS',
          'Use the course modules and prescribed readings for guided study.',
        ],
      ],
    );
  }

  String _detailBranch(Course course) {
    return course.departmentCode == 'CSE'
        ? 'COMPUTER SCIENCE & ENGINEERING'
        : course.departmentCode;
  }

  void _backToDirectory() {
    setState(() {
      selectedCourse = null;
      detailTab = 0;
    });
  }

  void _launchPlayer(Course course) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Launching ${course.title} player...')),
    );
  }

  void _practiceQuiz(Course course) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Practice quiz for ${course.title} is ready to connect.',
        ),
      ),
    );
  }


  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader(
    Color cardColor,
    Color primaryText,
    Color secondaryText,
  ) {
    final currentBranch =
        _branchDisplayName();

    return Container(
      width: double.infinity,

      margin: const EdgeInsets.fromLTRB(
        28,
        24,
        28,
        0,
      ),

      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        18,
      ),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
            BorderRadius.circular(18),

        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF1E293B)
              : const Color(0xFFE2E8F0),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'BRANCH-SPECIFIC LMS CURRICULUM',

                  style:
                      GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight:
                        FontWeight.w700,
                    letterSpacing: 0.8,
                    color: orange,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Technical Course Directory',

                  style:
                      GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w800,
                    color: primaryText,
                  ),
                ),

                const SizedBox(height: 4),

                RichText(
                  text: TextSpan(
                    style:
                        GoogleFonts.inter(
                      fontSize: 10,
                      color: secondaryText,
                    ),

                    children: [
                      const TextSpan(
                        text:
                            'Showing courses tailored for ',
                      ),

                      TextSpan(
                        text: currentBranch,
                        style:
                            const TextStyle(
                          color: orange,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // SEARCH

          SizedBox(
            width: 215,
            height: 34,

            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery =
                      value.trim().toLowerCase();
                });
              },

              style:
                  GoogleFonts.inter(
                fontSize: 10,
              ),

              decoration:
                  InputDecoration(
                hintText:
                    'Search courses or topics...',

                hintStyle:
                    GoogleFonts.inter(
                  fontSize: 10,
                  color:
                      const Color(0xFF94A3B8),
                ),

                prefixIcon:
                    const Icon(
                  Icons.search,
                  size: 16,
                  color:
                      Color(0xFF94A3B8),
                ),

                filled: true,

                fillColor:
                    widget.isDarkMode
                        ? const Color(
                            0xFF1E293B,
                          )
                        : const Color(
                            0xFFF8FAFC,
                          ),

                contentPadding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 10,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                  borderSide:
                      BorderSide.none,
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                  borderSide:
                      BorderSide(
                    color:
                        widget.isDarkMode
                            ? const Color(
                                0xFF334155,
                              )
                            : const Color(
                                0xFFE2E8F0,
                              ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 9,
            ),

            decoration: BoxDecoration(
              color:
                  orange.withValues(
                alpha: 0.12,
              ),

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: Text(
              '${_getFilteredCourses().length} Courses',

              style:
                  GoogleFonts.inter(
                fontSize: 10,
                fontWeight:
                    FontWeight.w700,
                color: orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // BRANCH FILTERS
  // ==========================================================

  Widget _buildBranchFilters(
    Color primaryText,
    Color secondaryText,
    Color cardColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          '⚱ Branch:',

          style:
              GoogleFonts.inter(
            fontSize: 10,
            color: secondaryText,
            fontWeight:
                FontWeight.w500,
          ),
        ),

        const SizedBox(height: 10),

        SingleChildScrollView(
          scrollDirection:
              Axis.horizontal,

          child: Row(
            children:
                branches.map(
              (branch) {
                final isSelected =
                    selectedBranch ==
                        branch.code;

                return Padding(
                  padding:
                      const EdgeInsets.only(
                    right: 8,
                  ),

                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),

                    onTap: () {
                      setState(() {
                        selectedBranch =
                            branch.code;

                        searchQuery = '';
                      });
                    },

                    child: AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds: 180,
                      ),

                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),

                      decoration:
                          BoxDecoration(
                        color: isSelected
                            ? orange
                            : cardColor,

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        border:
                            Border.all(
                          color: isSelected
                              ? orange
                              : const Color(
                                  0xFFE2E8F0,
                                ),
                        ),
                      ),

                      child: Row(
                        children: [
                          Icon(
                            branch.icon,
                            size: 13,

                            color:
                                isSelected
                                    ? Colors
                                        .white
                                    : secondaryText,
                          ),

                          const SizedBox(
                            width: 6,
                          ),

                          Text(
                            branch.label,

                            style:
                                GoogleFonts
                                    .inter(
                              fontSize: 10,
                              fontWeight:
                                  FontWeight
                                      .w700,

                              color:
                                  isSelected
                                      ? Colors
                                          .white
                                      : primaryText,
                            ),
                          ),

                          if (branch.code !=
                              'ALL') ...[
                            const SizedBox(
                              width: 5,
                            ),

                            Text(
                              '${branch.count}',

                              style:
                                  GoogleFonts
                                      .inter(
                                fontSize: 8,
                                fontWeight:
                                    FontWeight
                                        .w600,

                                color:
                                    isSelected
                                        ? Colors
                                            .white70
                                        : secondaryText,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // COURSE CARD
  // ==========================================================

  Widget _buildCourseCard(
    Course course,
    Color primaryText,
    Color secondaryText,
    Color cardColor,
  ) {
    final progress =
        course.progress.clamp(0.0, 1.0);

    return Container(
      clipBehavior:
          Clip.antiAlias,

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
            BorderRadius.circular(17),

        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF1E293B)
              : const Color(0xFFE2E8F0),
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.035,
            ),

            blurRadius: 10,

            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          // ----------------------------------------------------
          // COURSE IMAGE / BANNER
          // ----------------------------------------------------

          // Keep the banner height fixed so the card layout remains
          // predictable while the desktop window is being resized.
          SizedBox(
            height: 145,
            width: double.infinity,
            child: _buildCourseBanner(
              course,
            ),
          ),

          // ----------------------------------------------------
          // COURSE INFORMATION
          // ----------------------------------------------------

          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                13,
                16,
                12,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Text(
                        '${course.lessonsCount} LESSONS • ${course.duration.toUpperCase()}',

                        style:
                            GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight:
                              FontWeight.w600,
                          color:
                              secondaryText,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              orange.withValues(
                            alpha: 0.08,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            5,
                          ),
                        ),

                        child: Text(
                          course.category
                              .toUpperCase(),

                          style:
                              GoogleFonts
                                  .inter(
                            fontSize: 7,
                            fontWeight:
                                FontWeight
                                    .w700,
                            color: orange,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    course.title,

                    maxLines: 2,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w800,
                      color: primaryText,
                    ),
                  ),

                  const SizedBox(
                    height: 7,
                  ),

                  Text(
                    _courseDescription(
                      course,
                    ),

                    maxLines: 2,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        GoogleFonts.inter(
                      fontSize: 9.5,
                      height: 1.45,
                      color:
                          secondaryText,
                    ),
                  ),

                  const Spacer(),

                  // ------------------------------------------------
                  // PROGRESS
                  // ------------------------------------------------

                  if (course.status !=
                          CourseStatus
                              .notStarted &&
                      course.progress >
                          0) ...[
                    Row(
                      children: [
                        Text(
                          'Course Progress',

                          style:
                              GoogleFonts
                                  .inter(
                            fontSize: 8,
                            color:
                                secondaryText,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          '${(progress * 100).round()}%',

                          style:
                              GoogleFonts
                                  .inter(
                            fontSize: 8,
                            fontWeight:
                                FontWeight
                                    .w700,
                            color: orange,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    ClipRRect(
                      borderRadius:
                          BorderRadius
                              .circular(
                        4,
                      ),

                      child:
                          LinearProgressIndicator(
                        minHeight: 4,

                        value:
                            progress,

                        backgroundColor:
                            widget.isDarkMode
                                ? const Color(
                                    0xFF334155,
                                  )
                                : const Color(
                                    0xFFE2E8F0,
                                  ),

                        valueColor:
                            const AlwaysStoppedAnimation<
                                Color>(
                          orange,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                  ],

                  const Divider(
                    height: 12,
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _openCourse(
                              course,
                            );
                          },

                          icon:
                              const Icon(
                            Icons
                                .play_arrow,
                            size: 13,
                          ),

                          label:
                              Text(
                            course.status ==
                                    CourseStatus
                                        .ongoing
                                ? 'Continue Learning'
                                : 'Start Learning',
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,

                            style:
                                GoogleFonts
                                    .inter(
                              fontSize: 9,
                              fontWeight:
                                  FontWeight
                                      .w700,
                            ),
                          ),

                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                orange,

                            foregroundColor:
                                Colors.white,

                            elevation: 0,

                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 13,
                              vertical: 9,
                            ),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 4),

                      TextButton(
                        onPressed: () {
                          _showSyllabus(
                            course,
                          );
                        },

                        child:
                            Text(
                          'Syllabus',
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              GoogleFonts
                                  .inter(
                            fontSize: 9,
                            fontWeight:
                                FontWeight
                                    .w600,
                            color:
                                primaryText,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons
                            .chevron_right,
                        size: 13,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // COURSE BANNER
  // ==========================================================

  Widget _buildCourseBanner(
    Course course,
  ) {
    final colors =
        _bannerColors(course);

    return Container(
      decoration:
          BoxDecoration(
        gradient:
            LinearGradient(
          begin:
              Alignment.topLeft,

          end:
              Alignment.bottomRight,

          colors: colors,
        ),
      ),

      child: Stack(
        children: [
          // Grid effect

          CustomPaint(
            size:
                Size.infinite,

            painter:
                _GridPainter(),
          ),

          // Branch badge

          Positioned(
            left: 10,
            top: 10,

            child: Container(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 8,
                vertical: 5,
              ),

              decoration:
                  BoxDecoration(
                color:
                    Colors.black
                        .withValues(
                  alpha: 0.45,
                ),

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                border:
                    Border.all(
                  color:
                      Colors.white24,
                ),
              ),

              child: Text(
                course.departmentCode,

                style:
                    GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight:
                      FontWeight.w700,
                  color:
                      Colors.white,
                ),
              ),
            ),
          ),

          // Status

          Positioned(
            right: 8,
            top: 10,

            child: _statusBadge(
              course.status,
            ),
          ),

          // Illustration

          Center(
            child:
                _buildCourseIllustration(
              course,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // COURSE ILLUSTRATIONS
  // ==========================================================

  Widget _buildCourseIllustration(
    Course course,
  ) {
    final title =
        course.title.toLowerCase();

    if (title.contains('react') ||
        title.contains('web')) {
      return _reactIllustration();
    }

    if (title.contains('machine') ||
        title.contains('ai') ||
        title.contains('data')) {
      return _aiIllustration();
    }

    if (title.contains('security') ||
        title.contains('cyber')) {
      return _securityIllustration();
    }

    if (title.contains('power') ||
        title.contains('electrical')) {
      return _electricalIllustration();
    }

    if (title.contains('embedded') ||
        title.contains('iot')) {
      return _chipIllustration();
    }

    if (title.contains('reactor') ||
        title.contains('chemical')) {
      return _chemicalIllustration();
    }

    if (title.contains('aerodynamic') ||
        title.contains('flight') ||
        title.contains('rocket')) {
      return _aeroIllustration();
    }

    if (title.contains('cad') ||
        title.contains('fea') ||
        title.contains('mechanical')) {
      return _mechanicalIllustration();
    }

    return _defaultIllustration(
      course.title,
    );
  }

  Widget _reactIllustration() {
    return Container(
      width: 230,
      height: 100,

      padding:
          const EdgeInsets.all(
        12,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(0xFF111827)
                .withValues(
          alpha: 0.85,
        ),

        borderRadius:
            BorderRadius.circular(
          9,
        ),

        border:
            Border.all(
          color:
              Colors.white24,
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              mainAxisAlignment:
                  MainAxisAlignment
                      .center,

              children: [
                _codeLine(
                  48,
                  const Color(
                    0xFF8B5CF6,
                  ),
                ),

                _codeLine(
                  65,
                  const Color(
                    0xFF38BDF8,
                  ),
                ),

                _codeLine(
                  40,
                  const Color(
                    0xFF34D399,
                  ),
                ),

                _codeLine(
                  55,
                  const Color(
                    0xFFF472B6,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons
                .all_inclusive,
            size: 58,
            color:
                Color(
              0xFF38BDF8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeLine(
    double width,
    Color color,
  ) {
    return Container(
      width: width,
      height: 5,

      margin:
          const EdgeInsets.only(
        bottom: 7,
      ),

      decoration:
          BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(
          4,
        ),
      ),
    );
  }

  Widget _aiIllustration() {
    return SizedBox(
      width: 230,
      height: 100,

      child: CustomPaint(
        painter:
            _NeuralNetworkPainter(),

        child: const Center(
          child: Icon(
            Icons
                .psychology_outlined,
            color:
                Color(
              0xFF34D399,
            ),
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _securityIllustration() {
    return SizedBox(
      width: 190,
      height: 105,

      child: CustomPaint(
        painter:
            _ShieldPainter(),

        child: const Center(
          child: Icon(
            Icons.lock_outline,
            color:
                Color(
              0xFFFF3D71,
            ),
            size: 35,
          ),
        ),
      ),
    );
  }

  Widget _electricalIllustration() {
    return Row(
      mainAxisSize:
          MainAxisSize.min,

      children: [
        const Icon(
          Icons.bolt,
          size: 70,
          color:
              Color(
            0xFFFFD600,
          ),
        ),

        const SizedBox(
          width: 14,
        ),

        Container(
          width: 4,
          height: 65,
          color:
              const Color(
            0xFFFFD600,
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        const Icon(
          Icons
              .electric_bolt,
          size: 55,
          color:
              Color(
            0xFFFFD600,
          ),
        ),
      ],
    );
  }

  Widget _chipIllustration() {
    return Container(
      width: 210,
      height: 85,

      decoration:
          BoxDecoration(
        color:
            const Color(
          0xFF064E3B,
        ),

        borderRadius:
            BorderRadius.circular(
          8,
        ),

        border:
            Border.all(
          color:
              const Color(
            0xFF10B981,
          ),
          width: 2,
        ),
      ),

      child: const Center(
        child: Text(
          'ESP32 MCU',

          style:
              TextStyle(
            color:
                Color(
              0xFF34D399,
            ),
            fontSize: 13,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _chemicalIllustration() {
    return Column(
      mainAxisSize:
          MainAxisSize.min,

      children: [
        Container(
          width: 72,
          height: 72,

          decoration:
              BoxDecoration(
            color:
                const Color(
              0xFFBE185D,
            ),

            borderRadius:
                BorderRadius.circular(
              15,
            ),

            border:
                Border.all(
              color:
                  const Color(
                0xFFF472B6,
              ),
              width: 2,
            ),
          ),

          child: const Icon(
            Icons.science_outlined,
            color:
                Colors.white70,
            size: 38,
          ),
        ),

        const SizedBox(
          height: 5,
        ),

        const Text(
          'CSTR Reactor Kinetics',

          style:
              TextStyle(
            color:
                Colors.white,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _aeroIllustration() {
    return SizedBox(
      width: 250,
      height: 100,

      child: CustomPaint(
        painter:
            _AeroPainter(),

        child:
            const Center(
          child:
              Padding(
            padding:
                EdgeInsets.only(
              top: 30,
            ),

            child: Text(
              'LIFT',

              style:
                  TextStyle(
                color:
                    Color(
                  0xFF38BDF8,
                ),
                fontSize:
                    10,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mechanicalIllustration() {
    return Row(
      mainAxisSize:
          MainAxisSize.min,

      children: [
        Container(
          width: 65,
          height: 65,

          decoration:
              BoxDecoration(
            shape:
                BoxShape.circle,

            border:
                Border.all(
              color:
                  const Color(
                0xFF60A5FA,
              ),
              width: 3,
            ),
          ),

          child:
              const Center(
            child:
                CircleAvatar(
              radius: 12,
              backgroundColor:
                  Color(
                0xFF60A5FA,
              ),
            ),
          ),
        ),

        const SizedBox(
          width: 20,
        ),

        Container(
          width: 50,
          height: 65,

          decoration:
              BoxDecoration(
            border:
                Border.all(
              color:
                  const Color(
                0xFF60A5FA,
              ),
              width: 2,
            ),

            borderRadius:
                BorderRadius.circular(
              25,
            ),
          ),

          child:
              const Center(
            child:
                CircleAvatar(
              radius: 13,
              backgroundColor:
                  Color(
                0xFFEF4444,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _defaultIllustration(
    String title,
  ) {
    return Container(
      width: 215,
      height: 95,

      decoration:
          BoxDecoration(
        color:
            const Color(
          0xFF1E293B,
        ),

        borderRadius:
            BorderRadius.circular(
          8,
        ),

        border:
            Border.all(
          color:
              const Color(
            0xFF475569,
          ),
        ),
      ),

      child:
          Column(
        mainAxisAlignment:
            MainAxisAlignment
                .center,

        children: [
          const Icon(
            Icons
                .school_outlined,
            size: 34,
            color:
                Color(
              0xFF38BDF8,
            ),
          ),

          const SizedBox(
            height: 7,
          ),

          Text(
            title,

            maxLines: 1,

            overflow:
                TextOverflow
                    .ellipsis,

            style:
                GoogleFonts.inter(
              fontSize: 9,
              color:
                  Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // STATUS BADGE
  // ==========================================================

  Widget _statusBadge(
    CourseStatus status,
  ) {
    String text;

    switch (status) {
      case CourseStatus.ongoing:
        text = 'ONGOING';
        break;

      case CourseStatus.completed:
        text = 'COMPLETED';
        break;

      case CourseStatus.notStarted:
        text = 'NOT STARTED';
        break;

      case CourseStatus.available:
        text = 'NOT STARTED';
        break;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),

      decoration:
          BoxDecoration(
        color:
            orange,

        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),

      child:
          Text(
        text,

        style:
            GoogleFonts.inter(
          fontSize: 7,
          fontWeight:
              FontWeight.w800,
          color:
              Colors.white,
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _buildEmptyState(
    Color primaryText,
    Color secondaryText,
  ) {
    return Container(
      width:
          double.infinity,

      padding:
          const EdgeInsets.all(
        60,
      ),

      decoration:
          BoxDecoration(
        color:
            widget.isDarkMode
                ? const Color(
                    0xFF131927,
                  )
                : Colors.white,

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        border:
            Border.all(
          color:
              const Color(
            0xFFE2E8F0,
          ),
        ),
      ),

      child:
          Column(
        children: [
          const Icon(
            Icons
                .search_off_outlined,
            size: 50,
            color:
                Color(
              0xFF94A3B8,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Text(
            'No courses found',

            style:
                GoogleFonts.inter(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
              color:
                  primaryText,
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            'Try another branch or search term.',

            style:
                GoogleFonts.inter(
              fontSize: 11,
              color:
                  secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SOPHIA BUTTON
  // ==========================================================

  Widget _buildSophiaButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          const SnackBar(
            content:
                Text(
              'Sophia AI Tutor',
            ),
          ),
        );
      },

      child: Container(
        width: 58,
        height: 58,

        decoration:
            BoxDecoration(
          shape:
              BoxShape.circle,

          gradient:
              const LinearGradient(
            colors: [
              Color(0xFF7C3AED),
              Color(0xFFEC4899),
            ],
          ),

          boxShadow: [
            BoxShadow(
              color:
                  const Color(
                0xFF8B5CF6,
              ).withValues(
                alpha: 0.35,
              ),

              blurRadius: 14,
            ),
          ],
        ),

        child:
            const Center(
          child: Icon(
            Icons
                .smart_toy_outlined,
            color:
                Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // FILTER DATA
  // ==========================================================

  List<Course> _getFilteredCourses() {
    final courses =
        getCoursesFromSuggestions(
      selectedBranch:
          selectedBranch == 'ALL'
              ? null
              : _branchFullName(
                  selectedBranch,
                ),
    );

    if (searchQuery.isEmpty) {
      return courses;
    }

    return courses.where(
      (course) {
        final text =
            '${course.title} '
            '${course.description} '
            '${course.tags.join(' ')}'
                .toLowerCase();

        return text.contains(
          searchQuery,
        );
      },
    ).toList();
  }

  String _branchFullName(
    String code,
  ) {
    switch (code) {
      case 'CSE':
        return 'B.Tech - Computer Science & Eng. (CSE)';

      case 'IT':
        return 'B.Tech - Information Technology (IT)';

      case 'ECE':
        return 'B.Tech - Electronics & Comm. (ECE)';

      case 'EEE':
        return 'B.Tech - Electrical Engineering (EE)';

      case 'ME':
        return 'B.Tech - Mechanical Engineering (ME)';

      case 'CE':
        return 'B.Tech - Civil Engineering (CE)';

      case 'CH':
        return 'B.Tech - Chemical Engineering (CH)';

      case 'AE':
        return 'B.Tech - Aerospace Engineering (AE)';

      default:
        return code;
    }
  }

  String _branchDisplayName() {
    switch (selectedBranch) {
      case 'CSE':
        return 'Computer Science & Engineering';

      case 'IT':
        return 'Information Technology';

      case 'ECE':
        return 'Electronics & Communication Engineering';

      case 'EEE':
        return 'Electrical & Electronics Engineering';

      case 'ME':
        return 'Mechanical Engineering';

      case 'CE':
        return 'Civil Engineering';

      case 'CH':
        return 'Chemical Engineering';

      case 'AE':
        return 'Aerospace Engineering';

      default:
        return 'All Engineering Branches';
    }
  }

  // ==========================================================
  // COURSE DESCRIPTION
  // ==========================================================

  String _courseDescription(
    Course course,
  ) {
    if (course.tags.isNotEmpty) {
      return course.tags.join(', ');
    }

    return course.description;
  }

  // ==========================================================
  // BANNER COLORS
  // ==========================================================

  List<Color> _bannerColors(
    Course course,
  ) {
    final title =
        course.title.toLowerCase();

    if (title.contains('security') ||
        title.contains('cyber')) {
      return const [
        Color(0xFF020617),
        Color(0xFF4C0519),
      ];
    }

    if (title.contains('embedded') ||
        title.contains('iot')) {
      return const [
        Color(0xFF022C22),
        Color(0xFF064E3B),
      ];
    }

    if (title.contains('chemical') ||
        title.contains('reactor')) {
      return const [
        Color(0xFF500724),
        Color(0xFF701A75),
      ];
    }

    if (title.contains('power') ||
        title.contains('electrical')) {
      return const [
        Color(0xFF451A03),
        Color(0xFF78350F),
      ];
    }

    if (title.contains('aero') ||
        title.contains('flight') ||
        title.contains('rocket')) {
      return const [
        Color(0xFF082F49),
        Color(0xFF075985),
      ];
    }

    if (title.contains('react') ||
        title.contains('web')) {
      return const [
        Color(0xFF17104A),
        Color(0xFF4C1D95),
      ];
    }

    if (title.contains('mechanical') ||
        title.contains('cad') ||
        title.contains('fea')) {
      return const [
        Color(0xFF172554),
        Color(0xFF1E3A8A),
      ];
    }

    return const [
      Color(0xFF111827),
      Color(0xFF1E293B),
    ];
  }

  // ==========================================================
  // COURSE ACTIONS
  // ==========================================================

  void _openCourse(Course course) {
    setState(() {
      selectedCourse = course;
      detailTab = 0;
    });
  }

  void _showSyllabus(
    Course course,
  ) {
    showModalBottomSheet(
      context: context,

      isScrollControlled:
          true,

      backgroundColor:
          Colors.transparent,

      builder: (context) {
        return Container(
          padding:
              const EdgeInsets.all(
            24,
          ),

          decoration:
              BoxDecoration(
            color: widget.isDarkMode
                ? const Color(
                    0xFF131927,
                  )
                : Colors.white,

            borderRadius:
                const BorderRadius
                    .vertical(
              top:
                  Radius.circular(
                24,
              ),
            ),
          ),

          child:
              SafeArea(
            child:
                Column(
              mainAxisSize:
                  MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                Text(
                  course.title,

                  style:
                      GoogleFonts
                          .inter(
                    fontSize: 20,
                    fontWeight:
                        FontWeight
                            .w800,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  'Course Syllabus',

                  style:
                      GoogleFonts
                          .inter(
                    fontSize: 11,
                    color:
                        textMuted,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                ...course.modules
                    .asMap()
                    .entries
                    .map(
                  (entry) {
                    final module =
                        entry.value;

                    return ListTile(
                      contentPadding:
                          EdgeInsets.zero,

                      leading:
                          CircleAvatar(
                        radius: 16,

                        backgroundColor:
                            orange.withValues(
                          alpha: 0.12,
                        ),

                        child:
                            Text(
                          '${entry.key + 1}',

                          style:
                              const TextStyle(
                            fontSize: 11,
                            fontWeight:
                                FontWeight
                                    .bold,
                            color:
                                orange,
                          ),
                        ),
                      ),

                      title:
                          Text(
                        module.title,

                        style:
                            GoogleFonts
                                .inter(
                          fontSize: 11,
                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),

                      subtitle:
                          Text(
                        '${module.lessonsCount} lessons • ${module.duration}',

                        style:
                            GoogleFonts
                                .inter(
                          fontSize: 9,
                          color:
                              textMuted,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(
                  height: 15,
                ),

                SizedBox(
                  width:
                      double.infinity,

                  child:
                      ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );

                      _openCourse(
                        course,
                      );
                    },

                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          orange,

                      foregroundColor:
                          Colors.white,

                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 14,
                      ),
                    ),

                    child:
                        const Text(
                      'Start Learning',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// INLINE COURSE DETAIL DATA
// ============================================================

class _DetailData {
  final String instructor;
  final String nextClass;
  final String objective;
  final String preparation;
  final String assignment;
  final String assignmentText;
  final String overview;
  final String level;
  final String audience;
  final String prerequisites;
  final List<String> skills;
  final List<String> outcomes;
  final List<List<String>> books;

  const _DetailData({
    required this.instructor,
    required this.nextClass,
    required this.objective,
    required this.preparation,
    required this.assignment,
    required this.assignmentText,
    required this.overview,
    required this.level,
    required this.audience,
    required this.prerequisites,
    required this.skills,
    required this.outcomes,
    required this.books,
  });
}

// ============================================================
// GRID PAINTER
// ============================================================

class _GridPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint =
        Paint()
          ..color =
              Colors.white.withValues(
            alpha: 0.035,
          )
          ..strokeWidth = 1;

    const spacing = 25.0;

    for (
      double x = 0;
      x < size.width;
      x += spacing
    ) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(
          x,
          size.height,
        ),
        paint,
      );
    }

    for (
      double y = 0;
      y < size.height;
      y += spacing
    ) {
      canvas.drawLine(
        Offset(0, y),
        Offset(
          size.width,
          y,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// ============================================================
// NEURAL NETWORK
// ============================================================

class _NeuralNetworkPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final linePaint =
        Paint()
          ..color =
              const Color(
            0xFF38BDF8,
          ).withValues(
            alpha: 0.45,
          )
          ..strokeWidth = 1.5;

    final nodePaint =
        Paint()
          ..color =
              const Color(
            0xFF38BDF8,
          );

    final nodes = [
      Offset(
        size.width * .15,
        size.height * .30,
      ),
      Offset(
        size.width * .15,
        size.height * .70,
      ),
      Offset(
        size.width * .5,
        size.height * .22,
      ),
      Offset(
        size.width * .5,
        size.height * .50,
      ),
      Offset(
        size.width * .5,
        size.height * .78,
      ),
      Offset(
        size.width * .82,
        size.height * .50,
      ),
    ];

    for (final a in [
      0,
      1,
    ]) {
      for (final b in [
        2,
        3,
        4,
      ]) {
        canvas.drawLine(
          nodes[a],
          nodes[b],
          linePaint,
        );
      }
    }

    for (final a in [
      2,
      3,
      4,
    ]) {
      canvas.drawLine(
        nodes[a],
        nodes[5],
        linePaint,
      );
    }

    for (final node in nodes) {
      canvas.drawCircle(
        node,
        6,
        nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// ============================================================
// SHIELD
// ============================================================

class _ShieldPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint =
        Paint()
          ..style =
              PaintingStyle.stroke
          ..strokeWidth = 3
          ..color =
              const Color(
            0xFFFF3D71,
          );

    final path =
        Path();

    path.moveTo(
      size.width * .5,
      8,
    );

    path.lineTo(
      size.width * .82,
      size.height * .25,
    );

    path.lineTo(
      size.width * .74,
      size.height * .72,
    );

    path.quadraticBezierTo(
      size.width * .5,
      size.height * .98,
      size.width * .26,
      size.height * .72,
    );

    path.lineTo(
      size.width * .18,
      size.height * .25,
    );

    path.close();

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// ============================================================
// AERODYNAMIC
// ============================================================

class _AeroPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint =
        Paint()
          ..style =
              PaintingStyle.stroke
          ..strokeWidth = 2
          ..color =
              const Color(
            0xFF22D3EE,
          );

    final path =
        Path();

    path.moveTo(
      size.width * .15,
      size.height * .55,
    );

    path.quadraticBezierTo(
      size.width * .5,
      size.height * .15,
      size.width * .85,
      size.height * .55,
    );

    path.quadraticBezierTo(
      size.width * .5,
      size.height * .70,
      size.width * .15,
      size.height * .55,
    );

    canvas.drawPath(
      path,
      paint,
    );

    canvas.drawLine(
      Offset(
        size.width * .5,
        size.height * .55,
      ),
      Offset(
        size.width * .5,
        size.height * .1,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}