import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/project_data.dart';
import '../models/project_model.dart';

class ProjectsScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  final ValueChanged<int> onSelectSidebarIndex;

  const ProjectsScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
    required this.onSelectSidebarIndex,
  });

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String selectedBranch = 'ALL';
  String searchQuery = '';
  EngineeringProject? selectedActiveProject;
  int activeTab = 0; // 0: Overview, 1: IDE, 2: Roadmap, 3: Troubleshoot, 4: AI, 5: Rubrics

  final List<Map<String, String>> branchFilters = [
    {'code': 'ALL', 'label': 'All Branches'},
    {'code': 'CSE', 'label': 'CSE 3'},
    {'code': 'IT', 'label': 'IT 2'},
    {'code': 'ECE', 'label': 'ECE 2'},
    {'code': 'EEE', 'label': 'EEE 2'},
    {'code': 'ME', 'label': 'ME 2'},
    {'code': 'CE', 'label': 'CE 2'},
    {'code': 'CH', 'label': 'CH 2'},
    {'code': 'AE', 'label': 'AE 2'},
  ];

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDarkMode ? const Color(0xFF090D16) : const Color(0xFFF4F6FB);
    final cardBgColor = widget.isDarkMode ? const Color(0xFF131927) : Colors.white;
    final primaryTextColor = widget.isDarkMode ? Colors.white : const Color(0xFF0F172A);
    final subTextColor = widget.isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final borderThemeColor = widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);

    if (selectedActiveProject != null) {
      return _buildProjectWorkspaceDetail(cardBgColor, primaryTextColor, subTextColor, borderThemeColor);
    }

    final filteredProjects = allEngineeringProjects.where((proj) {
      final matchesBranch = selectedBranch == 'ALL' || proj.branchCode == selectedBranch;
      final matchesSearch = proj.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          proj.tags.any((t) => t.toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesBranch && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            // Directory Header
            Text(
              '🎓 BRANCH-WISE ENGINEERING TRACK',
              style: GoogleFonts.firaCode(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFFF5722)),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAlignment.start,
                  children: [
                    Text(
                      'Hands-On Engineering Projects & AI Guidance',
                      style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: primaryTextColor),
                    ),
                    Text(
                      'Explore real-world projects with step-by-step roadmaps, code hints, troubleshooting guides, and our Sophia AI Mentor.',
                      style: GoogleFonts.inter(fontSize: 12, color: subTextColor),
                    ),
                  ],
                ),
                SizedBox(
                  width: 250,
                  height: 38,
                  child: TextField(
                    onChanged: (val) => setState(() => searchQuery = val),
                    style: GoogleFonts.inter(fontSize: 12, color: primaryTextColor),
                    decoration: InputDecoration(
                      hintText: 'Search projects, skills, tech...',
                      hintStyle: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF94A3B8)),
                      prefixIcon: const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                      filled: true,
                      fillColor: widget.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: borderThemeColor)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Branch Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: branchFilters.map((b) {
                  final isSelected = selectedBranch == b['code'];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(b['label']!),
                      selected: isSelected,
                      selectedColor: const Color(0xFFFF5722),
                      backgroundColor: cardBgColor,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : primaryTextColor,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: borderThemeColor)),
                      onSelected: (_) => setState(() => selectedBranch = b['code']!),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Projects Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final crossCount = constraints.maxWidth > 900 ? 2 : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProjects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossCount,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    mainAxisExtent: 250,
                  ),
                  itemBuilder: (context, idx) {
                    final proj = filteredProjects[idx];
                    return _buildProjectCardItem(proj, cardBgColor, primaryTextColor, subTextColor, borderThemeColor);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCardItem(EngineeringProject proj, Color cardBg, Color textPrimary, Color textSub, Color borderCol) {
    Color statusColor;
    switch (proj.status) {
      case 'IN PROGRESS':
        statusColor = const Color(0xFF2563EB);
        break;
      case 'IN REVIEW':
        statusColor = const Color(0xFFD97706);
        break;
      case 'NEEDS REVISION':
        statusColor = const Color(0xFFDC2626);
        break;
      case 'UNASSIGNED':
      default:
        statusColor = const Color(0xFF64748B);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        crossAxisAlignment: CrossAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(6)),
                    child: Text(proj.branchName, style: GoogleFonts.firaCode(fontSize: 9, fontWeight: FontWeight.bold, color: const Color(0xFF3730A3))),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4)),
                    child: Text(proj.difficulty, style: GoogleFonts.inter(fontSize: 9, color: textSub)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                child: Text(proj.status, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: statusColor)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(proj.title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Text(proj.summary, style: GoogleFonts.inter(fontSize: 11, color: textSub, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
          const Spacer(),
          Wrap(
            spacing: 6,
            children: proj.tags.take(4).map((t) => Chip(
              label: Text(t, style: GoogleFonts.firaCode(fontSize: 9, color: textPrimary)),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              backgroundColor: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
            )).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('📅 Due: ${proj.dueDate}', style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFFEA580C), fontWeight: FontWeight.bold)),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => setState(() {
                      selectedActiveProject = proj;
                      activeTab = 1; // Direct to IDE
                    }),
                    icon: const Icon(Icons.code, size: 12),
                    label: Text('Open Sandbox', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF10B981)), foregroundColor: const Color(0xFF10B981)),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () => setState(() {
                      selectedActiveProject = proj;
                      activeTab = 0; // Direct to Specs
                    }),
                    icon: const Icon(Icons.menu_book, size: 12),
                    label: Text('View Specs', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFEA580C)), foregroundColor: const Color(0xFFEA580C)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // DETAILED PROJECT WORKSPACE
  // =========================================================================
  Widget _buildProjectWorkspaceDetail(Color cardBg, Color textPrimary, Color textSub, Color borderCol) {
    final proj = selectedActiveProject!;

    return Scaffold(
      backgroundColor: widget.isDarkMode ? const Color(0xFF090D16) : const Color(0xFFF4F6FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            InkWell(
              onTap: () => setState(() => selectedActiveProject = null),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, size: 14, color: Color(0xFFEF4444)),
                  const SizedBox(width: 6),
                  Text('BACK TO PROJECTS DIRECTORY', style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFFEF4444))),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Top Info Header Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: borderCol)),
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(6)),
                            child: Text(proj.branchName, style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF3730A3))),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: const Color(0xFF2563EB).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                            child: Text(proj.status, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF2563EB))),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => setState(() => activeTab = 1),
                            icon: const Icon(Icons.code, size: 14, color: Colors.white),
                            label: Text('Code Sandbox IDE', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () => setState(() => activeTab = 4),
                            icon: const Icon(Icons.smart_toy, size: 14, color: Colors.white),
                            label: Text('Sophia AI Mentor', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deliverable Submitted for Faculty Review!'), backgroundColor: Color(0xFF10B981)));
                            },
                            icon: const Icon(Icons.cloud_upload, size: 14, color: Colors.white),
                            label: Text('Submit Deliverable', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEA580C)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(proj.title, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: textPrimary)),
                  const SizedBox(height: 6),
                  Text(proj.summary, style: GoogleFonts.inter(fontSize: 12, color: textSub, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tab Buttons Row
            Row(
              children: [
                _workspaceTab('📖 Overview & Specs', 0),
                const SizedBox(width: 8),
                _workspaceTab('💻 Interactive Sandbox IDE', 1),
                const SizedBox(width: 8),
                _workspaceTab('📚 Step-by-Step Roadmap (${proj.roadmap.length})', 2),
                const SizedBox(width: 8),
                _workspaceTab('🔧 Troubleshooting & Debug (${proj.debugIssues.length})', 3),
                const SizedBox(width: 8),
                _workspaceTab('🤖 AI Mentor (Sophia)', 4),
                const SizedBox(width: 8),
                _workspaceTab('📹 Rubrics & Doubt Sessions', 5),
              ],
            ),
            const SizedBox(height: 20),

            // TAB 0: OVERVIEW & SPECS
            if (activeTab == 0) ...[
              Row(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderCol)),
                          child: Column(
                            crossAxisAlignment: CrossAlignment.start,
                            children: [
                              Text('⚙️ SYSTEM ARCHITECTURE & ENGINEERING MODEL', style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFFEA580C))),
                              const SizedBox(height: 8),
                              Text(proj.systemArchitecture, style: GoogleFonts.firaCode(fontSize: 11, color: textPrimary, height: 1.5)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text('REQUIRED DELIVERABLES', style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: textSub)),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: proj.deliverables.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.5, crossAxisSpacing: 10, mainAxisSpacing: 10),
                          itemBuilder: (context, idx) {
                            final d = proj.deliverables[idx];
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: borderCol)),
                              child: Row(
                                children: [
                                  Icon(d.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked, size: 16, color: d.isCompleted ? const Color(0xFF10B981) : textSub),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(d.title, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: textPrimary), overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderCol)),
                          child: Column(
                            crossAxisAlignment: CrossAlignment.start,
                            children: [
                              Text('TECH STACK & FRAMEWORKS', style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: textSub)),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: proj.techStack.map((t) => Chip(
                                  label: Text(t, style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: textPrimary)),
                                  backgroundColor: widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                                )).toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderCol)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Project Due Date:', style: GoogleFonts.inter(fontSize: 11, color: textSub)),
                                  Text(proj.dueDate, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: textPrimary)),
                                ],
                              ),
                              const Divider(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Collaborators:', style: GoogleFonts.inter(fontSize: 11, color: textSub)),
                                  Row(
                                    children: [
                                      CircleAvatar(radius: 10, backgroundColor: Colors.orange, child: Text('AS', style: GoogleFonts.inter(fontSize: 8, color: Colors.white))),
                                      const SizedBox(width: 2),
                                      CircleAvatar(radius: 10, backgroundColor: Colors.purple, child: Text('RK', style: GoogleFonts.inter(fontSize: 8, color: Colors.white))),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],

            // TAB 1: INTERACTIVE SANDBOX IDE
            if (activeTab == 1) ...[
              Container(
                height: 480,
                decoration: BoxDecoration(color: const Color(0xFF070A12), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF1E293B))),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      color: const Color(0xFF0F172A),
                      child: Row(
                        children: [
                          Text('main.py', style: GoogleFonts.firaCode(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 16),
                          Text('config.json', style: GoogleFonts.firaCode(color: const Color(0xFF64748B), fontSize: 11)),
                          const SizedBox(width: 16),
                          Text('test_suite.py', style: GoogleFonts.firaCode(color: const Color(0xFF64748B), fontSize: 11)),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Executing isolated container code...'), duration: Duration(milliseconds: 900)));
                            },
                            icon: const Icon(Icons.play_arrow, size: 14),
                            label: Text('Run Code', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: Text(proj.initialCode, style: GoogleFonts.firaCode(color: Colors.greenAccent, fontSize: 11, height: 1.5)),
                              ),
                            ),
                          ),
                          Container(width: 1, color: const Color(0xFF1E293B)),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              color: const Color(0xFF030712),
                              child: Column(
                                crossAxisAlignment: CrossAlignment.start,
                                children: [
                                  Text('>_ Console Output', style: GoogleFonts.firaCode(color: const Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('🚀 [SANDBOX ENGINE] Booting isolated container runtime...', style: GoogleFonts.firaCode(color: Colors.white70, fontSize: 10)),
                                  Text('📦 [DEPS] Dependencies loaded.', style: GoogleFonts.firaCode(color: Colors.white70, fontSize: 10)),
                                  Text('🔒 [CONTAINER] Memory cap: 512MB | CPU Quota: 2.0 Cores', style: GoogleFonts.firaCode(color: Colors.white70, fontSize: 10)),
                                  const SizedBox(height: 10),
                                  Text('✅ All test assertions passed!', style: GoogleFonts.firaCode(color: const Color(0xFF4ADE80), fontSize: 11, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // TAB 2: ROADMAP
            if (activeTab == 2) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: proj.roadmap.length,
                itemBuilder: (context, idx) {
                  final step = proj.roadmap[idx];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderCol)),
                    child: Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: [
                        Text('STEP ${step.stepNumber}: ${step.title}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: textPrimary)),
                        const SizedBox(height: 6),
                        Text(step.description, style: GoogleFonts.inter(fontSize: 11, color: textSub, height: 1.4)),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(8)),
                          child: Text(step.codeHint, style: GoogleFonts.firaCode(color: Colors.greenAccent, fontSize: 10, height: 1.4)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],

            // TAB 3: TROUBLESHOOTING
            if (activeTab == 3) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: proj.debugIssues.length,
                itemBuilder: (context, idx) {
                  final issue = proj.debugIssues[idx];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderCol)),
                    child: Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: [
                        Text(issue.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFFDC2626))),
                        const SizedBox(height: 4),
                        Text('Root Cause: ${issue.rootCause}', style: GoogleFonts.inter(fontSize: 11, color: textSub)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFBBF7D0))),
                          child: Text('Resolution: ${issue.resolution}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF166534), fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],

            // TAB 4: AI MENTOR (SOPHIA)
            if (activeTab == 4) ...[
              Container(
                height: 400,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderCol)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.smart_toy, color: Color(0xFF8B5CF6)),
                        const SizedBox(width: 8),
                        Text('Sophia — Dedicated AI Mentor for ${proj.title}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: textPrimary)),
                      ],
                    ),
                    const Divider(height: 24),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: widget.isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12)),
                        child: Text('✨ Hello! I am Sophia. I have indexed all architectural specs and deliverables for ${proj.title}. How can I assist your implementation today?', style: GoogleFonts.inter(fontSize: 11, color: textPrimary, height: 1.4)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      style: GoogleFonts.inter(fontSize: 12, color: textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Ask Sophia AI about starter code templates or debugging...',
                        hintStyle: GoogleFonts.inter(fontSize: 11, color: textSub),
                        suffixIcon: IconButton(icon: const Icon(Icons.send, color: Color(0xFF8B5CF6)), onPressed: () {}),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: borderCol)),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // TAB 5: RUBRICS & DOUBT SESSIONS
            if (activeTab == 5) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderCol)),
                child: Column(
                  crossAxisAlignment: CrossAlignment.start,
                  children: [
                    Text('EVALUATION RUBRICS BREAKDOWN (100 POINTS SCALE)', style: GoogleFonts.firaCode(fontSize: 10, fontWeight: FontWeight.bold, color: textSub)),
                    const SizedBox(height: 12),
                    ...proj.rubrics.map((r) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: widget.isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAlignment.start,
                            children: [
                              Text(r.title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: textPrimary)),
                              Text(r.description, style: GoogleFonts.inter(fontSize: 10, color: textSub)),
                            ],
                          ),
                          Text('${r.points} pts', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF10B981))),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _workspaceTab(String label, int index) {
    final isActive = activeTab == index;
    return InkWell(
      onTap: () => setState(() => activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFEA580C) : (widget.isDarkMode ? const Color(0xFF1E293B) : Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: isActive ? Colors.white : (widget.isDarkMode ? Colors.white70 : const Color(0xFF475569))),
        ),
      ),
    );
  }
}