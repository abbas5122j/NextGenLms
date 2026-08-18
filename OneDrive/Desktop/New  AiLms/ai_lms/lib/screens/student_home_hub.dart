import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'course_directory_screen.dart';
import 'projects_section.dart';
import 'sophia_ai_screen.dart';
import '../widgets/student_lms_shell.dart';

// =============================================================================
// MOCK DATA MODELS & DATA STORES
// =============================================================================
class CourseCategory {
  final String id;
  final String title;
  final IconData icon;

  CourseCategory({required this.id, required this.title, required this.icon});
}

class CourseItem {
  final String id;
  final String title;
  final String instructor;
  final String category;
  final String difficulty;
  final double rating;
  final int enrolledStudents;
  final String duration;
  final double progress;
  final bool isEnrolled;
  final String description;
  final List<String> modules;

  CourseItem({
    required this.id,
    required this.title,
    required this.instructor,
    required this.category,
    required this.difficulty,
    required this.rating,
    required this.enrolledStudents,
    required this.duration,
    this.progress = 0.0,
    this.isEnrolled = false,
    required this.description,
    required this.modules,
  });
}

class CourseDataStore {
  static final List<CourseCategory> categories = [
    CourseCategory(id: 'all', title: 'All Courses', icon: Icons.grid_view),
    CourseCategory(id: 'web', title: 'Web Engineering', icon: Icons.web),
    CourseCategory(id: 'ai', title: 'Data Science & AI', icon: Icons.psychology),
    CourseCategory(id: 'backend', title: 'Backend & Systems', icon: Icons.dns),
    CourseCategory(id: 'mobile', title: 'Mobile Dev', icon: Icons.phone_android),
  ];

  static final List<CourseItem> courses = [
    CourseItem(
      id: 'c1',
      title: 'Web Engineering',
      instructor: 'Delba de Oliveira',
      category: 'Web Engineering',
      difficulty: 'Intermediate',
      rating: 4.9,
      enrolledStudents: 1420,
      duration: '32 Hours',
      progress: 0.68,
      isEnrolled: true,
      description: 'Master modern frontend architectures, React Server Components, custom hooks, and state hydration.',
      modules: [
        '1. React Server Components Architecture',
        '2. Advanced Context & Custom Hooks',
        '3. Micro-frontends & Module Federation',
        '4. Performance Optimization & Profiling'
      ],
    ),
    CourseItem(
      id: 'c2',
      title: 'Data Science & AI',
      instructor: 'Dr. Andrew Ng',
      category: 'Data Science & AI',
      difficulty: 'Advanced',
      rating: 4.8,
      enrolledStudents: 2310,
      duration: '45 Hours',
      progress: 0.45,
      isEnrolled: true,
      description: 'Comprehensive study of PyTorch, asynchronous Python data pipelines, and Neural Network fine-tuning.',
      modules: [
        '1. Async IO & High-Throughput Python',
        '2. Feature Engineering & Vector Databases',
        '3. Fine-tuning LLMs with PEFT & LoRA',
        '4. Model Deployment with FastAPI & Docker'
      ],
    ),
    CourseItem(
      id: 'c3',
      title: 'Backend Go',
      instructor: 'Alex Xu',
      category: 'Backend & Systems',
      difficulty: 'Beginner',
      rating: 4.7,
      enrolledStudents: 890,
      duration: '28 Hours',
      progress: 0.12,
      isEnrolled: true,
      description: 'Build fault-tolerant microservices, gRPC streaming protocols, and distributed caching in Golang.',
      modules: [
        '1. Go Goroutines & Channels Deep Dive',
        '2. gRPC & Protocol Buffers Architecture',
        '3. Redis Caching & Distributed Locks',
        '4. Kubernetes Deployment & Observability'
      ],
    ),
    CourseItem(
      id: 'c4',
      title: 'Cross-Platform Mobile with Flutter',
      instructor: 'Filip Hracek',
      category: 'Mobile Dev',
      difficulty: 'Intermediate',
      rating: 4.9,
      enrolledStudents: 1750,
      duration: '38 Hours',
      progress: 0.0,
      isEnrolled: false,
      description: 'Architect production-ready mobile apps using Flutter, Bloc/Riverpod state management, and native code channels.',
      modules: [
        '1. Custom RenderObjects & Canvas',
        '2. Advanced State Management (Bloc vs Riverpod)',
        '3. Platform Channels (Kotlin/Swift Sync)',
        '4. CI/CD Pipelines for App Store Deployments'
      ],
    ),
    CourseItem(
      id: 'c5',
      title: 'System Design & Distributed Systems',
      instructor: 'Martin Kleppmann',
      category: 'Backend & Systems',
      difficulty: 'Advanced',
      rating: 5.0,
      enrolledStudents: 3100,
      duration: '50 Hours',
      progress: 0.0,
      isEnrolled: false,
      description: 'Learn scalable system architectures, event-driven streaming with Kafka, and consensus protocols like Raft.',
      modules: [
        '1. Scalability, Availability & Reliability',
        '2. Distributed Storage & Sharding Algorithms',
        '3. Event Streaming with Apache Kafka',
        '4. Raft & Paxos Consensus Deep Dive'
      ],
    ),
  ];
}

class LeetCodeProblem {
  final int id;
  final String title;
  final String category;
  final String difficulty;
  final String acceptance;
  final bool isBlind75;
  final bool isTop150;
  final bool isSolved;
  final String initialCode;

