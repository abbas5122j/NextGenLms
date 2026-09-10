import 'package:flutter/material.dart';

/// Next Gen LMS — FAQs & Support
///
/// Content-only screen. Keep the global StudentLmsShell/sidebar in
/// StudentHomeHubScreen. Open this page from sidebar index 14.
class FaqScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;

  const FaqScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
  });

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  static const Color accent = Color(0xFFFF5A5F);
  static const Color blue = Color(0xFF3B82F6);
  static const Color orange = Color(0xFFFF7A30);

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String selectedCategory = 'All';
  String activeTab = 'faqs';
  int? expandedIndex;

  final List<Map<String, String>> tickets = [
    {
      'id': 'TCK-42',
      'subject': 'Sandbox Docker container failed to launch',
      'date': 'July 21, 2026',
      'status': 'Resolved',
    },
    {
      'id': 'TCK-38',
      'subject': 'Question about certificate verification',
      'date': 'July 17, 2026',
      'status': 'Closed',
    },
  ];

  final List<Map<String, String>> faqs = [
    // General & Platform — 4
    {
      'category': 'General & Platform',
      'question': 'What is NextGen LMS and what makes it unique?',
      'answer':
          'NextGen LMS is an AI-powered, next-generation Learning Management System built specifically for engineering students. It combines interactive branch-specific curriculums, live in-browser code playgrounds, real-time Gemini AI tutoring, Polygon blockchain verifiable certifications, and an automated 100% ATS-friendly resume builder.',
    },
    {
      'category': 'General & Platform',
      'question': 'Which engineering branches and departments are supported?',
      'answer':
          'NextGen LMS offers tailored courses and projects for 7 major engineering disciplines: Computer Science & Engineering (CSE), Information Technology (IT), Electronics & Communication (ECE), Electrical & Electronics (EEE), Mechanical Engineering (ME), Civil Engineering (CE), Chemical Engineering (CH), and Aerospace Engineering (AE).',
    },
    {
      'category': 'General & Platform',
      'question': 'How do I switch my active branch or view specialized courses?',
      'answer':
          'You can switch your active branch anytime using the top navigation header dropdown or branch selector pills on the Courses page. The entire platform — including recommended courses, capstone projects, quizzes, and announcements — instantly updates to match your selected branch.',
    },
    {
      'category': 'General & Platform',
      'question': 'Is NextGen LMS mobile-friendly?',
      'answer':
          'Yes! NextGen LMS features a fluid responsive layout with mobile touch optimization, collapsible navigation drawers, and an adaptive mobile code editor for seamless learning on smartphones, tablets, and laptops.',
    },

    // AI Tutor & Code IDE — 4
    {
      'category': 'AI Tutor & Code IDE',
      'question': 'How does the real-time AI Tutor and Code Assistant work?',
      'answer':
          'Powered by server-side Google Gemini models, the AI Tutor provides instant code debugging, concept explanations, step-by-step project guidance, and automated quiz explanations with full code syntax highlighting.',
    },
    {
      'category': 'AI Tutor & Code IDE',
      'question': 'Can the AI Tutor debug my C++, Python, or React code in real time?',
      'answer':
          'Yes! You can paste any code snippet or click "Ask AI Tutor" inside the LMS Code Playground. The AI analyzes syntax errors, runtime bugs, memory leaks, and logic flaws, and provides refactored code with explanatory line notes.',
    },
    {
      'category': 'AI Tutor & Code IDE',
      'question': 'What is the AI Diagnostic Engine & Skill Assessment?',
      'answer':
          'The AI Diagnostic Engine continuously evaluates your quiz performances, project submissions, and learning speed to generate a personalized skill diagnostic report, highlight topic weak spots, and suggest targeted practice modules.',
    },
    {
      'category': 'AI Tutor & Code IDE',
      'question': 'How do streaming AI responses work?',
      'answer':
          'The platform proxies streaming requests directly to the server-side Gemini API. Token responses stream in real time into your interactive chat, ensuring instant feedback with zero delay.',
    },

    // Courses & Sandboxes — 4
    {
      'category': 'Courses & Sandboxes',
      'question': 'What is the Web & Code Playground / IDE feature?',
      'answer':
          'NextGen LMS includes an embedded code playground where you can write React 18, TypeScript, Python, C++, or Node.js code, run live browser previews, and inspect console outputs without installing external software.',
    },
    {
      'category': 'Courses & Sandboxes',
      'question': 'How do initial Course Level Assessments work?',
      'answer':
          'Before starting any course, you can take a 5-question Level Assessment. Based on your score, the platform assigns you a Beginner, Intermediate, or Advanced track with tailored study material and project goals.',
    },
    {
      'category': 'Courses & Sandboxes',
      'question': 'How are capstone project submissions evaluated?',
      'answer':
          'Projects include rubrics and automated test suites. Upon submission, faculty instructors and automated grading scripts evaluate your code architecture, git commits, and performance benchmarks to issue letter grades.',
    },
    {
      'category': 'Courses & Sandboxes',
      'question': 'Can I download course materials or lesson transcripts?',
      'answer':
          'Yes! Lesson transcripts, key code snippets, architecture diagrams, and downloadable exercise files are available under the Curriculum and Resources tabs inside every course page.',
    },

    // Quizzes & Grading — 3
    {
      'category': 'Quizzes & Grading',
      'question': 'How are timed quizzes administered and scored?',
      'answer':
          'Quizzes feature live countdown timers (e.g. 15 minutes for 15 questions) with automatic submission upon timer expiry. Scores are calculated instantly, and detailed answer keys with explanations are unlocked immediately.',
    },
    {
      'category': 'Quizzes & Grading',
      'question': 'What happens if my internet connection drops during a quiz?',
      'answer':
          'NextGen LMS locally caches your selected answers in real time. If your connection drops temporarily, your answers remain saved and auto-submit seamlessly once your connection is restored.',
    },
    {
      'category': 'Quizzes & Grading',
      'question': 'How do instructor assignments and rubrics work?',
      'answer':
          'Instructors publish weekly assignments under the Assignments tab with clear submittal deadlines, rubrics, and point weightings. Submitted work is reviewed by faculty, and grades are posted to your diagnostic dashboard.',
    },

    // Certifications & ATS Resume — 5
    {
      'category': 'Certifications & ATS Resume',
      'question': 'What are Polygon Blockchain Verifiable Certificates?',
      'answer':
          'Every course completion diploma issued by NextGen LMS is cryptographically hashed and anchored onto the Polygon Proof-of-Stake (POS) blockchain. This provides 100% tamper-proof, W3C-compliant academic credentials.',
    },
    {
      'category': 'Certifications & ATS Resume',
      'question': 'How can recruiters verify my Polygon certificate?',
      'answer':
          'Each certificate features a unique Polygon Transaction Hash (TxHash) and verification link. Recruiters or employers can click "Verify On-Chain" or inspect the TxHash on the Polygon block explorer to confirm authenticity.',
    },
    {
      'category': 'Certifications & ATS Resume',
      'question': 'How does the 100% ATS-Friendly Resume Builder work?',
      'answer':
          'The ATS Resume Builder automatically pulls your verified Polygon certificates, skill assessment grades, and projects, formatting them into a single-column Workday/Taleo-optimized layout engineered for 100% parser selection.',
    },
    {
      'category': 'Certifications & ATS Resume',
      'question': 'Can I add external internships, projects, and contact details to my resume?',
      'answer':
          'Yes! The Section Editor lets you add external work experience, off-campus projects, custom technical skill categories (e.g. Docker, PyTorch), address, phone number, and portfolio links.',
    },
    {
      'category': 'Certifications & ATS Resume',
      'question': 'How do I export or share my ATS resume?',
      'answer':
          'You can copy raw plain-text for job portals, print or save a clean PDF document, or click "Send to Placement Cell" to dispatch your resume directly to campus placement officers.',
    },

    // Account & Support — 3
    {
      'category': 'Account & Support',
      'question': 'How do I view my payment history or upgrade my plan?',
      'answer':
          'Navigate to the Payment & Transactions tab in the sidebar to view billing receipts, download transaction invoices, or upgrade your account between Monthly Pro and Yearly Expert tiers.',
    },
    {
      'category': 'Account & Support',
      'question': 'How do I submit a helpdesk support ticket?',
      'answer':
          'Under the FAQs & Support tab, click "Open New Ticket Form", enter your subject and issue details (e.g. sandbox error or account question), and submit. Our support team responds within 24 hours.',
    },
    {
      'category': 'Account & Support',
      'question': 'Where can I view my overall CGPA, skill breakdown, and peer rank?',
      'answer':
          'Go to the Reports & Skill Analytics tab in the sidebar to view your radar skill chart, diagnostic scores across core engineering concepts, attendance records, and overall class rank.',
    },
  ];

  List<String> get categories => const [
        'All',
        'General & Platform',
        'AI Tutor & Code IDE',
        'Courses & Sandboxes',
        'Quizzes & Grading',
        'Certifications & ATS Resume',
        'Account & Support',
      ];

  List<Map<String, String>> get filteredFaqs {
    final q = _searchController.text.trim().toLowerCase();

    return faqs.where((item) {
      final categoryMatch =
          selectedCategory == 'All' || item['category'] == selectedCategory;
      final searchMatch = q.isEmpty ||
          item['question']!.toLowerCase().contains(q) ||
          item['answer']!.toLowerCase().contains(q) ||
          item['category']!.toLowerCase().contains(q);
      return categoryMatch && searchMatch;
    }).toList();
  }

  int countFor(String category) {
    if (category == 'All') return faqs.length;
    return faqs.where((f) => f['category'] == category).length;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Color get bg =>
      widget.isDarkMode ? const Color(0xFF0F121A) : const Color(0xFFF4F6FB);
  Color get card =>
      widget.isDarkMode ? const Color(0xFF1B1E27) : Colors.white;
  Color get primary =>
      widget.isDarkMode ? Colors.white : const Color(0xFF111827);
  Color get secondary =>
      widget.isDarkMode ? const Color(0xFF9CA3AF) : const Color(0xFF667085);
  Color get border =>
      widget.isDarkMode ? const Color(0xFF2A2F3A) : const Color(0xFFE4E8F0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(34, 38, 34, 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(),
            const SizedBox(height: 26),
            _tabs(),
            const SizedBox(height: 28),
            if (activeTab == 'faqs') _faqBody(),
            if (activeTab == 'tickets') _ticketsBody(),
            if (activeTab == 'new_ticket') _newTicketBody(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HELPDESK SANDBOX',
          style: TextStyle(
            color: secondary,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'FAQs & Support Tickets',
          style: TextStyle(
            color: primary,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _tabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _tab('Accordion FAQ Answers', 'faqs'),
          const SizedBox(width: 28),
          _tab('My Support Tickets', 'tickets'),
          const SizedBox(width: 28),
          _tab('Open New Ticket Form', 'new_ticket'),
        ],
      ),
    );
  }

  Widget _tab(String title, String id) {
    final selected = activeTab == id;
    return InkWell(
      onTap: () => setState(() {
        activeTab = id;
        expandedIndex = null;
      }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: selected ? accent : secondary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 11),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 3,
              width: selected ? 188 : 0,
              color: blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqBody() {
    final list = filteredFaqs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _searchAndFilters(),
        const SizedBox(height: 26),
        if (list.isEmpty)
          _emptySearch()
        else
          ...list.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _faqCard(entry.key, entry.value, list),
                ),
              ),
        const SizedBox(height: 12),
        _supportCta(),
      ],
    );
  }

  Widget _searchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: const [
          BoxShadow(
            blurRadius: 9,
            offset: Offset(0, 3),
            color: Color(0x09000000),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() => expandedIndex = null),
            style: TextStyle(color: primary, fontSize: 13),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: secondary),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: Icon(Icons.close, color: secondary, size: 18),
                    ),
              hintText:
                  'Search FAQs (e.g. Gemini AI, Polygon certificate, ATS resume, quizzes, billing)...',
              hintStyle: TextStyle(color: secondary, fontSize: 12),
              filled: true,
              fillColor: widget.isDarkMode
                  ? const Color(0xFF14161D)
                  : const Color(0xFFF8FAFC),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(color: accent),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = selectedCategory == category;
                return InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () => setState(() {
                    selectedCategory = category;
                    expandedIndex = null;
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? accent
                          : (widget.isDarkMode
                              ? const Color(0xFF272B35)
                              : const Color(0xFFF0F2F6)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        if (index == 0) ...[
                          Icon(
                            Icons.filter_alt_outlined,
                            size: 13,
                            color: selected ? Colors.white : secondary,
                          ),
                          const SizedBox(width: 5),
                        ],
                        Text(
                          category,
                          style: TextStyle(
                            color: selected ? Colors.white : primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.white.withValues(alpha: .18)
                                : (widget.isDarkMode
                                    ? const Color(0xFF3A404D)
                                    : const Color(0xFFE0E4EA)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${countFor(category)}',
                            style: TextStyle(
                              color: selected ? Colors.white : secondary,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _faqCard(
    int index,
    Map<String, String> item,
    List<Map<String, String>> list,
  ) {
    final expanded = expandedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: expanded ? const Color(0x553B82F6) : border,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 7,
            offset: Offset(0, 2),
            color: Color(0x07000000),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(19),
        onTap: () => setState(() {
          expandedIndex = expanded ? null : index;
        }),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 20, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item['category']!.toUpperCase(),
                      style: const TextStyle(
                        color: accent,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .8,
                      ),
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: expanded ? .5 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: secondary,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Text(
                item['question']!,
                style: TextStyle(
                  color: primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  height: 1.35,
                ),
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 180),
                crossFadeState: expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: widget.isDarkMode
                          ? const Color(0xFF141821)
                          : const Color(0xFFF7F9FC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item['answer']!,
                      style: TextStyle(
                        color: secondary,
                        fontSize: 12.5,
                        height: 1.65,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptySearch() {
    return Container(
      padding: const EdgeInsets.all(45),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Icon(Icons.search_off_outlined, size: 40, color: secondary),
          const SizedBox(height: 12),
          Text(
            'No FAQs found',
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Try another search term or select All categories.',
            style: TextStyle(color: secondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _ticketsBody() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'My Support Tickets',
                  style: TextStyle(
                    color: primary,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _smallAction(
                'Open New Ticket',
                Icons.add,
                orange,
                () => setState(() => activeTab = 'new_ticket'),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            'Track questions and helpdesk requests submitted from your account.',
            style: TextStyle(color: secondary, fontSize: 12),
          ),
          const SizedBox(height: 22),
          ...tickets.map(
            (t) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? const Color(0xFF151923)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: blue.withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(
                      Icons.confirmation_number_outlined,
                      color: blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['subject']!,
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${t['id']}  •  ${t['date']}',
                          style: TextStyle(color: secondary, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  _status(t['status']!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _newTicketBody() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 720),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Open New Support Ticket',
            style: TextStyle(
              color: primary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Describe your issue clearly so the support team can resolve it quickly.',
            style: TextStyle(color: secondary, fontSize: 12),
          ),
          const SizedBox(height: 24),
          _label('Subject Matter'),
          const SizedBox(height: 6),
          _input(
            controller: _subjectController,
            hint: 'e.g. Sandbox Docker container failed to launch',
          ),
          const SizedBox(height: 17),
          _label('Description Details'),
          const SizedBox(height: 6),
          TextField(
            controller: _descriptionController,
            maxLines: 6,
            style: TextStyle(color: primary, fontSize: 12),
            decoration: _inputDecoration(
              'Explain the issue, error message, or account question...',
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: _submitTicket,
              icon: const Icon(Icons.send_outlined, size: 17),
              label: const Text('Submit Helpdesk Ticket'),
              style: FilledButton.styleFrom(
                backgroundColor: orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String value) => Text(
        value,
        style: TextStyle(
          color: primary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _input({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: primary, fontSize: 12),
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: secondary, fontSize: 11),
      filled: true,
      fillColor:
          widget.isDarkMode ? const Color(0xFF14161D) : const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: accent),
      ),
    );
  }

  Widget _smallAction(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 15),
      label: Text(title),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: .25)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _status(String status) {
    final resolved = status.toLowerCase() == 'resolved' ||
        status.toLowerCase() == 'closed';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: (resolved ? const Color(0xFF00A878) : orange)
            .withValues(alpha: .10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: resolved ? const Color(0xFF00A878) : orange,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _supportCta() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 21, 22, 21),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF202532)
            : const Color(0xFF242938),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '✣  Need tailored support or sandbox help?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "If your query isn't answered in the FAQs, our support team is available 24/7 to help.",
                  style: TextStyle(
                    color: Color(0xFFB9C0CF),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          FilledButton(
            onPressed: () => setState(() => activeTab = 'new_ticket'),
            style: FilledButton.styleFrom(
              backgroundColor: orange,
              padding: const EdgeInsets.symmetric(
                horizontal: 19,
                vertical: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Text(
              'Open Support Ticket',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitTicket() {
    if (_subjectController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both subject and description.'),
        ),
      );
      return;
    }

    setState(() {
      tickets.insert(0, {
        'id': 'TCK-${55 + tickets.length}',
        'subject': _subjectController.text.trim(),
        'date': 'Today',
        'status': 'Open',
      });
      _subjectController.clear();
      _descriptionController.clear();
      activeTab = 'tickets';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Support ticket submitted successfully.'),
      ),
    );
  }
}
