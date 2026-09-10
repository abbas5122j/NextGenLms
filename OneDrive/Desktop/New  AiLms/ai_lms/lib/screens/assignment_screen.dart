
import 'package:flutter/material.dart';

/// Next Gen LMS — Student Assignment Section.
///
/// This is a content-only screen and is intended to live inside the
/// existing StudentLmsShell. It does not create another sidebar/top bar.
class AssignmentScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;

  const AssignmentScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
  });

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  String _search = '';
  String _branch = 'All Branches';
  AssignmentItem? _selected;
  _AssignmentView _view = _AssignmentView.list;
  final TextEditingController _submissionController = TextEditingController();

  static const List<String> _branches = [
    'All Branches',
    'Computer Science & Engineering',
    'Information Technology',
    'Electronics & Communication Engineering',
    'Electrical & Electronics Engineering',
    'Mechanical Engineering',
    'Civil Engineering',
    'Chemical Engineering',
    'Aerospace Engineering',
  ];

  static const List<AssignmentItem> _assignments = [
    AssignmentItem(
      id: 'assign-cse-1',
      title: 'Mid-Term: Asynchronous Event Loop & Concurrency Engine',
      instructor: 'Instructor Kumar',
      instructorRole: 'Lead Systems & Distributed Computing Instructor',
      courseId: 'python',
      courseTitle: 'Python for Data Science, Machine Learning & AI',
      branch: 'Computer Science & Engineering',
      dueDate: 'August 02, 2026',
      totalPoints: 100,
      status: 'Active',
      type: 'Source Code Submittal (.py / GitHub)',
      description:
          'Design and implement a non-blocking asynchronous event loop that schedules 50 concurrent network worker threads using Python AsyncIO without raising GIL deadlock locks.',
      instructions: [
        "Use python's native asyncio and aiohttp libraries.",
        'Ensure thread safety when updating global task queues.',
        'Include unit test coverage verifying <5ms worker dispatch latency.',
        'Provide clean terminal output logs with timestamps.',
      ],
      submissionFormat:
          'Python code snippet or public GitHub repository link.',
    ),
    AssignmentItem(
      id: 'assign-cse-2',
      title: 'Project Milestone: Scaled React 18 Design System & State Architecture',
      instructor: 'Dr. Ramesh Patel',
      instructorRole: 'Professor & HOD, Computer Science',
      courseId: 'web-dev',
      courseTitle: 'Modern Web Development with React 18 & Vite',
      branch: 'Computer Science & Engineering',
      dueDate: 'August 08, 2026',
      totalPoints: 150,
      status: 'Active',
      type: 'React / Vite Workspace Code',
      description:
          'Build a responsive modular frontend interface integrating custom Tailwind CSS design systems, dark mode toggles, and zero re-render state hooks.',
      instructions: [
        'Implement memoized callbacks and Context API for global state.',
        'Ensure WCAG AA contrast compliance for light & dark themes.',
        'Construct responsive layout grid views for mobile & desktop.',
        'Avoid third-party UI libraries for core layout cards.',
      ],
      submissionFormat: 'Compressed zip file or Git commit link.',
    ),
    AssignmentItem(
      id: 'assign-it-1',
      title: 'Lab Assignment: Penetration Testing & TLS Handshake Auditing',
      instructor: 'Prof. Amanda Clark',
      instructorRole: 'Associate Professor, Cyber Security & IT',
      courseId: 'cyber',
      courseTitle: 'Cyber Security, Ethical Hacking & Cryptography',
      branch: 'Information Technology',
      dueDate: 'August 12, 2026',
      totalPoints: 100,
      status: 'Active',
      type: 'Wireshark Audit & PDF Security Report',
      description:
          'Perform packet capture analysis on simulated TLS 1.3 handshakes, identify cipher suite vulnerabilities, and write a mitigation report.',
      instructions: [
        'Capture PCAP files during simulated client-server handshakes.',
        'Identify RSA key exchange vs ECDHE forward secrecy parameters.',
        'Detail 3 actionable hardening recommendations for server configs.',
        'Include annotated screenshot evidence from Wireshark.',
      ],
      submissionFormat: 'PDF Security Audit Document.',
    ),
    AssignmentItem(
      id: 'assign-it-2',
      title: 'Architecture Task: Distributed PostgreSQL Query Optimization',
      instructor: 'Prof. Amanda Clark',
      instructorRole: 'Associate Professor, Cyber Security & IT',
      courseId: 'dbms',
      courseTitle: 'Database Systems & Distributed Query Architecture',
      branch: 'Information Technology',
      dueDate: 'August 18, 2026',
      totalPoints: 120,
      status: 'Upcoming',
      type: 'SQL Scripts & EXPLAIN ANALYZE Logs',
      description:
          'Optimize an unindexed 10-million row database table query from 3,400ms down to <15ms using B-Tree indexes and materialized views.',
      instructions: [
        'Write DDL scripts to create targeted composite indexes.',
        'Submit before/after EXPLAIN ANALYZE query execution trees.',
        'Explain the cost savings in disk I/O reads.',
      ],
      submissionFormat: 'SQL Script (.sql) and EXPLAIN query output text.',
    ),
    AssignmentItem(
      id: 'assign-ece-1',
      title: 'Hardware Lab: Embedded ESP32 Wi-Fi Sensor Telemetry Node',
      instructor: 'Dr. Ananya Roy',
      instructorRole: 'Assistant Professor, Embedded Systems & Microcontrollers',
      courseId: 'iot',
      courseTitle: 'Embedded Systems & IoT Sensor Networks',
      branch: 'Electronics & Communication Engineering',
      dueDate: 'August 05, 2026',
      totalPoints: 100,
      status: 'Active',
      type: 'C++ / FreeRTOS Firmware & Circuit Schematic',
      description:
          'Write C++ firmware for an ESP32 microcontroller that reads I2C temperature/pressure sensors and transmits telemetry over MQTT.',
      instructions: [
        'Use FreeRTOS task queues to separate sensor reading from Wi-Fi transmission.',
        'Configure deep sleep power modes between telemetry bursts.',
        'Upload Fritzing or KiCAD circuit schematic diagram.',
      ],
      submissionFormat: 'C++ Firmware source file (.cpp) & schematic PDF.',
    ),
    AssignmentItem(
      id: 'assign-ece-2',
      title: 'VLSI Synthesis: 8-bit Pipelined ALU in Verilog HDL',
      instructor: 'Dr. Ananya Roy',
      instructorRole: 'Assistant Professor, Embedded Systems & Microcontrollers',
      courseId: 'vlsi',
      courseTitle: 'VLSI Design, CMOS & Verilog HDL Simulation',
      branch: 'Electronics & Communication Engineering',
      dueDate: 'August 22, 2026',
      totalPoints: 150,
      status: 'Upcoming',
      type: 'Verilog Code & Testbench Simulation Waveforms',
      description:
          'Design a 4-stage pipelined Arithmetic Logic Unit supporting Addition, Bitwise AND/OR, and Multiplication in structural Verilog.',
      instructions: [
        'Write non-blocking <= assignments in sequential always blocks.',
        'Provide a comprehensive testbench covering 100% of opcodes.',
        'Include GTKWave timing diagrams showing pipeline throughput.',
      ],
      submissionFormat: 'Verilog code files (.v) & GTKWave vcd screenshots.',
    ),
    AssignmentItem(
      id: 'assign-eee-1',
      title: 'Power Simulation: 3-Phase Grid Inverter SPICE Modeling',
      instructor: 'Dr. Sarah Jenkins',
      instructorRole: 'Senior Lecturer, Electrical & Power Engineering',
      courseId: 'power',
      courseTitle: 'Power Electronics & Smart Grid Systems',
      branch: 'Electrical & Electronics Engineering',
      dueDate: 'August 10, 2026',
      totalPoints: 100,
      status: 'Active',
      type: 'LTSpice Simulation & Harmonic Waveform Analysis',
      description:
          'Model a 3-phase PWM grid-tied inverter in LTSpice and calculate Total Harmonic Distortion (THD) under variable solar radiation loads.',
      instructions: [
        'Set switching frequency to 20kHz with LC output filter.',
        'Verify THD remains under 5% at full rated power.',
        'Plot voltage and current phase synchronization.',
      ],
      submissionFormat: 'LTSpice file (.asc) and PDF simulation report.',
    ),
    AssignmentItem(
      id: 'assign-me-1',
      title: 'CAD Assembly: 6-DOF Industrial Robotic Arm Joint Stress',
      instructor: 'Prof. Vikramaditya Sharma',
      instructorRole: 'Professor, Mechanical Engineering & Robotics',
      courseId: 'cad',
      courseTitle: '3D CAD Modelling & FEA Structural Stress Analysis',
      branch: 'Mechanical Engineering',
      dueDate: 'August 14, 2026',
      totalPoints: 150,
      status: 'Active',
      type: '3D CAD Assembly & FEA Stress Heatmap Report',
      description:
          'Construct a parametric 3D CAD assembly of a 6-DOF robot elbow joint in SolidWorks/Autodesk and perform FEA structural analysis under a 50kg load.',
      instructions: [
        'Apply Von Mises stress analysis to identify yield stress points.',
        'Maintain safety factor > 2.5 across all load conditions.',
        'Export 3D CAD step file along with FEA color gradient report.',
      ],
      submissionFormat: 'CAD STEP file (.step) & FEA PDF report.',
    ),
    AssignmentItem(
      id: 'assign-ce-1',
      title: 'Structural Design: Reinforced Concrete High-Rise Skeleton',
      instructor: 'Prof. Marcus Vance',
      instructorRole: 'Head of Civil & Structural Engineering',
      courseId: 'structure',
      courseTitle: 'Structural Engineering & Reinforced Concrete Design',
      branch: 'Civil Engineering',
      dueDate: 'August 16, 2026',
      totalPoints: 100,
      status: 'Active',
      type: 'Revit BIM Model & Structural Calculation Sheet',
      description:
          'Design reinforced concrete beam-column joints for a 12-story commercial building subjected to wind and seismic lateral loads.',
      instructions: [
        'Calculate bending moments and shear force diagrams for key frames.',
        'Specify rebar diameters and stirrup spacing according to IS 456 / ACI codes.',
        'Submit Autodesk Revit 3D structural model or calculation sheet.',
      ],
      submissionFormat: 'PDF Structural Calculation Sheet & Revit BIM File.',
    ),
    AssignmentItem(
      id: 'assign-ch-1',
      title: 'Reactor Kinetics: Plug Flow Reactor (PFR) Optimization',
      instructor: 'Dr. Helena Zhang',
      instructorRole: 'Professor, Process Engineering & Propulsion',
      courseId: 'reaction',
      courseTitle: 'Chemical Reaction Engineering & Kinetics',
      branch: 'Chemical Engineering',
      dueDate: 'August 19, 2026',
      totalPoints: 100,
      status: 'Upcoming',
      type: 'Python Kinetics Solver & Process Data Sheet',
      description:
          'Derive differential rate equations for an exothermic catalytic gas-phase reaction and optimize reactor volume for 92% target conversion.',
      instructions: [
        'Solve non-isothermal ODE energy balances using Python scipy.integrate.',
        'Plot temperature profiles along the length of the reactor tube.',
        'Determine thermal runaway limits for safety valves.',
      ],
      submissionFormat: 'Python notebook or calculation report PDF.',
    ),
    AssignmentItem(
      id: 'assign-ae-1',
      title: 'Aero Flight Sim: Supersonic Airfoil Shockwave Pressure',
      instructor: 'Dr. Helena Zhang',
      instructorRole: 'Professor, Process Engineering & Propulsion',
      courseId: 'aero',
      courseTitle: 'Aerodynamics & Supersonic Flight Mechanics',
      branch: 'Aerospace Engineering',
      dueDate: 'August 25, 2026',
      totalPoints: 150,
      status: 'Upcoming',
      type: 'CFD Mesh & Mach 2.2 Pressure Coefficient Plots',
      description:
          'Perform 2D CFD aerodynamic simulations on a diamond supersonic airfoil at Mach 2.2 and compute oblique shock angle and wave drag.',
      instructions: [
        'Generate fine boundary layer structured mesh in ANSYS or OpenFOAM.',
        'Compare theoretical shock relations against CFD pressure contours.',
        'Submit pressure coefficient (Cp) distribution graphs.',
      ],
      submissionFormat: 'CFD Simulation Data PDF and mesh plot.',
    ),
  ];

  @override
  void dispose() {
    _submissionController.dispose();
    super.dispose();
  }

  List<AssignmentItem> get _filteredAssignments {
    final q = _search.trim().toLowerCase();
    return _assignments.where((item) {
      final matchesSearch = q.isEmpty ||
          item.title.toLowerCase().contains(q) ||
          item.instructor.toLowerCase().contains(q) ||
          item.courseTitle.toLowerCase().contains(q) ||
          item.type.toLowerCase().contains(q);
      return matchesSearch &&
          (_branch == 'All Branches' || item.branch == _branch);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    switch (_view) {
      case _AssignmentView.list:
        return _buildList();
      case _AssignmentView.details:
        return _buildDetails();
      case _AssignmentView.submit:
        return _buildSubmit();
      case _AssignmentView.success:
        return _buildSuccess();
    }
  }

  Color get _text =>
      widget.isDarkMode ? Colors.white : const Color(0xFF111622);
  Color get _muted =>
      widget.isDarkMode ? const Color(0xFF9299A9) : const Color(0xFF687287);
  Color get _surface =>
      widget.isDarkMode ? const Color(0xFF1B1E27) : Colors.white;
  Color get _border =>
      widget.isDarkMode ? const Color(0xFF2A303C) : const Color(0xFFE4E8F0);

  Widget _pageBackground({required Widget child}) {
    return Container(
      color: widget.isDarkMode
          ? const Color(0xFF10131A)
          : const Color(0xFFF4F6FB),
      child: child,
    );
  }

  Widget _buildList() {
    return _pageBackground(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(40, 42, 40, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 25),
            _branchFilters(),
            const SizedBox(height: 30),
            if (_filteredAssignments.isEmpty)
              _emptyState()
            else
              ..._filteredAssignments.map(_assignmentCard),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COURSE DELIVERABLES',
                style: TextStyle(
                  color: _muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Assignments Listed by Instructors',
                style: TextStyle(
                  color: _text,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Official coursework and practical lab assignments posted by course faculty.',
                style: TextStyle(color: _muted, fontSize: 13.5),
              ),
            ],
          ),
        ),
        const SizedBox(width: 22),
        SizedBox(
          width: 325,
          height: 42,
          child: TextField(
            onChanged: (v) => setState(() => _search = v),
            style: TextStyle(color: _text, fontSize: 12),
            decoration: _inputDecoration(
              hint: 'Search title, instructor, course...',
              icon: Icons.search_rounded,
            ),
          ),
        ),
      ],
    );
  }

  Widget _branchFilters() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _branches.length,
        separatorBuilder: (_, __) => const SizedBox(width: 9),
        itemBuilder: (_, index) {
          final branch = _branches[index];
          final selected = branch == _branch;
          return InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => setState(() => _branch = branch),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFFF782F)
                    : (widget.isDarkMode
                        ? const Color(0xFF1B202A)
                        : const Color(0xFFF0F2F7)),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                _shortBranch(branch),
                style: TextStyle(
                  color: selected ? Colors.white : _text,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _shortBranch(String branch) {
    switch (branch) {
      case 'All Branches':
        return 'All Branches';
      case 'Computer Science & Engineering':
        return 'Computer';
      case 'Information Technology':
        return 'Information';
      case 'Electronics & Communication Engineering':
        return 'Electronics';
      case 'Electrical & Electronics Engineering':
        return 'Electrical';
      case 'Mechanical Engineering':
        return 'Mechanical';
      case 'Civil Engineering':
        return 'Civil';
      case 'Chemical Engineering':
        return 'Chemical';
      case 'Aerospace Engineering':
        return 'Aerospace';
      default:
        return branch;
    }
  }

  Widget _assignmentCard(AssignmentItem item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: _border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(19),
          onTap: () => setState(() {
            _selected = item;
            _view = _AssignmentView.details;
          }),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(23, 20, 23, 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _avatar(item.instructor),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  item.instructor,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: _text,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              _badge('Instructor', _border, _muted),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.instructorRole,
                            style: TextStyle(color: _muted, fontSize: 10.5),
                          ),
                        ],
                      ),
                    ),
                    _statusBadge(item.status),
                    const SizedBox(width: 8),
                    _pointsBadge(item.totalPoints),
                  ],
                ),
                const SizedBox(height: 17),
                Text(
                  item.title,
                  style: TextStyle(
                    color: _text,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _muted,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 14),
                Divider(height: 1, color: _border),
                const SizedBox(height: 11),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 8,
                  spacing: 12,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.description_outlined,
                          size: 15,
                          color: Color(0xFFFF7A30),
                        ),
                        const SizedBox(width: 7),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 430),
                          child: Text(
                            item.courseTitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: _text,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.schedule_outlined,
                          size: 13,
                          color: Color(0xFFFF5960),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Due: ${item.dueDate}',
                          style: const TextStyle(
                            color: Color(0xFFFF5960),
                            fontSize: 10.5,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.chevron_right_rounded, color: _muted, size: 18),
                      ],
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

  Widget _buildDetails() {
    final item = _selected!;
    return _pageBackground(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(40, 42, 40, 60),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Container(
              padding: const EdgeInsets.all(34),
              decoration: BoxDecoration(
                color: _surface,
                border: Border.all(color: _border),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(widget.isDarkMode ? .12 : .06),
                    blurRadius: 22,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _backButton('Back to Assignments List', () {
                    setState(() => _view = _AssignmentView.list);
                  }),
                  const SizedBox(height: 25),
                  _instructorHeader(item),
                  const SizedBox(height: 27),
                  Text(
                    item.branch.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFFFF712B),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.title,
                    style: TextStyle(
                      color: _text,
                      fontSize: 23,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 7,
                    children: [
                      _meta('Due:', item.dueDate, const Color(0xFFFF5960)),
                      _meta('Max Marks:', '${item.totalPoints} Points',
                          const Color(0xFF00B96B)),
                      _meta('Type:', item.type, _text),
                    ],
                  ),
                  const SizedBox(height: 29),
                  _sectionTitle('Assignment Overview'),
                  const SizedBox(height: 8),
                  _infoBox(item.description),
                  const SizedBox(height: 25),
                  _sectionTitle('Instructor Guidelines & Requirements'),
                  const SizedBox(height: 10),
                  ...item.instructions.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 21,
                            height: 21,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF7A30).withOpacity(.10),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${entry.key + 1}',
                              style: const TextStyle(
                                color: Color(0xFFFF7A30),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: TextStyle(
                                color: _text,
                                fontSize: 12.5,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: widget.isDarkMode
                          ? const Color(0xFF2D1E18)
                          : const Color(0xFFFFF8F4),
                      border: Border.all(
                        color: const Color(0xFFFF7A30).withOpacity(.25),
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SUBMISSION FORMAT REQUIRED',
                          style: TextStyle(
                            color: Color(0xFFFF6C28),
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .6,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.submissionFormat,
                          style: TextStyle(
                            color: _text,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _submissionController.text = _starterDraft(item);
                        setState(() => _view = _AssignmentView.submit);
                      },
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: const Text(
                        'Proceed to Text / Code Editor Submittal',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A30),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    final item = _selected!;
    return _pageBackground(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(40, 38, 40, 60),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Container(
              padding: const EdgeInsets.fromLTRB(34, 30, 34, 34),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: _border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(widget.isDarkMode ? .12 : .07),
                    blurRadius: 25,
                    offset: const Offset(0, 13),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _backButton('Back to Details', () {
                    setState(() => _view = _AssignmentView.details);
                  }),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Write Submission Draft',
                              style: TextStyle(
                                color: _text,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Instructor: ${item.instructor}',
                              style: TextStyle(color: _muted, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: widget.isDarkMode
                              ? const Color(0xFF40351B)
                              : const Color(0xFFFFF4C9),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 15,
                              color: Color(0xFFFFA000),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'AI Outline Draft Helper',
                              style: TextStyle(
                                color: Color(0xFFB77900),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Divider(color: _border, height: 1),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _submissionController,
                    minLines: 11,
                    maxLines: 18,
                    style: TextStyle(
                      color: _text,
                      fontSize: 12,
                      height: 1.55,
                      fontFamily: 'monospace',
                    ),
                    decoration: InputDecoration(
                      hintText:
                          'Draft your engineering submittal notes, code snippets, or repository URL here...',
                      hintStyle: TextStyle(color: _muted, fontSize: 12),
                      filled: true,
                      fillColor: widget.isDarkMode
                          ? const Color(0xFF151820)
                          : Colors.white,
                      contentPadding: const EdgeInsets.all(17),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(color: _border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(color: _border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: const BorderSide(
                          color: Color(0xFFFF7A30),
                          width: 1.4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_submissionController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter your submission draft.'),
                            ),
                          );
                          return;
                        }
                        setState(() => _view = _AssignmentView.success);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34C989),
                        foregroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Submit Deliverable to ${item.instructor}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    final item = _selected!;
    return _pageBackground(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(40, 60, 40, 60),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 610),
            child: Container(
              padding: const EdgeInsets.fromLTRB(36, 35, 36, 36),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: _border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(widget.isDarkMode ? .12 : .07),
                    blurRadius: 25,
                    offset: const Offset(0, 13),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C989).withOpacity(.10),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF00B77A),
                      size: 35,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Deliverable Successfully Submitted',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _text,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 11),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: _muted,
                        fontSize: 12.5,
                        height: 1.55,
                      ),
                      children: [
                        const TextSpan(text: 'Your submittal for '),
                        TextSpan(
                          text: item.title,
                          style: TextStyle(
                            color: _text,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const TextSpan(
                          text: ' has been logged in the grading queue for ',
                        ),
                        TextSpan(
                          text: item.instructor,
                          style: const TextStyle(
                            color: Color(0xFFFF7A30),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: widget.isDarkMode
                          ? const Color(0xFF161A22)
                          : const Color(0xFFF8FAFC),
                      border: Border.all(color: _border),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        _successRow(
                          'Target Points',
                          '${item.totalPoints} Points',
                          const Color(0xFF00B96B),
                        ),
                        const SizedBox(height: 10),
                        _successRow(
                          'Review Instructor',
                          item.instructor,
                          _text,
                        ),
                        const SizedBox(height: 10),
                        _successRow(
                          'Expected Feedback',
                          'Within 3 Business Days',
                          _text,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _view = _AssignmentView.list;
                          _selected = null;
                          _submissionController.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A30),
                        foregroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Back to Instructor Assignments List',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _instructorHeader(AssignmentItem item) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF151922)
            : const Color(0xFFF9FAFC),
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          _avatar(item.instructor, large: true),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.instructor,
                  style: TextStyle(
                    color: _text,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.instructorRole,
                  style: TextStyle(color: _muted, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'COURSE ASSIGNMENT',
                  style: TextStyle(
                    color: Color(0xFFFF6A26),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.courseTitle,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: _text,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFFFF4F58),
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFF4F58),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: _muted,
        fontSize: 10.5,
        fontWeight: FontWeight.w800,
        letterSpacing: .7,
      ),
    );
  }

  Widget _infoBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF171B23)
            : const Color(0xFFFAFBFD),
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _text,
          fontSize: 12.5,
          height: 1.55,
        ),
      ),
    );
  }

  Widget _meta(String label, String value, Color valueColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(color: _muted, fontSize: 10.5)),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _successRow(String label, String value, Color valueColor) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: _muted, fontSize: 11.5)),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _avatar(String name, {bool large = false}) {
    final initials = name
        .split(RegExp(r'\s+'))
        .where((x) => x.isNotEmpty)
        .map((x) => x[0])
        .take(2)
        .join()
        .toUpperCase();

    final size = large ? 44.0 : 35.0;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFF7A30).withOpacity(.10),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFFF7A30).withOpacity(.25),
        ),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: const Color(0xFFFF6B27),
          fontSize: large ? 12 : 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _badge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    final active = status == 'Active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFFE4FAF1)
            : const Color(0xFFFFF4E0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: active
              ? const Color(0xFF00B96B)
              : const Color(0xFFFF9700),
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _pointsBadge(int points) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '$points Points',
        style: const TextStyle(
          color: Color(0xFFFF702A),
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 25),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          Icon(Icons.description_outlined, size: 38, color: _muted),
          const SizedBox(height: 13),
          Text(
            'No Assignments Found',
            style: TextStyle(
              color: _text,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'There are no instructor assignments matching your search or branch filter.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontSize: 12),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => setState(() {
              _search = '';
              _branch = 'All Branches';
            }),
            child: const Text(
              'Reset filters',
              style: TextStyle(
                color: Color(0xFFFF7A30),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: _muted, fontSize: 12),
      prefixIcon: Icon(icon, size: 17, color: _muted),
      filled: true,
      fillColor: _surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: _border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFFF7A30)),
      ),
    );
  }

  String _starterDraft(AssignmentItem item) {
    if (item.courseId == 'python') {
      return [
        '# ${item.title}',
        '# ${item.submissionFormat}',
        '',
        'import asyncio',
        '',
        'async def main():',
        '    # Draft your asynchronous worker/event-loop implementation here.',
        '    pass',
        '',
        'if __name__ == "__main__":',
        '    asyncio.run(main())',
        '',
      ].join('\n');
    }

    if (item.courseId == 'web-dev') {
      return [
        '// ${item.title}',
        '// Draft your React 18 / Vite implementation here.',
        '',
        'export default function App() {',
        '  return <main>Submission draft</main>;',
        '}',
        '',
      ].join('\n');
    }

    return [
      item.title,
      '',
      'Submission notes / implementation:',
      '- Describe your approach.',
      '- Add relevant code, calculations, or repository URL.',
      '- Include evidence required by the instructor.',
      '',
    ].join('\n');
  }
}

enum _AssignmentView { list, details, submit, success }

class AssignmentItem {
  final String id;
  final String title;
  final String instructor;
  final String instructorRole;
  final String courseId;
  final String courseTitle;
  final String branch;
  final String dueDate;
  final int totalPoints;
  final String status;
  final String type;
  final String description;
  final List<String> instructions;
  final String submissionFormat;

  const AssignmentItem({
    required this.id,
    required this.title,
    required this.instructor,
    required this.instructorRole,
    required this.courseId,
    required this.courseTitle,
    required this.branch,
    required this.dueDate,
    required this.totalPoints,
    required this.status,
    required this.type,
    required this.description,
    required this.instructions,
    required this.submissionFormat,
  });
}