  LeetCodeProblem({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.acceptance,
    this.isBlind75 = false,
    this.isTop150 = false,
    this.isSolved = false,
    required this.initialCode,
  });
}

class LeetCodeProblemsData {
  static final List<LeetCodeProblem> problems = [
    LeetCodeProblem(
      id: 217,
      title: 'Contains Duplicate',
      category: 'Arrays & Hashing',
      difficulty: 'Easy',
      acceptance: '61.3%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      initialCode: '''class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        seen = set()
        for num in nums:
            if num in seen:
                return True
            seen.add(num)
        return False''',
    ),
    LeetCodeProblem(
      id: 242,
      title: 'Valid Anagram',
      category: 'Arrays & Hashing',
      difficulty: 'Easy',
      acceptance: '63.2%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      initialCode: '''class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        return sorted(s) == sorted(t)''',
    ),
    LeetCodeProblem(
      id: 1,
      title: 'Two Sum',
      category: 'Arrays & Hashing',
      difficulty: 'Easy',
      acceptance: '52.4%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      initialCode: '''class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        prevMap = {}
        for i, n in enumerate(nums):
            diff = target - n
            if diff in prevMap:
                return [prevMap[diff], i]
            prevMap[n] = i''',
    ),
    LeetCodeProblem(
      id: 49,
      title: 'Group Anagrams',
      category: 'Arrays & Hashing',
      difficulty: 'Medium',
      acceptance: '67.8%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      initialCode: '''class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        res = defaultdict(list)
        for s in strs:
            count = [0] * 26
            for c in s:
                count[ord(c) - ord('a')] += 1
            res[tuple(count)].append(s)
        return list(res.values())''',
    ),
    LeetCodeProblem(
      id: 125,
      title: 'Valid Palindrome',
      category: 'Two Pointers',
      difficulty: 'Easy',
      acceptance: '46.9%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      initialCode: '''class Solution:
    def isPalindrome(self, s: str) -> bool:
        newStr = ""
        for c in s:
            if c.isalnum():
                newStr += c.lower()
        return newStr == newStr[::-1]''',
    ),
  ];
}

final Map<String, dynamic> gamifyLevelRoadmaps = {
  'Default': {
    'beginner': <Map<String, dynamic>>[
      {'level': '01', 'title': 'HTML5 & Semantic Structure', 'duration': '4 Hours', 'xp': '+500 XP', 'unlocked': true},
      {'level': '02', 'title': 'CSS3 Flexbox & Grid Master', 'duration': '6 Hours', 'xp': '+600 XP', 'unlocked': false},
      {'level': '03', 'title': 'JavaScript ES6+ Syntax', 'duration': '8 Hours', 'xp': '+800 XP', 'unlocked': false},
      {'level': '04', 'title': 'DOM Manipulation & Events', 'duration': '6 Hours', 'xp': '+700 XP', 'unlocked': false},
      {'level': '05', 'title': 'React Components & Props', 'duration': '10 Hours', 'xp': '+1000 XP', 'unlocked': false},
    ]
  }
};

// =============================================================================
// 1. STUDENT HOME HUB SCREEN (MAIN ROUTER & DASHBOARD)
// =============================================================================
class StudentHomeHubScreen extends StatefulWidget {
  final String userName;
  final String selectedCourseTitle;
  final String userLevel;
  final VoidCallback? onBackToHome;
  final VoidCallback? onSignOut;

  const StudentHomeHubScreen({
    super.key,
    required this.userName,
    this.selectedCourseTitle = 'Web Engineering',
    this.userLevel = 'beginner',
    this.onBackToHome,
    this.onSignOut,
  });

  @override
  State<StudentHomeHubScreen> createState() => _StudentHomeHubScreenState();
}

class _StudentHomeHubScreenState extends State<StudentHomeHubScreen> {
  int activeSidebarIndex = 0; // 0 Home, 1 Coding, 2 Gamify, 3 Courses, 4 Projects, 5 Sophia AI Tutor
  
  bool isDarkMode = false;

  DateTime _currentCalendarMonth = DateTime(2026, 8, 1);
  DateTime _selectedDate = DateTime(2026, 8, 9);

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (activeSidebarIndex) {
      case 1:
        content = LMSCodingScreen(
          userName: widget.userName,
          isDarkMode: isDarkMode,
          onToggleDarkMode: () {
            setState(() => isDarkMode = !isDarkMode);
          },
          onSelectSidebarIndex: (index) {
            setState(() => activeSidebarIndex = index);
          },
          onSignOut: widget.onSignOut,
        );
        break;

      case 2:
        content = GamifyLearningsScreen(
          userName: widget.userName,
          isDarkMode: isDarkMode,
          onToggleDarkMode: () {
            setState(() => isDarkMode = !isDarkMode);
          },
          onSelectSidebarIndex: (index) {
            setState(() => activeSidebarIndex = index);
          },
          onSignOut: widget.onSignOut,
        );
        break;

      case 3:
        content = CourseDirectoryScreen(
          userName: widget.userName,
          isDarkMode: isDarkMode,
          onToggleDarkMode: () {
            setState(() => isDarkMode = !isDarkMode);
          },
          onSelectSidebarIndex: (index) {
            setState(() => activeSidebarIndex = index);
          },
          onSignOut: widget.onSignOut,
        );
        break;

      case 4:
        content = ProjectsSection(
          userName: widget.userName,
          isDarkMode: isDarkMode,
        );
        break;

      case 5:
        content = SophiaAIScreen(
          userName: widget.userName,
          selectedCourseTitle: widget.selectedCourseTitle,
          onExit: () {
            setState(() => activeSidebarIndex = 0);
          },
          onAssessmentComplete: (String assessedLevel) {
            setState(() => activeSidebarIndex = 5);
          },
          isDarkMode: isDarkMode,
          onToggleDarkMode: () {
            setState(() => isDarkMode = !isDarkMode);
          },
        );
        break;

      default:
        content = _buildHomeContent();
    }

    return StudentLmsShell(
      activeIndex: activeSidebarIndex,
      userName: widget.userName,
      isDarkMode: isDarkMode,
      onToggleDarkMode: () {
        setState(() => isDarkMode = !isDarkMode);
      },
      onSidebarSelected: (index) {
        setState(() => activeSidebarIndex = index);
      },
      onSignOut: widget.onSignOut,
      child: content,
    );
  }

  Widget _buildHomeContent() {
    final bgColor =
        isDarkMode ? const Color(0xFF090D16) : const Color(0xFFF4F6FB);
    final cardBgColor =
        isDarkMode ? const Color(0xFF131927) : Colors.white;
    final primaryTextColor =
        isDarkMode ? Colors.white : const Color(0xFF0F172A);
    final subTextColor =
        isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Container(
      color: bgColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingBanner(),
            const SizedBox(height: 16),
            _buildAIInsightBar(),
            const SizedBox(height: 24),
            _buildGamifyConsole(),
            const SizedBox(height: 24),
            _buildActiveCourseTracks(
              cardBgColor,
              primaryTextColor,
              subTextColor,
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildSkillGraphAndCareerMap(
                        cardBgColor,
                        primaryTextColor,
                        subTextColor,
                      ),
                      const SizedBox(height: 20),
                      _buildPeerLeaderboardCard(
                        cardBgColor,
                        primaryTextColor,
                        subTextColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: _buildFullInteractiveCalendar(
                    cardBgColor,
                    primaryTextColor,
                    subTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  

  Widget _buildGreetingBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B58),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${widget.userName}! 👋',
                style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                'Ready to secure your next certification badge? Your study streak is\nactively running. Let\'s make today count!',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.9), height: 1.4),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _badgePill('🔥 7 Days Streak'),
                  const SizedBox(width: 8),
                  _badgePill('🏆 Rank #12/120'),
                ],
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(
              'Resume Learning',
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFFFF5722)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badgePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildAIInsightBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2D2509) : const Color(0xFFFEFCE8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? const Color(0xFF71540C) : const Color(0xFFFEF08A)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, size: 16, color: Color(0xFFF59E0B)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'SOPHIA AI ASSESSMENT ROUTE: Enrolled in ${widget.selectedCourseTitle} under the ${widget.userLevel.toUpperCase()} track.',
              style: GoogleFonts.inter(fontSize: 11, color: isDarkMode ? const Color(0xFFFDE68A) : const Color(0xFF854D0E)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGamifyConsole() {
    final Map<String, dynamic> courseMap = Map<String, dynamic>.from(gamifyLevelRoadmaps[widget.selectedCourseTitle] ?? gamifyLevelRoadmaps['Default']!);
    final List<Map<String, dynamic>> levels = List<Map<String, dynamic>>.from(courseMap[widget.userLevel] ?? courseMap['beginner']!);
    
    Map<String, dynamic> activeLevel = levels.first;
    for (final lvl in levels) {
      if ((lvl['unlocked'] as bool? ?? false) == true) {
        activeLevel = lvl;
        break;
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF131B2E), Color(0xFF0A0F1D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFF222F43), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _pill('🕹️ GAMIFY AI LEVEL BOARD', const Color(0xFFFF6B35)),
                      const SizedBox(width: 8),
                      _pill('LEVEL: ${widget.userLevel.toUpperCase()}', const Color(0xFFA855F7)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.selectedCourseTitle} Path',
                    style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'Assessed Level Syllabus: ${widget.userLevel.toUpperCase()} Roadmap',
                    style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF94A3B8)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Text('Core Pioneer', style: GoogleFonts.inter(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 16),
                    Text('0 / 2000 XP', style: GoogleFonts.inter(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF070A12),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFF1E293B)),
                  ),
                  child: CandyCrushPathMap(
                    levels: levels,
                    onNodeTap: () {
                      setState(() {
                        activeSidebarIndex = 2;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131B2E),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFFF6B35).withValues(alpha: 0.4), width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Active Mission Target', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFFFF6B35).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                            child: Text('Selected', style: GoogleFonts.inter(color: const Color(0xFFFF6B35), fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(
                        activeLevel['title']?.toString() ?? '',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Estimated Duration: ${activeLevel['duration']}  |  Reward: ${activeLevel['xp']}',
                        style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '⚡ ACTIVE LEVEL GOAL: Complete the foundational interactive compiler puzzle and video module to unlock Level 02.',
                          style: GoogleFonts.inter(color: Colors.amber, fontSize: 11, height: 1.4),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              activeSidebarIndex = 2;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6B35),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Open Interactive Console 🎮', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }

  Widget _buildActiveCourseTracks(Color cardBg, Color textPrimary, Color textSub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ACTIVE COURSE TRACKS', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: textSub)),
            InkWell(
              onTap: () => setState(() => activeSidebarIndex = 3),
              child: Text('View Full Course Directory ➔', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFFF5722))),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTrackCard('Web Engineering', 'React Hooks & Context', 0.68, Colors.purple, cardBg, textPrimary, textSub)),
            const SizedBox(width: 16),
            Expanded(child: _buildTrackCard('Data Science & AI', 'Python Async IO', 0.45, Colors.orange, cardBg, textPrimary, textSub)),
            const SizedBox(width: 16),
            Expanded(child: _buildTrackCard('Backend Go', 'Microservices Architecture', 0.12, Colors.teal, cardBg, textPrimary, textSub)),
          ],
        )
      ],
    );
  }

  Widget _buildTrackCard(String title, String subtitle, double progress, Color color, Color cardBg, Color textPrimary, Color textSub) {
    return InkWell(
      onTap: () => setState(() => activeSidebarIndex = 3),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            CircularProgressIndicator(value: progress, color: color, backgroundColor: const Color(0xFFF1F5F9)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: textPrimary)),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 10, color: textSub)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSkillGraphAndCareerMap(Color cardBg, Color textPrimary, Color textSub) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Aptitude-to-Career Qualification Map', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: textPrimary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(12)),
                child: Text('92% Match', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF166534))),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSkillProgressRow('Logical Synthesizer', 0.50, textPrimary),
          _buildSkillProgressRow('Algorithmic Solver', 0.45, textPrimary),
          _buildSkillProgressRow('Syntax Comprehension', 0.55, textPrimary),
          _buildSkillProgressRow('Systems Architecture', 0.40, textPrimary),
        ],
      ),
    );
  }

  Widget _buildSkillProgressRow(String label, double val, Color textPrimary) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('$label Metrics'),
            content: Text('Sophia AI analysis confirms a ${(val * 100).toInt()}% proficiency score based on recent quiz and proctored compiler submissions.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: textPrimary)),
                Text('${(val * 100).toInt()}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: textPrimary)),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(value: val, color: const Color(0xFFFF6B35), backgroundColor: const Color(0xFFE2E8F0), minHeight: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildPeerLeaderboardCard(Color cardBg, Color textPrimary, Color textSub) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TOP PERFORMING PEERS', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: textSub)),
          const SizedBox(height: 16),
          _buildPeerRow('Rahul Sahu', 'Rank #1', '99.2% rate', textPrimary, textSub),
          const SizedBox(height: 4),
          _buildPeerRow('Jessica Doe', 'Rank #2', '98.4% rate', textPrimary, textSub),
          const SizedBox(height: 4),
          _buildPeerRow('Oliver Platt', 'Rank #3', '97.5% rate', textPrimary, textSub),
        ],
      ),
    );
  }

  Widget _buildPeerRow(String name, String rank, String score, Color textPrimary, Color textSub) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(name),
            content: Text('$rank • Current Performance: $score'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFE9D5FF),
                  child: Text(name[0], style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF7E22CE))),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: textPrimary)),
                    Text(rank, style: GoogleFonts.inter(fontSize: 10, color: textSub)),
                  ],
                ),
              ],
            ),
            Text(score, style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF16A34A), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildFullInteractiveCalendar(Color cardBg, Color textPrimary, Color textSub) {
    final months = ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'];
    final monthName = months[_currentCalendarMonth.month - 1];
    final year = _currentCalendarMonth.year;

    final daysInMonth = DateUtils.getDaysInMonth(year, _currentCalendarMonth.month);
    final firstDayOffset = DateTime(year, _currentCalendarMonth.month, 1).weekday % 7;
    final totalGridCells = firstDayOffset + daysInMonth;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month, size: 18, color: Color(0xFFFF6B35)),
                  const SizedBox(width: 8),
                  Text('$monthName $year', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: textPrimary)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _currentCalendarMonth = DateTime(_currentCalendarMonth.year, _currentCalendarMonth.month - 1, 1);
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _currentCalendarMonth = DateTime(_currentCalendarMonth.year, _currentCalendarMonth.month + 1, 1);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: textSub),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalGridCells,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              if (index < firstDayOffset) {
                return const SizedBox();
              }

              final dayNum = index - firstDayOffset + 1;
              final cellDate = DateTime(year, _currentCalendarMonth.month, dayNum);
              final isSelected = cellDate.day == _selectedDate.day && cellDate.month == _selectedDate.month && cellDate.year == _selectedDate.year;
              final isToday = cellDate.day == 9 && cellDate.month == 8 && cellDate.year == 2026;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedDate = cellDate);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected Date: $dayNum $monthName $year'),
                      duration: const Duration(milliseconds: 900),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFF6B35)
                        : isToday
                            ? const Color(0xFFFF6B35).withValues(alpha: 0.15)
                            : isDarkMode
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.white
                          : isToday
                              ? const Color(0xFFFF6B35)
                              : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$dayNum',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? Colors.white
                            : isToday
                                ? const Color(0xFFFF6B35)
                                : textPrimary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}



// =============================================================================
// 3. LMS CODING MAIN SCREEN & PROBLEM HUB
// =============================================================================
class LMSCodingScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final ValueChanged<int> onSelectSidebarIndex;
  final VoidCallback? onSignOut;

  const LMSCodingScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onSelectSidebarIndex,
    this.onSignOut,
  });

  @override
  State<LMSCodingScreen> createState() => _LMSCodingScreenState();
}

class _LMSCodingScreenState extends State<LMSCodingScreen> {
  LeetCodeProblem? _activePlaygroundProblem;

  String searchQuery = '';
  String selectedCategory = 'All Categories (28)';
  String selectedDifficulty = 'All Difficulty';
  String selectedStatus = 'All Status';
  bool showTop150Only = false;
  bool showBlind75Only = false;



  @override
  Widget build(BuildContext context) {
    if (_activePlaygroundProblem != null) {
      return CodingSandboxScreen(
        problem: _activePlaygroundProblem!,
        userName: widget.userName,
        isDarkMode: widget.isDarkMode,
        onBackToProblemList: () {
          setState(() {
            _activePlaygroundProblem = null;
          });
        },
      );
    }

    final bgColor = widget.isDarkMode
        ? const Color(0xFF090D16)
        : const Color(0xFFF4F6FB);
    final cardBgColor = widget.isDarkMode
        ? const Color(0xFF131927)
        : Colors.white;
    final primaryTextColor = widget.isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);
    final subTextColor = widget.isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);
    final borderThemeColor = widget.isDarkMode
        ? const Color(0xFF1E293B)
        : const Color(0xFFE2E8F0);

    final filteredProblems = LeetCodeProblemsData.problems.where((p) {
      if (searchQuery.isNotEmpty &&
          !p.title.toLowerCase().contains(searchQuery.toLowerCase()) &&
          !p.id.toString().contains(searchQuery)) {
        return false;
      }
      if (selectedCategory != 'All Categories (28)' &&
          p.category != selectedCategory.replaceAll(' (28)', '')) {
        return false;
      }
      if (selectedDifficulty != 'All Difficulty' &&
          p.difficulty != selectedDifficulty) {
        return false;
      }
      if (selectedStatus == 'Solved' && !p.isSolved) return false;
      if (selectedStatus == 'Unsolved' && p.isSolved) return false;
      if (showTop150Only && !p.isTop150) return false;
      if (showBlind75Only && !p.isBlind75) return false;
      return true;
    }).toList();

    return Container(
        color: bgColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroHeaderCard(),
              const SizedBox(height: 20),
              _buildNavigationTabs(),
              const SizedBox(height: 20),
              _buildFilterAndSearchCard(
                cardBgColor,
                primaryTextColor,
                subTextColor,
                borderThemeColor,
              ),
              const SizedBox(height: 16),
              _buildProblemsTable(
                filteredProblems,
                cardBgColor,
                primaryTextColor,
                subTextColor,
                borderThemeColor,
              ),
            ],
          ),
        ),
      );;
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
                    color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
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
        color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: value,
        dropdownColor: widget.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
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
          color: isSelected ? const Color(0xFFFFF7ED) : (widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
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
              color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
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
                            color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
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
// 4. CODING SANDBOX SCREEN (PLAYGROUND WITH LIVE TIMER & RESIZABLE PANELS)
// =============================================================================
class CodingSandboxScreen extends StatefulWidget {
  final LeetCodeProblem problem;
  final String userName;
  final bool isDarkMode;
  final VoidCallback onBackToProblemList;

  const CodingSandboxScreen({
    super.key,
    required this.problem,
    required this.userName,
    required this.isDarkMode,
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
      backgroundColor: const Color(0xFF090D16),
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
      color: const Color(0xFF090D16),
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
        color: isActive ? const Color(0xFF1E293B) : Colors.transparent,
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
            Text(explanation, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 10, fontStyle: FontStyle.italic)),
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

// =============================================================================
// 5. GAMIFY LEARNINGS SCREEN (FULL CONSOLE WITH STEP 1 & STEP 2 ASSEMBLER)
// =============================================================================
class GamifyLearningsScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final ValueChanged<int> onSelectSidebarIndex;
  final VoidCallback? onSignOut;

  const GamifyLearningsScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onSelectSidebarIndex,
    this.onSignOut,
  });

  @override
  State<GamifyLearningsScreen> createState() => _GamifyLearningsScreenState();
}

class _GamifyLearningsScreenState extends State<GamifyLearningsScreen> {
  int selectedLevelIndex = 0;

  final List<String> availableCodeBlocks = [
    '// 3. Inside Server Component: fetch dynamic DB entries directly',
    '// 1. Mark file top level with client-boundary for React hooks',
    '// 4. Wrap child content with React Suspense component fallback stream',
    '// 2. Import standard React client Hooks like useState inside client boundary',
    '// 5. Hydrate the dynamic layout once the server payload stream completes',
  ];

  final List<String> selectedCodeSequence = [];

  final List<Map<String, dynamic>> levelsList = [
    {
      'level': '01',
      'title': 'Advanced React Patterns & Custom Hooks',
      'duration': '10 HOURS',
      'status': 'Active Level',
      'isUnlocked': true,
      'xp': '+500 XP',
      'tags': ['Compound Components', 'Render Props', 'Memoization'],
      'lecture': {
        'title': 'React Server Components vs Client Components Explained',
        'sub': 'Course: Delba de Oliveira • 14 mins',
      },
      'takeaways': [
        'Learn how RSC renders solely on the server to reduce JavaScript bundle sizes.',
        'Understand the \'use client\' boundary directive and how parameters are serialized.',
        'Master partial streaming hydration utilizing dynamic React Suspense blocks.',
      ]
    },
    {
      'level': '02',
      'title': 'High-Fidelity State Managers',
      'duration': '12 HOURS',
      'status': 'Locked',
      'isUnlocked': false,
      'xp': '+600 XP',
      'tags': ['Redux Toolkit', 'Zustand', 'Atoms'],
      'lecture': {
        'title': 'Atomic State Management with Zustand',
        'sub': 'Course: Dan Abramov • 18 mins',
      },
      'takeaways': [
        'Understand atomic state isolation vs global store patterns.',
        'Implement selector memoization to reduce re-renders.',
      ]
    },
    {
      'level': '03',
      'title': 'Next Gen Server Synced Pipelines',
      'duration': '14 HOURS',
      'status': 'Locked',
      'isUnlocked': false,
      'xp': '+800 XP',
      'tags': ['Server Actions', 'gRPC', 'WebSockets'],
      'lecture': {
        'title': 'Realtime WebSocket Mutations in Next.js',
        'sub': 'Course: Guillermo Rauch • 22 mins',
      },
      'takeaways': [
        'Stream real-time server mutations to client hydration targets.',
      ]
    },
    {
      'level': '04',
      'title': 'Custom Component Theme Systems',
      'duration': '8 HOURS',
      'status': 'Locked',
      'isUnlocked': false,
      'xp': '+400 XP',
      'tags': ['Tailwind CSS', 'Design Tokens'],
      'lecture': {
        'title': 'Building Tokenized Design Systems',
        'sub': 'Course: Adam Wathan • 10 mins',
      },
      'takeaways': [
        'Map custom CSS variables to Tailwind design tokens.',
      ]
    },
  ];

  

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDarkMode
        ? const Color(0xFF090D16)
        : const Color(0xFFF8FAFC);
    final cardBgColor = widget.isDarkMode
        ? const Color(0xFF131927)
        : Colors.white;
    final primaryTextColor = widget.isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);
    final subTextColor = widget.isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);
    final borderThemeColor = widget.isDarkMode
        ? const Color(0xFF1E293B)
        : const Color(0xFFE2E8F0);

    final currentLevelData = levelsList[selectedLevelIndex];

    return Container(
        color: bgColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderHeroBar(primaryTextColor, subTextColor),
              const SizedBox(height: 28),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 380,
                    child: _buildProgressBoard(
                      cardBgColor,
                      primaryTextColor,
                      subTextColor,
                      borderThemeColor,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: _buildMissionQuestPanel(
                      currentLevelData,
                      cardBgColor,
                      primaryTextColor,
                      subTextColor,
                      borderThemeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );;
  }



  Widget _buildHeaderHeroBar(Color textPrimary, Color textSub) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20,
      runSpacing: 16,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  _pillBadge('🎮 ACTIVE TRAINING GROUNDS', const Color(0xFFDC2626), const Color(0xFFFEE2E2)),
                  _pillBadge('INTERMEDIATE HIGH SYLLABUS', const Color(0xFFD97706), const Color(0xFFFEF3C7)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Gamify Learnings Console',
                style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.bold, color: textPrimary),
              ),
              const SizedBox(height: 6),
              Text(
                'Complete the theory videos and code executor challenges for each level to increase your learning attributes.',
                style: GoogleFonts.inter(fontSize: 13, color: textSub),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isDarkMode ? const Color(0xFF131927) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('COMPLETE LEVELS', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: const Color(0xFF94A3B8))),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('✨ ', style: TextStyle(fontSize: 12)),
                      Text('0 / 4', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A))),
                    ],
                  ),
                  Text('Cleared', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A))),
                ],
              ),
              const SizedBox(width: 20),
              Container(width: 1, height: 36, color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RANK STATUS', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: const Color(0xFF94A3B8))),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('👑 ', style: TextStyle(fontSize: 12)),
                      Text('Aesthetic Full-Stack', style: GoogleFonts.firaCode(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF9333EA))),
                    ],
                  ),
                  Text('Artisan', style: GoogleFonts.firaCode(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF9333EA))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pillBadge(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: GoogleFonts.inter(color: textColor, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProgressBoard(Color cardBg, Color textPrimary, Color textSub, Color borderCol) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎮 ', style: TextStyle(fontSize: 16)),
              Text('Level by Level Progress Board', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: textPrimary)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Select any unlocked level block to open its learning theory and game challenge.',
            style: GoogleFonts.inter(fontSize: 11, color: textSub, height: 1.4),
          ),
          const SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: levelsList.length,
            itemBuilder: (context, idx) {
              final lvl = levelsList[idx];
              final isSelected = selectedLevelIndex == idx;
              final isUnlocked = lvl['isUnlocked'] as bool;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: isSelected
                              ? const Color(0xFFFF6B35)
                              : isUnlocked
                                  ? const Color(0xFFFF6B35).withValues(alpha: 0.2)
                                  : (widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                          child: Text(
                            '${idx + 1}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : (isUnlocked ? const Color(0xFFFF6B35) : const Color(0xFF94A3B8)),
                            ),
                          ),
                        ),
                        if (idx < levelsList.length - 1)
                          Expanded(
                            child: Container(
                              width: 2,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (isUnlocked) {
                            setState(() => selectedLevelIndex = idx);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (widget.isDarkMode ? const Color(0xFF2E1065) : const Color(0xFFF5F3FF))
                                : isUnlocked
                                    ? (widget.isDarkMode ? const Color(0xFF1E293B) : Colors.white)
                                    : (widget.isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC)),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? const Color(0xFFA855F7) : borderCol,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'LEVEL ${lvl['level']}',
                                    style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF94A3B8)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: widget.isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(lvl['duration'], style: GoogleFonts.firaCode(fontSize: 9, fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                lvl['title'],
                                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: isUnlocked ? textPrimary : textSub),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    isUnlocked ? Icons.bolt : Icons.lock_outline,
                                    size: 12,
                                    color: isUnlocked ? const Color(0xFFFF6B35) : const Color(0xFF94A3B8),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    lvl['status'],
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: isUnlocked ? const Color(0xFFFF6B35) : const Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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

  Widget _buildMissionQuestPanel(Map<String, dynamic> lvl, Color cardBg, Color textPrimary, Color textSub, Color borderCol) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ACTIVE MISSION QUEST', style: GoogleFonts.firaCode(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFFF5722))),
                const SizedBox(height: 6),
                Text(lvl['title'], style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: textPrimary)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(16)),
              child: Text('✨ ${lvl['xp']}', style: GoogleFonts.inter(color: const Color(0xFFD97706), fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: (lvl['tags'] as List<String>)
              .map((tag) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(tag, style: GoogleFonts.firaCode(fontSize: 10, color: widget.isDarkMode ? Colors.white70 : const Color(0xFF475569))),
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),

        // STEP 1: THEORY MASTER LECTURE CARD
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderCol),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xFFFEF3C7),
                    child: Text('1', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFD97706))),
                  ),
                  const SizedBox(width: 10),
                  Text('STEP 1: THEORY MASTER LECTURE 📺', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: textPrimary)),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Learn the foundational concepts and logical paradigms required to solve this level\'s game compiler.',
                style: GoogleFonts.inter(fontSize: 12, color: textSub),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? const Color(0xFF0F172A) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderCol),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lvl['lecture']['title'], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: textPrimary)),
                        const SizedBox(height: 2),
                        Text(lvl['lecture']['sub'], style: GoogleFonts.inter(fontSize: 10, color: textSub)),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow, size: 16, color: Colors.white),
                      label: Text('Stream', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA855F7),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderCol),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('THEORY KEY TAKEAWAYS:', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
                    const SizedBox(height: 8),
                    ...(lvl['takeaways'] as List<String>).map((t) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('★ ', style: TextStyle(color: Colors.amber, fontSize: 10)),
                              Expanded(child: Text(t, style: GoogleFonts.inter(fontSize: 11, color: textPrimary, height: 1.4))),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // STEP 2: GAMIFY AI COMPILER CHALLENGE
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderCol),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xFFF3E8FF),
                    child: Text('2', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFA855F7))),
                  ),
                  const SizedBox(width: 10),
                  Text('STEP 2: GAMIFY AI COMPILER CHALLENGE 🎮', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: textPrimary)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFFCFDFF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderCol),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SCENARIO CHALLENGE', style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFFA855F7))),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text('React Server Component Assembler ', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: textPrimary)),
                        const Text('🧩', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your RSC component fails to render because the client boundary and data fetching are disordered. Rearrange the layout code blocks to establish a valid stream from the server down to the client layout hook.',
                      style: GoogleFonts.inter(fontSize: 12, color: textSub, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: widget.isDarkMode ? const Color(0xFF090D16) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: borderCol),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CURRENT CODE SEQUENCE:', style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFFA855F7))),
                          const SizedBox(height: 16),
                          if (selectedCodeSequence.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Click the code blocks below in the correct sequence to order them...',
                                  style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF94A3B8), fontStyle: FontStyle.italic),
                                ),
                              ),
                            )
                          else
                            Column(
                              children: selectedCodeSequence
                                  .map((code) => Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Expanded(child: Text(code, style: GoogleFonts.firaCode(color: Colors.greenAccent, fontSize: 11))),
                                            IconButton(
                                              icon: const Icon(Icons.close, color: Colors.redAccent, size: 16),
                                              onPressed: () {
                                                setState(() {
                                                  selectedCodeSequence.remove(code);
                                                  availableCodeBlocks.add(code);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('AVAILABLE CODE BLOCKS:', style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
                    const SizedBox(height: 12),
                    Column(
                      children: availableCodeBlocks
                          .map((block) => InkWell(
                                onTap: () {
                                  setState(() {
                                    availableCodeBlocks.remove(block);
                                    selectedCodeSequence.add(block);
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: widget.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: borderCol),
                                  ),
                                  child: Text(block, style: GoogleFonts.firaCode(fontSize: 11, color: widget.isDarkMode ? Colors.greenAccent : const Color(0xFF334155))),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF030712),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Verifying level compiler: Advanced React Patterns & Custom Hooks', style: GoogleFonts.firaCode(fontSize: 10, color: const Color(0xFF64748B))),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 6),
                            Text('Sandbox Connected', style: GoogleFonts.firaCode(fontSize: 10, color: const Color(0xFF22C55E))),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('\$ compiler environment initialized for Level m1', style: GoogleFonts.firaCode(fontSize: 11, color: const Color(0xFF94A3B8))),
                    const SizedBox(height: 4),
                    Text('\$ Sandbox isolates connected & ready.', style: GoogleFonts.firaCode(fontSize: 11, color: const Color(0xFF94A3B8))),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('⚡ Sandbox compiler verifying code sequence...'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(Icons.refresh, size: 14, color: Colors.white),
                        label: Text('Run Sandbox Compiler', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA855F7),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Verify Level & Complete Quest 👑', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('💡 ', style: TextStyle(fontSize: 12)),
                    Text(
                      'Watch the Theory Lecture and execute the Compiler restoring challenge to complete the level.',
                      style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF94A3B8)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  

  
}

// =============================================================================
// 6. ANIMATED CANDY CRUSH ROADMAP PATH BOARD
// =============================================================================
class CandyCrushPathMap extends StatefulWidget {
  final List<Map<String, dynamic>> levels;
  final VoidCallback? onNodeTap;

  const CandyCrushPathMap({
    super.key,
    required this.levels,
    this.onNodeTap,
  });

  @override
  State<CandyCrushPathMap> createState() => _CandyCrushPathMapState();
}

class _CandyCrushPathMapState extends State<CandyCrushPathMap> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> xOffsets = [0.18, 0.50, 0.82, 0.50, 0.18];

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        const double itemHeight = 125.0;
        final double totalHeight = math.max(widget.levels.length * itemHeight, 400.0);

        List<Offset> nodeCenters = [];
        for (int i = 0; i < widget.levels.length; i++) {
          final double x = width * xOffsets[i % xOffsets.length];
          final double y = (i * itemHeight) + 36;
          nodeCenters.add(Offset(x, y));
        }

        return SizedBox(
          height: totalHeight,
          width: width,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: Size(width, totalHeight),
                    painter: CandyPathPainter(
                      nodeCenters: nodeCenters,
                      animationValue: _pulseController.value,
                    ),
                  ),
                  for (int i = 0; i < widget.levels.length; i++) ...[
                    Positioned(
                      left: nodeCenters[i].dx - 110,
                      top: nodeCenters[i].dy - 32,
                      child: SizedBox(
                        width: 220,
                        child: GestureDetector(
                          onTap: widget.onNodeTap,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildNodeCircle(widget.levels[i], i),
                              const SizedBox(height: 8),
                              _buildNodeInfoCard(widget.levels[i]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildNodeCircle(Map<String, dynamic> level, int index) {
    final bool isUnlocked = (level['unlocked'] as bool? ?? false) == true;
    final String levelNum = level['level']?.toString() ?? '${index + 1}';

    return ScaleTransition(
      scale: isUnlocked ? _pulseAnimation : const AlwaysStoppedAnimation(1.0),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isUnlocked
              ? const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8C35)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF6B35).withValues(alpha: 0.6),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                  BoxShadow(
                    color: const Color(0xFFFF8C35).withValues(alpha: 0.3),
                    blurRadius: 35,
                    spreadRadius: 8,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  )
                ],
          border: Border.all(
            color: isUnlocked ? Colors.white : const Color(0xFF334155),
            width: 3,
          ),
        ),
        child: Center(
          child: isUnlocked
              ? Text(
                  levelNum.padLeft(2, '0'),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                )
              : const Icon(
                  Icons.lock_rounded,
                  color: Color(0xFF64748B),
                  size: 24,
                ),
        ),
      ),
    );
  }

  Widget _buildNodeInfoCard(Map<String, dynamic> level) {
    final bool isUnlocked = (level['unlocked'] as bool? ?? false) == true;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF182030),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? const Color(0xFFFF6B35).withValues(alpha: 0.6) : const Color(0xFF222F43),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            level['title']?.toString() ?? 'Module Title',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: isUnlocked ? Colors.white : const Color(0xFF94A3B8),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${level['duration']} • ${level['xp']}',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class CandyPathPainter extends CustomPainter {
  final List<Offset> nodeCenters;
  final double animationValue;

  CandyPathPainter({
    required this.nodeCenters,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (nodeCenters.length < 2) return;

    final Path path = Path();
    path.moveTo(nodeCenters[0].dx, nodeCenters[0].dy);

    for (int i = 0; i < nodeCenters.length - 1; i++) {
      final p1 = nodeCenters[i];
      final p2 = nodeCenters[i + 1];

      final controlPoint1 = Offset(p1.dx, p1.dy + (p2.dy - p1.dy) / 2);
      final controlPoint2 = Offset(p2.dx, p1.dy + (p2.dy - p1.dy) / 2);

      path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        p2.dx, p2.dy,
      );
    }

    final Paint glowPaint = Paint()
      ..color = const Color(0xFFFF6B35).withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final Paint linePaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, linePaint);

    final Paint particlePaint = Paint()
      ..color = const Color(0xFFFF8C35).withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < nodeCenters.length - 1; i++) {
      final p1 = nodeCenters[i];
      final p2 = nodeCenters[i + 1];
      final midX = (p1.dx + p2.dx) / 2;
      final midY = (p1.dy + p2.dy) / 2;

      canvas.drawCircle(Offset(midX, midY), 3 + (animationValue * 2.5), particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CandyPathPainter oldDelegate) => true;
}