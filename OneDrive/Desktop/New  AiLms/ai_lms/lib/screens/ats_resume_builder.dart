import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Next Gen LMS — ATS Resume Builder
///
/// Content-only screen.
/// Do NOT create another StudentLmsShell/sidebar here.
/// StudentHomeHub/StudentLmsShell should open this page for sidebar index 13.
class AtsResumeBuilderScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;

  const AtsResumeBuilderScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
  });

  @override
  State<AtsResumeBuilderScreen> createState() => _AtsResumeBuilderScreenState();
}

class _AtsResumeBuilderScreenState extends State<AtsResumeBuilderScreen> {
  static const orange = Color(0xFFFF6B2C);
  static const green = Color(0xFF00A878);
  static const navy = Color(0xFF111936);
  static const purple = Color(0xFF7C3AED);

  bool showEditor = false;
  bool atsOptimized = true;

  final _name = TextEditingController(text: 'ABHIJEET SAHU');
  final _phone = TextEditingController(text: '+91 98765 43210');
  final _email =
      TextEditingController(text: 'abhijeetsahu7978@gmail.com');
  final _location = TextEditingController(text: 'Bhubaneswar, Odisha, India');
  final _linkedin =
      TextEditingController(text: 'linkedin.com/in/abhijeet-sahu-tech');
  final _github = TextEditingController(text: 'github.com/abhijeet-sahu');
  final _portfolio =
      TextEditingController(text: 'abhijeet-sahu-portfolio.dev');
  final _college =
      TextEditingController(text: 'NextGen Institute of Technology');
  final _degree =
      TextEditingController(text: 'Bachelor of Technology (B.Tech)');
  final _cgpa = TextEditingController(text: '9.4 / 10.0');

  final _summary = TextEditingController(
    text:
        'High-performing Computer Science Engineer specializing in Full-Stack AI Application Development, Distributed Node.js Microservices, and React 18 Concurrent Architectures. Proven track record with 98.5% assessment mastery in Gemini API integrations and Polygon Blockchain credential verification systems.',
  );

  final Map<String, List<String>> skills = {
    'LANGUAGES & FRAMEWORKS': [
      'React 18',
      'TypeScript',
      'JavaScript (ES6+)',
      'Node.js',
      'Express',
      'HTML5',
      'CSS3',
      'Tailwind CSS',
      'REST APIs',
    ],
    'AI & LLM TECHNOLOGIES': [
      'Google Gemini 1.5 Pro/Flash SDK',
      'Function Calling',
      'Prompt Engineering',
      'Structured JSON Outputs',
      'Vector Search',
    ],
    'DATABASES & INFRASTRUCTURE': [
      'PostgreSQL',
      'Drizzle ORM',
      'Polygon POS Blockchain',
      'Docker',
      'Git/GitHub',
      'Vite esbuild',
    ],
  };

