
import 'package:flutter/material.dart';

/// Next Gen LMS - Student Report / Skill Mastery Screen
///
/// This screen is CONTENT ONLY. Keep the global StudentLmsShell/sidebar
/// outside this widget, exactly like the other student sections.
class ReportScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;

  const ReportScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String selectedFilter = 'All';

  final List<_SkillRecord> skills = const [
    _SkillRecord(
      category: 'FULL-STACK',
      title: 'React 18 & Concurrent UI Architecture',
      score: 98,
      level: 'Mastery Level',
      origin: 'Web Development Onboarding Diagnostic & React 18 Exam',
      benchmark: '+22% above industry senior baseline',
      strengths: [
        'Flawless memoization with useMemo/useCallback',
        'Clean custom hook state abstraction',
        'Virtual DOM optimization',
      ],
      growth: 'WebGPU Canvas shaders for high-fps animations',
    ),
    _SkillRecord(
      category: 'AI & LLMS',
      title: 'Large Language Models & Gemini API Integration',
      score: 96,
      level: 'Mastery Level',
      origin: 'AI Systems & Generative Model Integration Evaluation',
      benchmark: '+28% above industry average',
      strengths: [
        'Structured JSON schema output parsing',
        'Function calling & tool declaration',
        'Streaming response management',
      ],
      growth: 'Fine-tuning embedding chunk sizes for vector search',
    ),
    _SkillRecord(
      category: 'FULL-STACK',
      title: 'Node.js Microservices & Express Server Architecture',
      score: 94,
      level: 'Advanced Level',
      origin: 'Backend Microservices & REST API Performance Test',
      benchmark: '+18% above industry average',
      strengths: [
        'Async middleware flow control',
        'CORS & security headers configuration',
        'esbuild compilation pipelines',
      ],
      growth: 'gRPC streaming for low-latency intra-service communication',
    ),
    _SkillRecord(
      category: 'DATA & SQL',
      title: 'PostgreSQL, Drizzle ORM & Vector Search',
      score: 92,
      level: 'Advanced Level',
      origin: 'Database Systems, Relational Schema & Indexing Evaluation',
      benchmark: '+15% above industry average',
      strengths: [
        'Complex JOIN multi-table query design',
        'ACID transaction isolation levels',
        'Index optimization',
      ],
      growth: 'Partitioning ultra-large scale time-series tables',
    ),
    _SkillRecord(
      category: 'SECURITY',
      title: 'Cryptographic Security & OAuth 2.0 / JWT',
      score: 95,
      level: 'Mastery Level',
      origin: 'Cybersecurity & Identity Authentication Diagnostic',
      benchmark: '+25% above industry average',
      strengths: [
        'SHA-256 Digesting & RSA Signing',
        'PKCE OAuth flow implementation',
        'Zero-Trust credential verification',
      ],
      growth: 'Quantum-resistant lattice cryptography algorithms',
    ),
    _SkillRecord(
      category: 'FULL-STACK',
      title: 'TypeScript Strict Mode & Generics Engineering',
      score: 97,
      level: 'Mastery Level',
      origin: 'Advanced TypeScript Type System & Architecture Exam',
      benchmark: '+20% above industry average',
      strengths: [
        'Mapped & conditional types',
        'Discriminated union narrowing',
        'Strict null checks',
      ],
      growth: 'Compiler plugin transformations',
    ),
  ];

  final List<_CareerRole> roles = const [
    _CareerRole(
      role: 'Full-Stack AI Engineer',
      match: 98,
      salary: '\$145,000 - \$185,000 / yr',
      tag: 'Highly Recommended Track',
    ),
    _CareerRole(
      role: 'Senior Frontend Architect',
      match: 95,
      salary: '\$140,000 - \$175,000 / yr',
      tag: 'Strong Technical Alignment',
    ),
    _CareerRole(
      role: 'Distributed Systems Lead',
      match: 92,
      salary: '\$150,000 - \$190,000 / yr',
      tag: 'Advanced Capacity',
    ),
  ];

  Color get page =>
      widget.isDarkMode ? const Color(0xFF10131A) : const Color(0xFFF3F5FA);
  Color get surface =>
      widget.isDarkMode ? const Color(0xFF1A1F29) : Colors.white;
  Color get text =>
      widget.isDarkMode ? Colors.white : const Color(0xFF111827);
  Color get muted =>
      widget.isDarkMode ? const Color(0xFF9CA6B8) : const Color(0xFF718096);
  Color get line =>
      widget.isDarkMode ? const Color(0xFF303744) : const Color(0xFFE1E6EF);

  @override
  Widget build(BuildContext context) {
    final filtered = selectedFilter == 'All'
        ? skills
        : skills.where((s) => s.category == selectedFilter.toUpperCase()).toList();

    return Scaffold(
      backgroundColor: page,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(38, 34, 38, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _hero(),
            const SizedBox(height: 35),
            _summaryCards(),
            const SizedBox(height: 35),
            _diagnosticSummary(),
            const SizedBox(height: 34),
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 1050;

                if (!wide) {
                  return Column(
                    children: [
                      _skillMatrix(filtered),
                      const SizedBox(height: 24),
                      _careerGuidance(),
                      const SizedBox(height: 24),
                      _facultyRequests(),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 7, child: _skillMatrix(filtered)),
                    const SizedBox(width: 25),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _careerGuidance(),
                          const SizedBox(height: 24),
                          _facultyRequests(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _hero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(38, 34, 38, 34),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF11152F), Color(0xFF29266B)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.14),
            blurRadius: 18,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 850;

          final heading = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 9,
                runSpacing: 8,
                children: [
                  _heroPill(
                    '♧  ASSESSMENT-DRIVEN SKILL INTELLIGENCE & DIAGNOSTIC ANALYTICS',
                    const Color(0xFFCC70FF),
                  ),
                  _heroPill('18/18 Tests Evaluated', const Color(0xFFBFC7E8)),
                ],
              ),
              const SizedBox(height: 17),
              const Text(
                'Student Skill Mastery & Performance Report',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 11),
              const Text(
                'Comprehensive report mapping technical skills acquired through assessment tests, problem-solving evaluations, and practical coding diagnostics. Directly exportable to faculty advisors.',
                style: TextStyle(
                  color: Color(0xFFDCE0F1),
                  fontSize: 13,
                  height: 1.55,
                ),
              ),
            ],
          );

          final score = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 182,
                height: 98,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.10),
                  border: Border.all(color: Colors.white.withOpacity(.18)),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '95.3%',
                      style: TextStyle(
                        color: Color(0xFFFFD42A),
                        fontSize: 29,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'OVERALL SKILL SCORE',
                      style: TextStyle(
                        color: Color(0xFFDCE0F1),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .7,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              SizedBox(
                width: 370,
                child: ElevatedButton.icon(
                  onPressed: _openGuidanceDialog,
                  icon: const Icon(Icons.send_outlined, size: 17),
                  label: const Text(
                    'Send Report to Instructor for Career Guidance',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A30),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 17,
                    ),
                    elevation: 7,
                    shadowColor: const Color(0xFFFF7A30).withOpacity(.35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading,
                const SizedBox(height: 24),
                score,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: heading),
              const SizedBox(width: 28),
              score,
            ],
          );
        },
      ),
    );
  }

  Widget _heroPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(.11),
        border: Border.all(color: color.withOpacity(.28)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          letterSpacing: .6,
        ),
      ),
    );
  }

  Widget _summaryCards() {
    final cards = [
      (
        'TECHNICAL ACCURACY',
        '96.5%',
        'Based on 18 Assessment Tests',
        Icons.track_changes_outlined,
      ),
      (
        'PROBLEM SOLVING SPEED',
        '92.0%',
        'Top 3% Speed Benchmark',
        Icons.bolt_outlined,
      ),
      (
        'CODE QUALITY & RIGOR',
        '97.0%',
        'Zero-Warning Architecture',
        Icons.verified_user_outlined,
      ),
      (
        'INDUSTRY READINESS RANK',
        'Top 2%',
        'Tier-1 Tech Candidate',
        Icons.workspace_premium_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1050
            ? 4
            : constraints.maxWidth >= 700
                ? 2
                : 1;
        final gap = 18.0;
        final width = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: cards.map((c) {
            return SizedBox(
              width: width,
              child: _summaryCard(c.$1, c.$2, c.$3, c.$4),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      height: 126,
      padding: const EdgeInsets.fromLTRB(23, 20, 19, 18),
      decoration: BoxDecoration(
        color: surface,
        border: Border.all(color: line),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.045),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: muted,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .7,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  value,
                  style: TextStyle(
                    color: text,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: muted, fontSize: 9.5),
                ),
              ],
            ),
          ),
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF2784FF), size: 27),
          ),
        ],
      ),
    );
  }

  Widget _diagnosticSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(27, 24, 27, 25),
      decoration: BoxDecoration(
        color: surface,
        border: Border.all(color: line),
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.psychology_alt_outlined,
                  color: Color(0xFF8C2DFF),
                  size: 22,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Skill Diagnostic Summary',
                      style: TextStyle(
                        color: text,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Automated synthesis derived from evaluation test performance and code submissions',
                      style: TextStyle(color: muted, fontSize: 10.5),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E8FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Verified Student Profile',
                  style: TextStyle(
                    color: Color(0xFF8A2BE2),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 27, color: line),
          Text(
            '"${widget.userName.isEmpty ? 'Student' : widget.userName} demonstrates exceptional technical capability across Full-Stack Web Development, Gemini LLM API Integrations, and Relational Database Systems. In test assessments, problem-solving accuracy consistently exceeds 96%, with remarkable proficiency in React 18 concurrent rendering patterns and secure TypeScript architectures. Recommended for Senior Full-Stack AI Engineer and Solutions Architect career paths."',
            style: TextStyle(
              color: text,
              fontSize: 12,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillMatrix(List<_SkillRecord> filtered) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bar_chart_rounded,
                        color: Color(0xFFFF6D20),
                        size: 22,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        'Validated Skill Matrix',
                        style: TextStyle(
                          color: text,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Skills earned & proven via diagnostic assessment tests',
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        _filterBar(),
        const SizedBox(height: 14),
        ...filtered.map(_skillCard),
      ],
    );
  }

  Widget _filterBar() {
    final filters = ['All', 'Full-Stack', 'AI & LLMs', 'Data & SQL', 'Security'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final active = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => setState(() => selectedFilter = filter),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFFFF7830)
                      : (widget.isDarkMode
                          ? const Color(0xFF1D222C)
                          : const Color(0xFFF8F9FC)),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: active ? Colors.white : text,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _skillCard(_SkillRecord skill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 19),
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 21),
      decoration: BoxDecoration(
        color: surface,
        border: Border.all(color: line),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEFE7),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  skill.category,
                  style: const TextStyle(
                    color: Color(0xFFFF6A1A),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${skill.score}%',
                style: TextStyle(
                  color: text,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            skill.title,
            style: TextStyle(
              color: text,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: skill.score / 100,
                    backgroundColor: widget.isDarkMode
                        ? const Color(0xFF30343D)
                        : const Color(0xFFECEEF3),
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFFFF7B25),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4F9F0),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  skill.level,
                  style: const TextStyle(
                    color: Color(0xFF00A96B),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Origin: ${skill.origin}',
                  style: TextStyle(
                    color: muted,
                    fontSize: 9.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Text(
                skill.benchmark,
                style: const TextStyle(
                  color: Color(0xFF00A96B),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Divider(height: 25, color: line),
          Text(
            'DEMONSTRATED KEY STRENGTHS',
            style: TextStyle(
              color: muted,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: .6,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 7,
            children: skill.strengths
                .map(
                  (s) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAFBF4),
                      border: Border.all(color: const Color(0xFFA8E9D1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '✓ $s',
                      style: const TextStyle(
                        color: Color(0xFF008A5C),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          Text(
            'TARGET GROWTH OPPORTUNITY',
            style: TextStyle(
              color: muted,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: .6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '💡 ${skill.growth}',
            style: TextStyle(color: text, fontSize: 10.5),
          ),
        ],
      ),
    );
  }

  Widget _careerGuidance() {
    return _panel(
      title: 'Target Role Fit & Industry Salaries',
      subtitle: 'Calculated from verified assessment test proficiency',
      icon: Icons.gps_fixed_outlined,
      iconColor: const Color(0xFF1769E0),
      child: Column(
        children: [
          ...roles.map(
            (role) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? const Color(0xFF20252E)
                    : const Color(0xFFF8F9FB),
                border: Border.all(color: line),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          role.role,
                          style: TextStyle(
                            color: text,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        '${role.match}% Match',
                        style: const TextStyle(
                          color: Color(0xFF00A96B),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          role.salary,
                          style: TextStyle(
                            color: muted,
                            fontSize: 9.5,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5FAF2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            role.tag,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF00A96B),
                              fontSize: 8.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _openGuidanceDialog,
              icon: const Icon(Icons.school_outlined, size: 16),
              label: const Text('Request Career Referral from Faculty'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF11182D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _facultyRequests() {
    return _panel(
      title: 'Faculty Guidance Requests',
      subtitle: 'Reports dispatched to instructors',
      icon: Icons.chat_bubble_outline_rounded,
      iconColor: const Color(0xFFFF6D20),
      trailing: '1 Sent',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? const Color(0xFF20252E)
              : const Color(0xFFF8F9FB),
          border: Border.all(color: line),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Sarah Jenkins',
                        style: TextStyle(
                          color: text,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Lead AI Architect',
                        style: TextStyle(color: muted, fontSize: 9.5),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4F9F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Guidance Notes Received',
                    style: TextStyle(
                      color: Color(0xFF00A96B),
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? const Color(0xFF292E38)
                    : const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '"Requesting career review for Full-Stack AI Engineer positions at Tier-1 Tech companies."',
                style: TextStyle(
                  color: muted,
                  fontSize: 10,
                  height: 1.45,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE7FAF4),
                border: Border.all(color: const Color(0xFFA9EBD5)),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Text(
                '🎓 FACULTY GUIDANCE NOTE RECEIVED:\n\nOutstanding assessment scores in Gemini API & React 18! I have recommended your profile for our Google Cloud & Meta Industry Referral Program. Let’s schedule a 1-on-1 mentorship session on Friday.',
                style: TextStyle(
                  color: Color(0xFF16443A),
                  fontSize: 10.5,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 13),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Dispatched on July 21, 2026  •  Ref: REP-2026-0812',
                style: TextStyle(
                  color: muted,
                  fontSize: 8.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _panel({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Widget child,
    String? trailing,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 21, 22, 22),
      decoration: BoxDecoration(
        color: surface,
        border: Border.all(color: line),
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.035),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: text,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(color: muted, fontSize: 10),
                    ),
                  ],
                ),
              ),
              if (trailing != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isDarkMode
                        ? const Color(0xFF252A34)
                        : const Color(0xFFF1F3F7),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    trailing,
                    style: TextStyle(
                      color: text,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 17),
          child,
        ],
      ),
    );
  }

  void _openGuidanceDialog() {
    String advisor = 'Dr. Sarah Jenkins';
    final noteController = TextEditingController(
      text:
          'Dear Faculty, I have completed my technical assessment test evaluations scoring an overall 95.3% proficiency across Full-Stack AI, Cloud, and Systems Architecture. I would appreciate your expert guidance on senior engineering career tracks and top company referrals.',
    );

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 28,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 670, maxHeight: 760),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(27, 24, 27, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '♧ DIRECT FACULTY ADVISORY BRIDGE',
                                  style: TextStyle(
                                    color: Color(0xFFFF6D20),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: .6,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Send Assessment Report & Request Career Guidance',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const Divider(height: 30),
                      const Text(
                        'Select Faculty Advisor / Instructor *',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 11),
                      ...[
                        (
                          'Dr. Sarah Jenkins',
                          'Lead AI Architect & Senior Faculty • Computer Science & AI Labs',
                        ),
                        (
                          'Prof. Marcus Thorne',
                          'Dean of Academic Affairs & Systems Chair • Department of Software Engineering',
                        ),
                        (
                          'Dr. Alexei Petrov',
                          'Head of Cryptography & Cloud Security • Cybersecurity & Blockchain Division',
                        ),
                      ].map(
                        (advisorData) => Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () => setDialogState(
                              () => advisor = advisorData.$1,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: advisor == advisorData.$1
                                    ? const Color(0xFFFFF7F2)
                                    : null,
                                border: Border.all(
                                  color: advisor == advisorData.$1
                                      ? const Color(0xFFFF7931)
                                      : const Color(0xFFE0E5ED),
                                  width: advisor == advisorData.$1 ? 1.4 : 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: const Color(0xFFFFE6D7),
                                    child: Text(
                                      advisorData.$1
                                          .split(' ')
                                          .where((e) => e.isNotEmpty)
                                          .take(2)
                                          .map((e) => e[0])
                                          .join(),
                                      style: const TextStyle(
                                        color: Color(0xFFFF6D20),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          advisorData.$1,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          advisorData.$2,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (advisor == advisorData.$1)
                                    const Icon(
                                      Icons.check_circle_outline,
                                      color: Color(0xFFFF6D20),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Data Attachments Included in Report',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 9),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F8FA),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE1E5EC),
                          ),
                        ),
                        child: const Column(
                          children: [
                            _CheckLine(
                              'Include 18 Assessment Test Scores & Diagnostic Accuracy Matrix',
                            ),
                            _CheckLine(
                              'Include Identified Strengths & Career Role Fit Benchmarks',
                            ),
                            _CheckLine(
                              'Attach Verified Polygon Blockchain Certificate Hash Badges',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Personalized Note & Career Guidance Question *',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 9),
                      TextField(
                        controller: noteController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF7F8FA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(
                              color: Color(0xFFE1E5EC),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(
                              color: Color(0xFFE1E5EC),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Report dispatched to $advisor.',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.send_outlined, size: 16),
                            label: const Text(
                              'Dispatch Report to Instructor Now',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF7830),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 17,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(noteController.dispose);
  }
}

class _CheckLine extends StatelessWidget {
  final String text;

  const _CheckLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_box,
            color: Color(0xFF1877F2),
            size: 20,
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 10.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillRecord {
  final String category;
  final String title;
  final int score;
  final String level;
  final String origin;
  final String benchmark;
  final List<String> strengths;
  final String growth;

  const _SkillRecord({
    required this.category,
    required this.title,
    required this.score,
    required this.level,
    required this.origin,
    required this.benchmark,
    required this.strengths,
    required this.growth,
  });
}

class _CareerRole {
  final String role;
  final int match;
  final String salary;
  final String tag;

  const _CareerRole({
    required this.role,
    required this.match,
    required this.salary,
    required this.tag,
  });
}
