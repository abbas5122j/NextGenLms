import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/leetcode_problems_data.dart';

// =============================================================================
// 1. LMS CODING MAIN SCREEN
// =============================================================================
class LMSCodingScreen extends StatefulWidget {
  final String userName;
  final VoidCallback? onBackToHome;
  final VoidCallback? onSignOut;

  const LMSCodingScreen({
    super.key,
    required this.userName,
    this.onBackToHome,
    this.onSignOut,
  });

  @override
  State<LMSCodingScreen> createState() => _LMSCodingScreenState();
}

class _LMSCodingScreenState extends State<LMSCodingScreen> {
  int activeSidebarIndex = 1;
  bool isSidebarCollapsed = false;
  bool isDarkMode = false;

  LeetCodeProblem? _activePlaygroundProblem;

  String searchQuery = '';
  String selectedCategory = 'All Categories (28)';
  String selectedDifficulty = 'All Difficulty';
  String selectedStatus = 'All Status';
  bool showTop150Only = false;
  bool showBlind75Only = false;

  final List<Map<String, dynamic>> sidebarItems = [
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
  ];

  @override
  Widget build(BuildContext context) {
    // If a problem is selected for practice, render the clean sandbox environment
    if (_activePlaygroundProblem != null) {
      return CodingSandboxScreen(
        problem: _activePlaygroundProblem!,
        userName: widget.userName,
        onBackToProblemList: () {
          setState(() {
            _activePlaygroundProblem = null;
          });
        },
      );
    }

    final bgColor = isDarkMode ? const Color(0xFF090D16) : const Color(0xFFF4F6FB);
    final cardBgColor = isDarkMode ? const Color(0xFF131927) : Colors.white;
    final primaryTextColor = isDarkMode ? Colors.white : const Color(0xFF0F172A);
    final subTextColor = isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final borderThemeColor = isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);

