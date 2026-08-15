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
    final bool dark = widget.isDarkMode;

    final bgColor = dark
        ? const Color(0xFF090D16)
        : background;

    final cardColor = dark
        ? const Color(0xFF131927)
        : Colors.white;

    final primaryText = dark
        ? Colors.white
        : textDark;

    final secondaryText = dark
        ? const Color(0xFF94A3B8)
        : textMuted;

    final filteredCourses =
        _getFilteredCourses();

    return Scaffold(
      backgroundColor: bgColor,

      body: Column(
        children: [
          _buildHeader(
            cardColor,
            primaryText,
            secondaryText,
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                28,
                18,
                28,
                32,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  _buildBranchFilters(
                    primaryText,
                    secondaryText,
                    cardColor,
                  ),

                  const SizedBox(height: 24),

                  if (filteredCourses.isEmpty)
                    _buildEmptyState(
                      primaryText,
                      secondaryText,
                    )
                  else
                    LayoutBuilder(
                      builder:
                          (context, constraints) {
                        final width =
                            constraints.maxWidth;

                        int columns = 3;

                        if (width < 900) {
                          columns = 2;
                        }

                        if (width < 600) {
                          columns = 1;
                        }

                        // IMPORTANT:
                        // Do not use a fixed childAspectRatio here.
                        //
                        // The course card contains a 145px banner plus several
                        // rows of text, progress and buttons. On a wide window,
                        // a 3-column childAspectRatio of 1.48 makes each card
                        // too short and Flutter reports:
                        //
                        //   A RenderFlex overflowed by ... pixels on the bottom
                        //
                        // mainAxisExtent gives the card enough vertical space
                        // and remains stable while the desktop window is resized.
                        final double cardHeight;
                        if (columns == 3) {
                          cardHeight = 370;
                        } else if (columns == 2) {
                          cardHeight = 380;
                        } else {
                          cardHeight = 390;
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),

                          itemCount:
                              filteredCourses.length,

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                columns,

                            crossAxisSpacing:
                                18,

                            mainAxisSpacing:
                                18,

                            // Fixed vertical space instead of aspect ratio.
                            // This prevents the card's Column from becoming
                            // shorter than its contents during resizing.
                            mainAxisExtent:
                                cardHeight,
                          ),

                          itemBuilder:
                              (context, index) {
                            return _buildCourseCard(
                              filteredCourses[
                                  index],
                              primaryText,
                              secondaryText,
                              cardColor,
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ========================================================
      // SOPHIA FLOATING BUTTON
      // ========================================================

      floatingActionButton:
          _buildSophiaButton(),
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

  void _openCourse(
    Course course,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          'Opening ${course.title}',
        ),
        backgroundColor:
            orange,
      ),
    );
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