  final List<Map<String, dynamic>> internships = [
    {
      'role': 'Full-Stack AI Development Intern',
      'company': 'NextGen Innovation Labs',
      'duration': 'May 2026 - Present',
      'location': 'Remote / Hybrid',
      'bullets': [
        'Architected scalable Express microservices handling 10,000+ daily requests with <80ms response times.',
        'Integrated Google Gemini 1.5 Pro/Flash SDK with structured JSON schemas, boosting response accuracy by 35%.',
        'Engineered responsive React 18 interfaces with Tailwind CSS and Zustand state containers.',
      ],
    },
  ];

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'NextGen Cloud LMS & AI Learning Platform',
      'link': 'github.com/abhijeet-sahu/nextgen-lms',
      'tech':
          'React 18, TypeScript, Node.js, Gemini API, Tailwind CSS, Polygon Blockchain',
      'bullets': [
        'Engineered an end-to-end LMS portal featuring real-time AI tutoring, video streaming, and automated exam proctoring.',
        'Implemented W3C Verifiable Credentials backed by Polygon POS smart contracts for counterfeit-proof diploma issuing.',
        'Reduced client bundle sizes by 42% using lazy-loaded dynamic imports and Vite esbuild bundling.',
      ],
    },
    {
      'title': 'Distributed Microservices & Vector Search Engine',
      'link': 'github.com/abhijeet-sahu/distributed-vector-engine',
      'tech': 'Node.js, PostgreSQL, Drizzle ORM, Docker, Express',
      'bullets': [
        'Built high-concurrency vector similarity search API pipelines for real-time document semantic retrieval.',
        'Designed strict PostgreSQL database schemas with automated Drizzle migrations and ACID transaction safeguards.',
      ],
    },
  ];

  final List<Map<String, String>> certifications = [
    {
      'title': 'Master of Advanced Full-Stack AI Engineering',
      'org': 'Google AI Studio & NextGen University',
      'date': 'June 2026',
      'grade': 'A+ Distinction (98.5%)',
      'hash': '0x8f2a...9be412',
    },
    {
      'title': 'Blockchain Verifiable Credentials Specialist',
      'org': 'Polygon POS Developer Academy',
      'date': 'May 2026',
      'grade': 'High Honors (96.0%)',
      'hash': '0x3c1d...7a89ff',
    },
  ];

  @override
  void dispose() {
    for (final c in [
      _name,
      _phone,
      _email,
      _location,
      _linkedin,
      _github,
      _portfolio,
      _college,
      _degree,
      _cgpa,
      _summary,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Color get pageBg => widget.isDarkMode
      ? const Color(0xFF0B1020)
      : const Color(0xFFF4F6FB);

  Color get cardBg =>
      widget.isDarkMode ? const Color(0xFF131A2B) : Colors.white;

  Color get text =>
      widget.isDarkMode ? Colors.white : const Color(0xFF101828);

  Color get muted =>
      widget.isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF667085);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pageBg,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(34, 34, 34, 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _hero(),
            const SizedBox(height: 28),
            _actionBar(),
            const SizedBox(height: 26),
            if (showEditor) _editor() else _resumePreview(),
          ],
        ),
      ),
    );
  }

  Widget _hero() {
    return Container(
      padding: const EdgeInsets.fromLTRB(38, 34, 38, 34),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF11152F), Color(0xFF29275F)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            blurRadius: 24,
            offset: Offset(0, 12),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _badge('✣  100% ATS-OPTIMIZED RESUME GENERATOR'),
                const SizedBox(height: 14),
                Text(
                  'AI ATS Resume Builder & Career Launchpad',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Build a 100% ATS-friendly resume formatted for Workday, Taleo, & Greenhouse. Add custom skills, external certifications, projects, internships, and updated contact info.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFE0E5F5),
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Column(
            children: [
              Container(
                width: 120,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0x331B2448),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: const Color(0x556B7395)),
                ),
                child: Column(
                  children: [
                    Text(
                      atsOptimized ? '100/100' : '92/100',
                      style: GoogleFonts.jetBrainsMono(
                        color: const Color(0xFF00D7A0),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ATS SCORE',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _heroButton(
                    showEditor ? 'Live Resume' : 'Live Resume',
                    Icons.visibility_outlined,
                    () => setState(() => showEditor = false),
                    !showEditor,
                  ),
                  const SizedBox(width: 8),
                  _heroButton(
                    'Section Editor',
                    Icons.tune,
                    () => setState(() => showEditor = true),
                    showEditor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0x332B253E),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0x66FFB15C)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          color: const Color(0xFFFFC34D),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: .5,
        ),
      ),
    );
  }

  Widget _heroButton(
    String label,
    IconData icon,
    VoidCallback onTap,
    bool selected,
  ) {
    return Material(
      color: selected ? orange : const Color(0x223A456D),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 15),
              const SizedBox(width: 7),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF263149)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: green, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Format: ATS Standard Single-Column (Clean Parsing Guaranteed)',
              style: GoogleFonts.inter(
                color: text,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          _actionButton(
            'Copy Raw ATS Text',
            Icons.copy_outlined,
            purple,
            () => _snack('ATS resume text copied.'),
          ),
          const SizedBox(width: 9),
          _actionButton(
            'Send to Placement Cell',
            Icons.send_outlined,
            const Color(0xFF2879FF),
            () => _snack('Resume sent to Placement Cell.'),
          ),
          const SizedBox(width: 9),
          _actionButton(
            'Print / Download PDF',
            Icons.print_outlined,
            orange,
            () => _snack('PDF export action is ready to connect.'),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 15),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: .18)),
        backgroundColor: color.withValues(alpha: .06),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _resumePreview() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      margin: const EdgeInsets.symmetric(horizontal: 150),
      padding: const EdgeInsets.fromLTRB(52, 48, 52, 52),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 22,
            offset: Offset(0, 8),
            color: Color(0x18000000),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: GoogleFonts.inter(
          color: const Color(0xFF18202F),
          fontSize: 12,
          height: 1.55,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    _name.text,
                    style: GoogleFonts.merriweather(
                      color: const Color(0xFF111827),
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${_location.text}   •   Phone: ${_phone.text}   •   Email: ${_email.text}',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'LinkedIn: ${_linkedin.text}   •   GitHub: ${_github.text}   •   Portfolio: ${_portfolio.text}',
                    style: GoogleFonts.jetBrainsMono(
                      color: const Color(0xFF526071),
                      fontSize: 9.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _resumeLine(),
            _resumeSection(
              'PROFESSIONAL SUMMARY',
              Text(_summary.text),
            ),
            _resumeSection(
              'TECHNICAL SKILLS & COMPETENCIES',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: skills.entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: '${e.key[0]}${e.key.substring(1).toLowerCase()}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: e.value.join(', ')),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            _resumeSection(
              'WORK & INTERNSHIP EXPERIENCE',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: internships.map(_previewInternship).toList(),
              ),
            ),
            _resumeSection(
              'PROJECT EXPERIENCE',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: projects.map(_previewProject).toList(),
              ),
            ),
            _resumeSection(
              'CERTIFICATIONS & ACCREDITATIONS',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: certifications.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${c['title']}   [Polygon Verifiable]',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${c['org']} • Issued: ${c['date']} • Grade: ${c['grade']}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 3),
                          padding: const EdgeInsets.all(5),
                          color: const Color(0xFFF1F5F9),
                          child: Text(
                            'Polygon POS TxHash: ${c['hash']}',
                            style: GoogleFonts.jetBrainsMono(fontSize: 9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ),
            _resumeSection(
              'EDUCATION',
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _college.text,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(_degree.text),
                    ],
                  ),
                  Text(
                    'Cumulative GPA: ${_cgpa.text}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resumeLine() => Container(
        height: 1.5,
        color: const Color(0xFF111827),
        margin: const EdgeInsets.only(bottom: 17),
      );

  Widget _resumeSection(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.merriweather(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 6),
          Container(height: 1, color: const Color(0xFFD5DCE5)),
          const SizedBox(height: 9),
          child,
        ],
      ),
    );
  }

  Widget _previewInternship(Map<String, dynamic> e) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${e['role']} | ${e['company']}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${e['duration']}   (${e['location']})'),
          ...List<String>.from(e['bullets']).map(
            (b) => Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('•  $b'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewProject(Map<String, dynamic> e) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  e['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                e['link'],
                style: const TextStyle(color: Color(0xFF475569)),
              ),
            ],
          ),
          Text(
            'Technologies: ${e['tech']}',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          ...List<String>.from(e['bullets']).map(
            (b) => Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('•  $b'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editor() {
    return Container(
      padding: const EdgeInsets.fromLTRB(36, 32, 36, 42),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF263149)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _editorTitle(
            Icons.tune,
            'Full ATS Resume Section Editor',
            'Customize contact info, add custom skills, extra certifications, internships, or external projects.',
          ),
          const SizedBox(height: 28),
          _sectionTitle(
            Icons.location_on_outlined,
            '1. PERSONAL & CONTACT INFORMATION (ADDRESS, PHONE, LINKS)',
          ),
          const SizedBox(height: 15),
          _fieldGrid([
            _field('Full Name *', _name),
            _field('Mobile / Phone Number *', _phone),
            _field('Email Address *', _email),
            _field('Address / Location *', _location),
            _field('LinkedIn Profile URL', _linkedin),
            _field('GitHub Profile URL', _github),
            _field('Portfolio Link', _portfolio),
            _field('University / College', _college),
            _field('Degree & CGPA', _degree),
            _field('', _cgpa),
          ]),
          const SizedBox(height: 30),
          _sectionTitle(Icons.notes_outlined, '2. PROFESSIONAL SUMMARY'),
          const SizedBox(height: 12),
          _largeField(_summary),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _snack('AI optimization completed.'),
              icon: const Icon(Icons.auto_awesome, color: purple),
              label: const Text('1-Click AI Optimize'),
            ),
          ),
          const SizedBox(height: 12),
          _sectionTitle(
            Icons.code_outlined,
            '3. TECHNICAL SKILLS & COMPETENCIES MANAGER',
          ),
          const SizedBox(height: 14),
          ...skills.keys.map(_skillCategory),
          const SizedBox(height: 28),
          _sectionTitle(
            Icons.business_center_outlined,
            '4. WORK EXPERIENCE & INTERNSHIPS',
          ),
          const SizedBox(height: 14),
          ...internships.asMap().entries.map(
            (e) => _internshipEditor(e.key, e.value),
          ),
          const SizedBox(height: 12),
          _orangeAction(
            'Add Internship / Work Experience',
            Icons.add_circle_outline,
            () => _addInternship(),
          ),
          const SizedBox(height: 30),
          _sectionTitle(
            Icons.code,
            '5. PERSONAL & EXTERNAL TECHNICAL PROJECTS',
          ),
          const SizedBox(height: 14),
          ...projects.asMap().entries.map(
            (e) => _projectEditor(e.key, e.value),
          ),
          const SizedBox(height: 12),
          _orangeAction(
            'Add Custom Project',
            Icons.add_circle_outline,
            () => _addProject(),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: _sectionTitle(
                  Icons.workspace_premium_outlined,
                  '6. CERTIFICATIONS & ACCREDITATIONS (BLOCKCHAIN + CUSTOM)',
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (_) {},
                    activeColor: orange,
                  ),
                  Text(
                    'Include Polygon TxHashes',
                    style: TextStyle(color: muted, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...certifications.asMap().entries.map(
            (e) => _certEditor(e.key, e.value),
          ),
          const SizedBox(height: 12),
          _orangeAction(
            'Add External Certification',
            Icons.add_circle_outline,
            () => _addCertification(),
          ),
          const SizedBox(height: 34),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () => setState(() {
                atsOptimized = true;
                showEditor = false;
              }),
              icon: const Icon(Icons.check),
              label: const Text('Save Resume & View Live Resume'),
              style: FilledButton.styleFrom(
                backgroundColor: green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
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

  Widget _editorTitle(IconData icon, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: orange),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.inter(
                color: text,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: TextStyle(color: muted)),
      ],
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: orange, size: 19),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: text,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: .2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _fieldGrid(List<Widget> fields) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final two = constraints.maxWidth >= 850;
        if (!two) {
          return Column(
            children: fields
                .map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: f,
                  ),
                )
                .toList(),
          );
        }
        return Wrap(
          spacing: 16,
          runSpacing: 12,
          children: fields.map(
            (f) => SizedBox(
              width: (constraints.maxWidth - 16) / 2,
              child: f,
            ),
          ).toList(),
        );
      },
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyle(
              color: muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
          onChanged: (_) => setState(() {}),
          style: TextStyle(color: text, fontSize: 12),
          decoration: _inputDecoration(),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() => InputDecoration(
        filled: true,
        fillColor: widget.isDarkMode
            ? const Color(0xFF0F1626)
            : const Color(0xFFF9FAFB),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(
            color: widget.isDarkMode
                ? const Color(0xFF2A354B)
                : const Color(0xFFDDE3EA),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(
            color: widget.isDarkMode
                ? const Color(0xFF2A354B)
                : const Color(0xFFDDE3EA),
          ),
        ),
      );

  Widget _largeField(TextEditingController controller) => TextField(
        controller: controller,
        maxLines: 4,
        onChanged: (_) => setState(() {}),
        style: TextStyle(color: text, fontSize: 12, height: 1.5),
        decoration: _inputDecoration(),
      );

  Widget _skillCategory(String name) {
    final add = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.fromLTRB(18, 17, 18, 17),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF101827)
            : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF28354B)
              : const Color(0xFFE1E6ED),
        ),
      ),
      child: StatefulBuilder(
        builder: (context, localSet) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: text,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      skills.remove(name);
                    });
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 16),
                  label: const Text(
                    'Delete Category',
                    style: TextStyle(color: Colors.red, fontSize: 11),
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: skills[name]!
                  .map(
                    (skill) => InputChip(
                      label: Text(skill),
                      onDeleted: () => setState(() => skills[name]!.remove(skill)),
                      backgroundColor: cardBg,
                      side: BorderSide(
                        color: widget.isDarkMode
                            ? const Color(0xFF334155)
                            : const Color(0xFFDCE2EA),
                      ),
                      labelStyle: TextStyle(
                        color: text,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: add,
                    style: TextStyle(color: text, fontSize: 12),
                    decoration: _inputDecoration().copyWith(
                      hintText: 'Add skill to $name (e.g. Docker, PyTorch)',
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                FilledButton(
                  onPressed: () {
                    if (add.text.trim().isEmpty) return;
                    setState(() {
                      skills[name]!.add(add.text.trim());
                      add.clear();
                    });
                    localSet(() {});
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: navy,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 14,
                    ),
                  ),
                  child: const Text('Add Skill'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _internshipEditor(int index, Map<String, dynamic> e) {
    return _outlinedPanel(
      const Color(0xFFFFD6BF),
      'ADD EXTERNAL INTERNSHIP / ROLE DETAILS',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldGrid([
            _fieldValue('Role Title *', e['role'], (v) => e['role'] = v),
            _fieldValue('Company / Org *', e['company'], (v) => e['company'] = v),
            _fieldValue('Duration', e['duration'], (v) => e['duration'] = v),
            _fieldValue('Location', e['location'], (v) => e['location'] = v),
          ]),
          const SizedBox(height: 12),
          _bulletList(e['bullets']),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _snack('Internship entry saved.'),
            icon: const Icon(Icons.check, size: 16),
            label: const Text('Save Internship Entry'),
            style: FilledButton.styleFrom(backgroundColor: green),
          ),
        ],
      ),
    );
  }

  Widget _projectEditor(int index, Map<String, dynamic> e) {
    return _outlinedPanel(
      const Color(0xFFC7C7FF),
      'ADD CUSTOM TECHNICAL PROJECT',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldGrid([
            _fieldValue('Project Title *', e['title'], (v) => e['title'] = v),
            _fieldValue('Technologies Used', e['tech'], (v) => e['tech'] = v),
            _fieldValue('GitHub / Demo Link', e['link'], (v) => e['link'] = v),
          ]),
          const SizedBox(height: 12),
          _bulletList(e['bullets']),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _snack('Project entry saved.'),
            icon: const Icon(Icons.check, size: 16),
            label: const Text('Save Project Entry'),
            style: FilledButton.styleFrom(backgroundColor: green),
          ),
        ],
      ),
    );
  }

  Widget _certEditor(int index, Map<String, String> e) {
    return _outlinedPanel(
      const Color(0xFFA7E7D4),
      'ADD CUSTOM / EXTERNAL CERTIFICATION',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldGrid([
            _fieldValue('Certification Title *', e['title']!, (v) => e['title'] = v),
            _fieldValue('Issuing Organization *', e['org']!, (v) => e['org'] = v),
            _fieldValue('Issue Date', e['date']!, (v) => e['date'] = v),
            _fieldValue('Grade / Score / Status', e['grade']!, (v) => e['grade'] = v),
            _fieldValue('Polygon TxHash (Optional)', e['hash']!, (v) => e['hash'] = v),
          ]),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _snack('Certification saved.'),
            icon: const Icon(Icons.check, size: 16),
            label: const Text('Save Certification'),
            style: FilledButton.styleFrom(backgroundColor: green),
          ),
        ],
      ),
    );
  }

  Widget _fieldValue(
    String label,
    String value,
    ValueChanged<String> onChanged,
  ) {
    final c = TextEditingController(text: value);
    return StatefulBuilder(
      builder: (context, localSet) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: muted, fontSize: 11)),
          const SizedBox(height: 6),
          TextField(
            controller: c,
            onChanged: onChanged,
            style: TextStyle(color: text, fontSize: 12),
            decoration: _inputDecoration(),
          ),
        ],
      ),
    );
  }

  Widget _bulletList(List<String> bullets) {
    return Column(
      children: bullets
          .asMap()
          .entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: e.value,
                      onChanged: (v) => bullets[e.key] = v,
                      style: TextStyle(color: text, fontSize: 12),
                      decoration: _inputDecoration().copyWith(
                        hintText: 'Bullet ${e.key + 1}: describe impact or achievement',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => bullets.removeAt(e.key)),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _outlinedPanel(Color borderColor, String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: borderColor.withValues(alpha: .07),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '+  $title',
            style: TextStyle(
              color: text,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _orangeAction(String title, IconData icon, VoidCallback onTap) {
    return Align(
      alignment: Alignment.centerRight,
      child: FilledButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 17),
        label: Text(title),
        style: FilledButton.styleFrom(
          backgroundColor: orange,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      ),
    );
  }

  void _addInternship() {
    setState(() {
      internships.add({
        'role': '',
        'company': '',
        'duration': '',
        'location': 'Remote',
        'bullets': [''],
      });
    });
  }

  void _addProject() {
    setState(() {
      projects.add({
        'title': '',
        'link': '',
        'tech': '',
        'bullets': [''],
      });
    });
  }

  void _addCertification() {
    setState(() {
      certifications.add({
        'title': '',
        'org': '',
        'date': '',
        'grade': '',
        'hash': '',
      });
    });
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