    final filteredProblems = LeetCodeProblemsData.problems.where((p) {
      if (searchQuery.isNotEmpty &&
          !p.title.toLowerCase().contains(searchQuery.toLowerCase()) &&
          !p.id.toString().contains(searchQuery)) {
        return false;
      }
      if (selectedCategory != 'All Categories (28)' && p.category != selectedCategory.replaceAll(' (28)', '')) {
        return false;
      }
      if (selectedDifficulty != 'All Difficulty' && p.difficulty != selectedDifficulty) {
        return false;
      }
      if (selectedStatus == 'Solved' && !p.isSolved) return false;
      if (selectedStatus == 'Unsolved' && p.isSolved) return false;
      if (showTop150Only && !p.isTop150) return false;
      if (showBlind75Only && !p.isBlind75) return false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          _buildSidebar(cardBgColor, primaryTextColor, subTextColor, borderThemeColor),
          Expanded(
            child: Column(
              children: [
                _buildTopHeader(cardBgColor, primaryTextColor, subTextColor, borderThemeColor),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroHeaderCard(),
                        const SizedBox(height: 20),
                        _buildNavigationTabs(),
                        const SizedBox(height: 20),
                        _buildFilterAndSearchCard(cardBgColor, primaryTextColor, subTextColor, borderThemeColor),
                        const SizedBox(height: 16),
                        _buildProblemsTable(filteredProblems, cardBgColor, primaryTextColor, subTextColor, borderThemeColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(Color cardBg, Color textPrimary, Color textSub, Color borderCol) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isSidebarCollapsed ? 70 : 220,
      color: cardBg,
      child: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderCol))),
            child: Row(
              mainAxisAlignment: isSidebarCollapsed ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
              children: [
                if (!isSidebarCollapsed)
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
                          child: Text('N', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
                          children: const [
                            TextSpan(text: 'Next Gen ', style: TextStyle(color: Color(0xFF22C55E))),
                            TextSpan(text: 'LMS', style: TextStyle(color: Color(0xFFEF4444))),
                          ],
                        ),
                      ),
                    ],
                  ),
                IconButton(
                  icon: Icon(
                    isSidebarCollapsed ? Icons.chevron_right : Icons.chevron_left,
                    size: 20,
                    color: textSub,
                  ),
                  onPressed: () => setState(() => isSidebarCollapsed = !isSidebarCollapsed),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: sidebarItems.length,
              itemBuilder: (context, index) {
                final isSelected = activeSidebarIndex == index;
                final item = sidebarItems[index];

                return Tooltip(
                  message: isSidebarCollapsed ? item['title'] : '',
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: 24,
                    leading: Icon(
                      item['icon'],
                      size: 18,
                      color: isSelected ? const Color(0xFFFF5722) : textSub,
                    ),
                    title: isSidebarCollapsed
                        ? null
                        : Text(
                            item['title'],
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? const Color(0xFFFF5722) : textPrimary,
                            ),
                          ),
                    selected: isSelected,
                    onTap: () {
                      setState(() => activeSidebarIndex = index);
                      if (index == 0 && widget.onBackToHome != null) {
                        widget.onBackToHome!();
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: borderCol))),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  minLeadingWidth: 24,
                  leading: const Icon(Icons.person_outline, size: 18, color: Color(0xFFEF4444)),
                  title: isSidebarCollapsed
                      ? null
                      : Text('My Profile', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFFEF4444))),
                  onTap: () {},
                ),
                ListTile(
                  dense: true,
                  minLeadingWidth: 24,
                  leading: const Icon(Icons.settings_outlined, size: 18, color: Color(0xFF64748B)),
                  title: isSidebarCollapsed
                      ? null
                      : Text('Settings', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: textPrimary)),
                  onTap: () {},
                ),
                ListTile(
                  dense: true,
                  minLeadingWidth: 24,
                  leading: const Icon(Icons.logout, size: 18, color: Color(0xFFEF4444)),
                  title: isSidebarCollapsed
                      ? null
                      : Text('Sign Out', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFFEF4444))),
                  onTap: widget.onSignOut ?? () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(Color cardBg, Color textPrimary, Color textSub, Color borderCol) {
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
                color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                  const SizedBox(width: 8),
                  Text(
                    'Search courses, projects, concepts...',
                    style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
              size: 20,
              color: isDarkMode ? Colors.amber : const Color(0xFF64748B),
            ),
            onPressed: () => setState(() => isDarkMode = !isDarkMode),
          ),
          const SizedBox(width: 8),
          Stack(
            children: [
              Icon(Icons.notifications_none, size: 20, color: textSub),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFFF6B35),
            child: Text(
              widget.userName.isNotEmpty ? widget.userName.substring(0, widget.userName.length >= 2 ? 2 : 1).toUpperCase() : 'AB',
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName,
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: textPrimary),
              ),
              Text('Student', style: GoogleFonts.inter(fontSize: 10, color: textSub)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1E24),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _pillBadge('</> LMS CODING ENGINE', const Color(0xFF00B8A9)),
                    const SizedBox(width: 10),
                    _pillBadge('LeetCode 150 Practice 🚀', const Color(0xFF0EA5E9)),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Data Structures & Algorithms Practice Hub',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Master interview pattern algorithms with curated LeetCode 150 & Blind 75 roadmaps, interactive code execution, step-by-step video editorials, and Sophia AI support.',
                  style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              _metricBox(Icons.local_fire_department, 'STREAK', '0 Days', Colors.amber),
              const SizedBox(width: 12),
              _metricBox(Icons.check_circle_outline, 'SOLVED', '0 / 28 (0%)', Colors.greenAccent),
              const SizedBox(width: 12),
              _metricBox(Icons.bolt, 'XP POINTS', '0 XP', Colors.purpleAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pillBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(label, style: GoogleFonts.inter(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _metricBox(IconData icon, String label, String val, Color color) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF132A32),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E3A42)),
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 14, backgroundColor: color.withValues(alpha: 0.15), child: Icon(icon, size: 16, color: color)),
          const SizedBox(height: 8),
          Text(label, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 8, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(val, style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildNavigationTabs() {
    return Row(
      children: [
        _tabButton('Practice Problems List (28)', true, Icons.menu),
        const SizedBox(width: 12),
        _tabButton('LeetCode 150 Roadmap Tree', false, Icons.account_tree_outlined),
        const SizedBox(width: 12),
        _tabButton('Practice Playground: #217 Contains Duplicate', false, Icons.code),
      ],
    );
  }

  Widget _tabButton(String title, bool isActive, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0F172A) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: isActive ? Colors.white : const Color(0xFF64748B)),
          const SizedBox(width: 8),
          Text(title, style: GoogleFonts.inter(color: isActive ? Colors.white : const Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildFilterAndSearchCard(Color cardBg, Color textPrimary, Color textSub, Color borderCol) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (val) => setState(() => searchQuery = val),
                          style: GoogleFonts.inter(fontSize: 12, color: textPrimary),
                          decoration: const InputDecoration(
                            hintText: 'Search problem title, #, or pattern...',
                            hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _dropdownFilter(selectedCategory, ['All Categories (28)', 'Arrays & Hashing', 'Two Pointers', 'Sliding Window', 'Linked List', 'Dynamic Programming'], (v) => setState(() => selectedCategory = v!), textPrimary),
              const SizedBox(width: 12),
              _dropdownFilter(selectedDifficulty, ['All Difficulty', 'Easy', 'Medium', 'Hard'], (v) => setState(() => selectedDifficulty = v!), textPrimary),
              const SizedBox(width: 12),
              _dropdownFilter(selectedStatus, ['All Status', 'Solved', 'Unsolved'], (v) => setState(() => selectedStatus = v!), textPrimary),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _filterChip('⚡ Top 150', showTop150Only, () => setState(() => showTop150Only = !showTop150Only)),
              const SizedBox(width: 8),
              _filterChip('🔥 Blind 75', showBlind75Only, () => setState(() => showBlind75Only = !showBlind75Only)),
            ],
          )
        ],
      ),
    );
  }

  Widget _dropdownFilter(String value, List<String> items, ValueChanged<String?> onChanged, Color textPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: value,
        dropdownColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        underline: const SizedBox(),
        style: GoogleFonts.inter(fontSize: 11, color: textPrimary, fontWeight: FontWeight.bold),
        items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _filterChip(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF7ED) : (isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? const Color(0xFFFF6B35) : Colors.transparent),
        ),
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFF64748B),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProblemsTable(List<LeetCodeProblem> problems, Color cardBg, Color textPrimary, Color textSub, Color borderCol) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                SizedBox(width: 40, child: Text('STATUS', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: textSub))),
                SizedBox(width: 40, child: Text('#', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: textSub))),
                Expanded(flex: 3, child: Text('PROBLEM TITLE', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: textSub))),
                Expanded(flex: 2, child: Text('CATEGORY', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: textSub))),
                SizedBox(width: 90, child: Text('DIFFICULTY', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: textSub))),
                SizedBox(width: 80, child: Text('ACCEPTANCE', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: textSub))),
                SizedBox(width: 70, child: Text('SOLUTION', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: textSub))),
                SizedBox(width: 100, child: Align(alignment: Alignment.centerRight, child: Text('ACTION', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: textSub)))),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: problems.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: borderCol),
            itemBuilder: (context, index) {
              final p = problems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Icon(
                        p.isSolved ? Icons.check_circle : Icons.circle_outlined,
                        size: 18,
                        color: p.isSolved ? const Color(0xFF22C55E) : const Color(0xFFCBD5E1),
                      ),
                    ),
                    SizedBox(width: 40, child: Text('${p.id}', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: textSub))),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(p.title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: textPrimary)),
                          if (p.isBlind75) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(4)),
                              child: Text('Blind 75', style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.bold, color: const Color(0xFFD97706))),
                            )
                          ]
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(p.category, style: GoogleFonts.inter(fontSize: 10, color: textPrimary)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Text(
                        p.difficulty,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: p.difficulty == 'Easy'
                              ? const Color(0xFF16A34A)
                              : p.difficulty == 'Medium'
                                  ? const Color(0xFFD97706)
                                  : const Color(0xFFDC2626),
                        ),
                      ),
                    ),
                    SizedBox(width: 80, child: Text(p.acceptance, style: GoogleFonts.inter(fontSize: 11, color: textSub))),
                    SizedBox(
                      width: 70,
                      child: Icon(Icons.videocam_outlined, size: 18, color: textSub),
                    ),
                    SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _activePlaygroundProblem = p;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF0FDF4),
                            elevation: 0,
                            side: const BorderSide(color: Color(0xFFBBF7D0)),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text('Practice 🚀', style: GoogleFonts.inter(color: const Color(0xFF166534), fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

// =============================================================================
// 2. CODING SANDBOX SCREEN (PLAYGROUND WITH BACK BUTTON & TIMER FROM 0)
// =============================================================================
class CodingSandboxScreen extends StatefulWidget {
  final LeetCodeProblem problem;
  final String userName;
  final VoidCallback onBackToProblemList;

  const CodingSandboxScreen({
    super.key,
    required this.problem,
    required this.userName,
    required this.onBackToProblemList,
  });

  @override
  State<CodingSandboxScreen> createState() => _CodingSandboxScreenState();
}

class _CodingSandboxScreenState extends State<CodingSandboxScreen> {
  int _activeLeftTab = 0;
  int _activeBottomTab = 0;
  String _selectedLanguage = 'Python 🐍';
  bool _isSophiaMinimized = false;
  bool _isAiVideoPlaying = false;

  // Realtime Stopwatch Timer
  Timer? _timer;
  int _secondsElapsed = 0;

  double _leftFlex = 3.0;
  double _middleFlex = 4.5;
  final double _rightFlex = 2.5;

  late TextEditingController _codeController;
  bool _isExecuting = false;
  String _terminalOutput = '';
  int _executionTimeMs = 0;

  final List<Map<String, String>> _aiChatMessages = [
    {
      'sender': 'sophia',
      'text': '👋 Hi! I\'m Sophia AI, your LMS Coding Coach. Need a hint on your approach, time complexity analysis, or help debugging test cases?'
    }
  ];

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.problem.initialCode);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  String _formatTimer(int totalSeconds) {
    final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopTabHeader(),
            _buildActionBanner(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: _leftFlex.toInt(),
                      child: _buildLeftPanel(),
                    ),
                    _buildResizableDivider((delta) {
                      setState(() {
                        _leftFlex = (_leftFlex + delta).clamp(1.5, 5.0);
                      });
                    }),
                    Expanded(
                      flex: _middleFlex.toInt(),
                      child: _buildMiddlePanel(),
                    ),
                    if (!_isSophiaMinimized) ...[
                      _buildResizableDivider((delta) {
                        setState(() {
                          _middleFlex = (_middleFlex + delta).clamp(2.0, 6.0);
                        });
                      }),
                      Expanded(
                        flex: _rightFlex.toInt(),
                        child: _buildRightSophiaPanel(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTabHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      color: const Color(0xFFF4F6FB),
      child: Row(
        children: [
          InkWell(
            onTap: widget.onBackToProblemList,
            child: _tabButton('Practice Problems List (28)', false, Icons.menu),
          ),
          const SizedBox(width: 12),
          _tabButton('LeetCode 150 Roadmap Tree', false, Icons.account_tree_outlined),
          const SizedBox(width: 12),
          _tabButton('Practice Playground: #${widget.problem.id} ${widget.problem.title}', true, Icons.code),
        ],
      ),
    );
  }

  Widget _tabButton(String title, bool isActive, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0F172A) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: isActive ? Colors.white : const Color(0xFF64748B)),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              color: isActive ? Colors.white : const Color(0xFF64748B),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0B131B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Explicit Back Button to Return to LMS Coding Problem List
          InkWell(
            onTap: widget.onBackToProblemList,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white, size: 14),
                  const SizedBox(width: 6),
                  Text('Back to LMS Coding', style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.bolt, color: Color(0xFFFF6B35), size: 18),
          const SizedBox(width: 6),
          Text('LMS Coding', style: GoogleFonts.inter(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('< #${widget.problem.id} >', style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF16202C),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF22303E)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.code_off_outlined, color: Colors.greenAccent, size: 14),
                  const SizedBox(width: 8),
                  Text('Automatically sync your submissions with your GitHub Account.', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFA855F7), borderRadius: BorderRadius.circular(12)),
                    child: Text('Connect', style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          InkWell(
            onTap: () => setState(() => _isSophiaMinimized = !_isSophiaMinimized),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF0284C7).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF38BDF8)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFF38BDF8), size: 14),
                  const SizedBox(width: 6),
                  Text('Sophia AI', style: GoogleFonts.inter(color: const Color(0xFF38BDF8), fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Workable Stopwatch Timer Starting from 00:00:00
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF16202C), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, color: Colors.amber, size: 14),
                const SizedBox(width: 6),
                Text(
                  _formatTimer(_secondsElapsed),
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFFFF6B35),
            child: Text(
              widget.userName.isNotEmpty ? widget.userName.substring(0, widget.userName.length >= 2 ? 2 : 1).toUpperCase() : 'AB',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111723),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF1E293B))),
            ),
            child: Row(
              children: [
                _panelTab('Question', Icons.description_outlined, 0),
                const SizedBox(width: 8),
                _panelTab('Solution (AI Video)', Icons.ondemand_video, 1),
                const SizedBox(width: 8),
                _panelTab('Submissions 24', Icons.history, 2),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _activeLeftTab == 0
                  ? _buildQuestionTabContent()
                  : _activeLeftTab == 1
                      ? _buildAiVideoSolutionTabContent()
                      : _buildSubmissionsTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panelTab(String label, IconData icon, int index) {
    final isActive = _activeLeftTab == index;
    return InkWell(
      onTap: () => setState(() => _activeLeftTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1E293B) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isActive ? Colors.white : const Color(0xFF64748B)),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.white : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('#${widget.problem.id}', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFF166534).withValues(alpha: 0.3), borderRadius: BorderRadius.circular(6)),
              child: Text(widget.problem.difficulty, style: GoogleFonts.inter(color: const Color(0xFF4ADE80), fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(widget.problem.title, style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(
          'Given an integer array, return true if any value appears at least twice in the array, and return false if every element is distinct.',
          style: GoogleFonts.inter(color: const Color(0xFFCBD5E1), fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 24),
        Text('EXAMPLES', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        const SizedBox(height: 12),
        _exampleCard('Input: nums = [1,2,3,1]', 'Output: true', 'The element 1 appears twice at indices 0 and 3.'),
        const SizedBox(height: 12),
        _exampleCard('Input: nums = [1,2,3,4]', 'Output: false', 'All elements are distinct.'),
        const SizedBox(height: 24),
        Text('CONSTRAINTS', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        const SizedBox(height: 8),
        Text('• 1 <= nums.length <= 10^5\n• -10^9 <= nums[i] <= 10^9', style: GoogleFonts.firaCode(color: const Color(0xFF94A3B8), fontSize: 11, height: 1.6)),
      ],
    );
  }

  Widget _exampleCard(String input, String output, String? explanation) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF182030),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF222F43)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: GoogleFonts.firaCode(fontSize: 11),
              children: [
                const TextSpan(text: 'Input: ', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                TextSpan(text: input.replaceAll('Input: ', ''), style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: GoogleFonts.firaCode(fontSize: 11),
              children: [
                const TextSpan(text: 'Output: ', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                TextSpan(text: output.replaceAll('Output: ', ''), style: const TextStyle(color: Color(0xFF4ADE80), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          if (explanation != null) ...[
            const SizedBox(height: 6),
            Text(
              explanation,
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontSize: 10,
              ).copyWith(fontStyle: FontStyle.italic),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildAiVideoSolutionTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AI-Generated Step-by-Step Explanation', style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFF070A12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF1E293B)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_isAiVideoPlaying ? Icons.equalizer : Icons.smart_display, size: 48, color: const Color(0xFFFF6B35)),
                  const SizedBox(height: 8),
                  Text(
                    _isAiVideoPlaying ? 'Playing Sophia AI Animation...' : 'Click to Play AI Animated Explanation',
                    style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11),
                  ),
                ],
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _isAiVideoPlaying = !_isAiVideoPlaying),
                  icon: Icon(_isAiVideoPlaying ? Icons.pause : Icons.play_arrow, size: 16),
                  label: Text(_isAiVideoPlaying ? 'Pause Video' : 'Watch AI Explanation', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubmissionsTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Submissions', style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _submissionRow('Accepted', 'Python 3', '32 ms', '16.4 MB', '2 mins ago', Colors.green),
        _submissionRow('Accepted', 'C++', '4 ms', '10.2 MB', '1 day ago', Colors.green),
      ],
    );
  }

  Widget _submissionRow(String status, String lang, String time, String mem, String ago, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF182030), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(status, style: GoogleFonts.inter(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
              Text('$lang • $ago', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 10)),
            ],
          ),
          Text('$time | $mem', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildMiddlePanel() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111723),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF1E293B)))),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedLanguage,
                  dropdownColor: const Color(0xFF1E293B),
                  underline: const SizedBox(),
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  items: ['Python 🐍', 'C++ ⚡', 'Java ☕', 'JavaScript 📜']
                      .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedLanguage = val!),
                ),
                const SizedBox(width: 12),
                _editorToolIcon(Icons.auto_fix_high, 'Auto-format'),
                const SizedBox(width: 8),
                _editorToolIcon(Icons.refresh, 'Reset Code'),
                const Spacer(),
                Text('Ln 1, Col 1', style: GoogleFonts.firaCode(color: const Color(0xFF64748B), fontSize: 10)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF070A12),
              child: TextField(
                controller: _codeController,
                maxLines: null,
                style: GoogleFonts.firaCode(color: Colors.greenAccent, fontSize: 12, height: 1.5),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF0B131B),
              border: Border(top: BorderSide(color: Color(0xFF1E293B))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _bottomTerminalTab('🧪 Test Case', 0),
                    const SizedBox(width: 12),
                    _bottomTerminalTab('>_ Output', 1),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(6)),
                      child: Text('$_executionTimeMs ms', style: GoogleFonts.firaCode(color: const Color(0xFF94A3B8), fontSize: 10)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _isExecuting
                      ? 'Compiling and executing test suite...'
                      : _terminalOutput.isNotEmpty
                          ? _terminalOutput
                          : 'Click Run to execute sample test cases or Submit to evaluate.',
                  style: GoogleFonts.firaCode(color: Colors.amber, fontSize: 11),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isExecuting = true;
                        });
                        Future.delayed(const Duration(milliseconds: 800), () {
                          setState(() {
                            _isExecuting = false;
                            _executionTimeMs = 24;
                            _terminalOutput = 'Test Case 1: PASSED\nTest Case 2: PASSED';
                          });
                        });
                      },
                      icon: const Icon(Icons.play_arrow, size: 14),
                      label: Text('Run Execution', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E)),
                      child: Text('Submit Solution 🚀', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _editorToolIcon(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Icon(icon, size: 16, color: const Color(0xFF64748B)),
    );
  }

  Widget _bottomTerminalTab(String label, int index) {
    final isActive = _activeBottomTab == index;
    return InkWell(
      onTap: () => setState(() => _activeBottomTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1E293B) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: isActive ? Colors.white : const Color(0xFF64748B)),
        ),
      ),
    );
  }

  Widget _buildRightSophiaPanel() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111723),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF1E293B)))),
            child: Row(
              children: [
                Text('Hints', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 11)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFF0284C7).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                  child: Text('✨ Sophia AI Active', style: GoogleFonts.inter(color: const Color(0xFF38BDF8), fontSize: 9, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_fullscreen, size: 14, color: Color(0xFF64748B)),
                  onPressed: () => setState(() => _isSophiaMinimized = true),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _aiChatMessages.length,
              itemBuilder: (context, idx) {
                final msg = _aiChatMessages[idx];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: const Color(0xFF1A2234), borderRadius: BorderRadius.circular(12)),
                  child: Text(msg['text']!, style: GoogleFonts.inter(color: Colors.white, fontSize: 11, height: 1.4)),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFF1E293B)))),
            child: Column(
              children: [
                _aiPromptButton('Give me an approach hint 💡', () {
                  setState(() {
                    _aiChatMessages.add({'sender': 'sophia', 'text': '💡 Hint: A hash set allows O(1) lookup. Try iterating once through nums and checking if the item already exists in your set.'});
                  });
                }),
                const SizedBox(height: 6),
                _aiPromptButton('Analyze Time Complexity ⏱', () {
                  setState(() {
                    _aiChatMessages.add({'sender': 'sophia', 'text': '⏱ Time Complexity: O(N) since we visit each element at most once. Space Complexity: O(N) for storing elements in the hash set.'});
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _aiPromptButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF1E293B)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(label, style: GoogleFonts.inter(color: const Color(0xFF38BDF8), fontSize: 10, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildResizableDivider(ValueChanged<double> onDrag) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) => onDrag(details.primaryDelta! * 0.05),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeColumn,
        child: Container(
          width: 8,
          color: Colors.transparent,
          child: Center(
            child: Container(width: 2, height: 30, color: const Color(0xFF1E293B)),
          ),
        ),
      ),
    );
  }
}