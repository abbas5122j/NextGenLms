import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamifyLearningsScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final VoidCallback? onBackToHome;
  final VoidCallback? onSignOut;

  const GamifyLearningsScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    this.onBackToHome,
    this.onSignOut,
  });

  @override
  State<GamifyLearningsScreen> createState() => _GamifyLearningsScreenState();
}

class _GamifyLearningsScreenState extends State<GamifyLearningsScreen> {
  int activeSidebarIndex = 2;
  bool isSidebarCollapsed = false;

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
    final bgColor = widget.isDarkMode ? const Color(0xFF090D16) : const Color(0xFFF8FAFC);
    final cardBgColor = widget.isDarkMode ? const Color(0xFF131927) : Colors.white;
    final primaryTextColor = widget.isDarkMode ? Colors.white : const Color(0xFF0F172A);
    final subTextColor = widget.isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final borderThemeColor = widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);

    final currentLevelData = levelsList[selectedLevelIndex];

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
                              child: _buildProgressBoard(cardBgColor, primaryTextColor, subTextColor, borderThemeColor),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildMissionQuestPanel(currentLevelData, cardBgColor, primaryTextColor, subTextColor, borderThemeColor),
                            ),
                          ],
                        )
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
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: const Color(0xFF94A3B8),
                                    fontStyle: FontStyle.italic,
                                  ),
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
                      if (index == 0 && widget.onBackToHome != null) {
                        widget.onBackToHome!();
                      } else {
                        setState(() => activeSidebarIndex = index);
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
                color: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
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
              widget.isDarkMode ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
              size: 20,
              color: widget.isDarkMode ? Colors.amber : const Color(0xFF64748B),
            ),
            onPressed: widget.onToggleDarkMode,
          ),
          const SizedBox(width: 8),
          Icon(Icons.notifications_none, size: 20, color: textSub),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFFF6B35),
            child: Text(
              widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : 'A',
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
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
}

// =============================================================================
// 5. ANIMATED CANDY CRUSH ROADMAP PATH BOARD
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