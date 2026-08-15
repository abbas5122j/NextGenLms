import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SophiaAIScreen extends StatefulWidget {
  final String userName;
  final String selectedCourseTitle;
  final VoidCallback onExit;
  final ValueChanged<String> onAssessmentComplete; // returns assessed level: 'beginner', 'intermediate', 'advanced'

  const SophiaAIScreen({
    super.key,
    required this.userName,
    required this.selectedCourseTitle,
    required this.onExit,
    required this.onAssessmentComplete,
  });

  @override
  State<SophiaAIScreen> createState() => _SophiaAIScreenState();
}

class _SophiaAIScreenState extends State<SophiaAIScreen> {
  // Assessment Flow Stages: 0: Permission Modal, 1: Reasoning MCQs, 2: Coding Compiler, 3: Verbal AI, 4: Final Scorecard Report
  int _assessmentStage = 0;

  // Reasoning Quiz State
  int _currentQuestionIndex = 0;
  int? _selectedMcqOption;
  bool _mcqAnswerSubmitted = false;

  final List<Map<String, dynamic>> _reasoningQuestions = [
    {
      'title': 'HTTP Protocol & Caching Logic',
      'question': 'What does an HTTP status response code "304 Not Modified" instruct the browser client to do?',
      'options': [
        'Reuse its local cached copy of the resource because the server entity tag (ETag) hasn\'t changed',
        'Abort the TCP handshake and display a CORS network error',
        'Clear all local cookies and re-authenticate the current user session',
        'Permanently redirect the browser request to a HTTPS endpoint',
      ],
      'correctIndex': 0,
      'explanation': 'A 304 response indicates that the cached resource on the client browser is still valid. The server sends no response body, saving bandwidth and speeding load times.',
    },
    {
      'title': 'JavaScript Event Loop & Execution Order',
      'question': 'Analyze this asynchronous code block carefully:\n\nconsole.log(\'1\');\nsetTimeout(() => console.log(\'2\'), 0);\nPromise.resolve().then(() => console.log(\'3\'));\nconsole.log(\'4\');\n\nWhat exact output sequence will be printed to the console?',
      'options': [
        '1, 2, 3, 4',
        '1, 4, 3, 2',
        '1, 4, 2, 3',
        '3, 1, 4, 2',
      ],
      'correctIndex': 1,
      'explanation': 'Synchronous code executes first (1, 4). Next, microtasks (Promises) run before macrotasks (setTimeout queue). Thus, 3 prints before 2, producing 1, 4, 3, 2.',
    },
    {
      'title': 'React Reconciliation & Keys',
      'question': 'Why does using array indices as the "key" prop in dynamic React lists cause unexpected UI bugs when items are reordered or deleted?',
      'options': [
        'Indices force the entire React application to unmount and remount',
        'Indices throw a runtime SyntaxError in modern browser engines',
        'Indices break React\'s DOM diffing algorithm by misassociating component state with the wrong position',
        'Indices prevent Tailwind CSS classes from applying to child items',
      ],
      'correctIndex': 2,
      'explanation': 'When list items are reordered or sensitized, key indices remain static. React assumes the component at index 0 is unchanged, causing local state (like input values or check states) to remain stuck on erroneous elements.',
    },
  ];

  // Coding Compiler State
  bool _isCompiling = false;
  bool _codeCompiledSuccessfully = false;
  final TextEditingController _codeEditorController = TextEditingController(text: '''// Challenge: Find Target Sum Pairs
// Implement a function findPairSum(arr, target) that returns an array of all integer pairs from array "arr" whose sum equals the integer "target".

function findPairSum(arr, target) {
  const seen = new Set();
  const pairs = [];
  
  for (let num of arr) {
    const complement = target - num;
    if (seen.has(complement)) {
      pairs.push([complement, num]);
    }
    seen.add(num);
  }
  
  return pairs;
}

// Example execution:
console.log(findPairSum([7, 15, 2, 9], 9)); // Expected [[7, 2]]''');

  // Verbal AI State
  final TextEditingController _verbalAnswerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D16),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeaderBar(),
            Expanded(
              child: _buildBodyContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeaderBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF111420),
        border: Border(bottom: BorderSide(color: Color(0xFF1E293B))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology, color: Color(0xFFFF6B35), size: 22),
              const SizedBox(width: 8),
              Text('SOPHIA AI TEACHER', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(6)),
                child: Text('PROCTORED: ${widget.selectedCourseTitle.toUpperCase()} ASSESSMENT', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              _stageIndicatorBadge('PHASE 1: REASONING', _assessmentStage == 1),
              const SizedBox(width: 6),
              _stageIndicatorBadge('PHASE 2: COMPILER', _assessmentStage == 2),
              const SizedBox(width: 6),
              _stageIndicatorBadge('PHASE 3: VERBAL', _assessmentStage == 3),
              const SizedBox(width: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF166534).withValues(alpha: 0.3), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.videocam, size: 12, color: Color(0xFF4ADE80)),
                    const SizedBox(width: 6),
                    Text('Proctoring: Active (Cam & Screen Share)', style: GoogleFonts.inter(color: const Color(0xFF4ADE80), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              TextButton.icon(
                onPressed: widget.onExit,
                icon: const Icon(Icons.exit_to_app, size: 16, color: Color(0xFFEF4444)),
                label: Text('Exit Fullscreen', style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stageIndicatorBadge(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF6B35).withValues(alpha: 0.2) : const Color(0xFF1A2234),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: isActive ? const Color(0xFFFF6B35) : Colors.transparent),
      ),
      child: Text(label, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: isActive ? const Color(0xFFFF6B35) : const Color(0xFF64748B))),
    );
  }

  Widget _pillBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    if (_assessmentStage == 0) {
      return _buildPermissionAuthorizationScreen();
    } else if (_assessmentStage == 1) {
      return _buildReasoningQuizScreen();
    } else if (_assessmentStage == 2) {
      return _buildPracticalCompilerScreen();
    } else if (_assessmentStage == 3) {
      return _buildVerbalAIChatScreen();
    } else {
      return _buildFinalScorecardReportScreen();
    }
  }

  // --- STAGE 0: PERMISSION MODAL ---
  Widget _buildPermissionAuthorizationScreen() {
    return Center(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: const Color(0xFF111726),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF222F43), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: const Color(0xFFFF6B35).withValues(alpha: 0.15),
              child: const Icon(Icons.shield_outlined, color: Color(0xFFFF6B35), size: 32),
            ),
            const SizedBox(height: 18),
            Text('FULL SCREEN & PROCTOR AI ASSESSMENT', style: GoogleFonts.inter(color: const Color(0xFFFF6B35), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            const SizedBox(height: 8),
            Text('Welcome Abhijeet! I\'m Sophia, Your AI Teacher', style: GoogleFonts.inter(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('To make your assessment is genuine, verifiable, and strict proctoring is key to background, please authorize webcam, microphone, and screen share.', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12, height: 1.4), textAlign: TextAlign.center),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _permissionItem(Icons.camera_alt_outlined, 'Camera Stream', 'Monitors face presence in background.'),
                _permissionItem(Icons.mic_none, 'Audio Dictation', 'Allows you to answer questions out loud.'),
                _permissionItem(Icons.screen_share_outlined, 'Screen Share', 'Ensures fair, uncheated assessment.'),
              ],
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => setState(() => _assessmentStage = 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.verified_user, size: 18, color: Colors.white),
                    const SizedBox(width: 8),
                    Text('Authorize Screen Share & Begin Assessment', style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _permissionItem(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF38BDF8), size: 24),
        const SizedBox(height: 8),
        Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        SizedBox(
          width: 150,
          child: Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 10, height: 1.3), textAlign: TextAlign.center),
        ),
      ],
    );
  }

  // --- STAGE 1: REASONING QUIZ ---
  Widget _buildReasoningQuizScreen() {
    final q = _reasoningQuestions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left AI Avatar & Dialogue
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF111726), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF1E293B))),
              child: Column(
                children: [
                  const CircleAvatar(radius: 40, backgroundColor: Color(0xFFFF6B35), child: Icon(Icons.smart_toy, size: 36, color: Colors.white)),
                  const SizedBox(height: 14),
                  Text('SOPHIA AI TEACHER', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 6),
                  Text('LIVE PROCTORING ACTIVE', style: GoogleFonts.inter(color: Colors.greenAccent, fontSize: 9, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF1A2234), borderRadius: BorderRadius.circular(14)),
                    child: Text(
                      'Hello Abhijeet! Let\'s begin our assessment with our first question! Take your time and evaluate thoroughly.',
                      style: GoogleFonts.inter(color: const Color(0xFFCBD5E1), fontSize: 11, height: 1.4),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.security, size: 14, color: Color(0xFF64748B)),
                      const SizedBox(width: 8),
                      Text('Background Proctoring Monitored', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 10)),
                      const Spacer(),
                      Text('Violations: 0', style: GoogleFonts.inter(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),

          // Right Question & Options Card
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(color: const Color(0xFF111726), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF1E293B))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFFF6B35).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                        child: Text('QUESTION ${_currentQuestionIndex + 1} OF ${_reasoningQuestions.length}', style: GoogleFonts.inter(color: const Color(0xFFFF6B35), fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Text('Cognitive Reasoning Gate', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(q['title'], style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(q['question'], style: GoogleFonts.inter(color: const Color(0xFFCBD5E1), fontSize: 12, height: 1.5)),
                  const SizedBox(height: 24),

                  // Options List
                  Expanded(
                    child: ListView.builder(
                      itemCount: (q['options'] as List).length,
                      itemBuilder: (context, idx) {
                        final isSelected = _selectedMcqOption == idx;
                        final isCorrectOpt = idx == q['correctIndex'];
                        Color borderColor = const Color(0xFF1E293B);
                        Color fillColor = const Color(0xFF1A2234);

                        if (_mcqAnswerSubmitted) {
                          if (isCorrectOpt) {
                            borderColor = Colors.green;
                            fillColor = Colors.green.withValues(alpha: 0.15);
                          } else if (isSelected && !isCorrectOpt) {
                            borderColor = Colors.red;
                            fillColor = Colors.red.withValues(alpha: 0.15);
                          }
                        } else if (isSelected) {
                          borderColor = const Color(0xFFFF6B35);
                        }

                        return GestureDetector(
                          onTap: _mcqAnswerSubmitted ? null : () => setState(() => _selectedMcqOption = idx),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: borderColor, width: 1.5),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                                  color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFF64748B),
                                  size: 18,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    q['options'][idx],
                                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                if (_mcqAnswerSubmitted && isCorrectOpt)
                                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  if (_mcqAnswerSubmitted) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SOPHIA TEACHER EXPLANATION:', style: GoogleFonts.inter(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(q['explanation'], style: GoogleFonts.inter(color: Colors.white, fontSize: 11, height: 1.4)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: _selectedMcqOption == null
                          ? null
                          : () {
                              if (!_mcqAnswerSubmitted) {
                                setState(() => _mcqAnswerSubmitted = true);
                              } else {
                                if (_currentQuestionIndex < _reasoningQuestions.length - 1) {
                                  setState(() {
                                    _currentQuestionIndex++;
                                    _selectedMcqOption = null;
                                    _mcqAnswerSubmitted = false;
                                  });
                                } else {
                                  // Move to Stage 2: Practical Coding Compiler
                                  setState(() => _assessmentStage = 2);
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: Text(_mcqAnswerSubmitted ? 'Next Question ➔' : 'Submit Answer', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- STAGE 2: PRACTICAL CODING COMPILER ---
  Widget _buildPracticalCompilerScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Description & Challenge Prompt
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF111726), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF1E293B))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _pillBadge('PHASE 2: PRACTICE CODING', const Color(0xFF38BDF8)),
                      Text('WEB-DEV TRACK', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Find Target Sum Pairs', style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('Implement a function findPairSum(arr, target) that returns an array of all integer pairs from array "arr" whose sum equals the integer "target".', style: GoogleFonts.inter(color: const Color(0xFFCBD5E1), fontSize: 12, height: 1.4)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: const Color(0xFF1A2234), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sample: findPairSum([7, 15, 2, 9], 9) -> [[7, 2]]', style: GoogleFonts.firaCode(color: Colors.amber, fontSize: 11)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (_codeCompiledSuccessfully)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _assessmentStage = 3),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: Text('Lock Code & Proceed to Verbal Stage ➔', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),

          // Right Code Editor & Terminal
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF111726), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF1E293B))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MAIN.JS', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.bold)),
                      ElevatedButton.icon(
                        onPressed: _isCompiling
                            ? null
                            : () {
                                setState(() => _isCompiling = true);
                                Future.delayed(const Duration(milliseconds: 1200), () {
                                  setState(() {
                                    _isCompiling = false;
                                    _codeCompiledSuccessfully = true;
                                  });
                                });
                              },
                        icon: const Icon(Icons.play_arrow, size: 16),
                        label: Text(_isCompiling ? 'Compiling...' : 'Run Code Compiler', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E), foregroundColor: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF070A12), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF1E293B))),
                      child: TextField(
                        controller: _codeEditorController,
                        maxLines: null,
                        style: GoogleFonts.firaCode(color: Colors.greenAccent, fontSize: 12),
                        decoration: const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('TERMINAL OUTPUT:', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF070A12), borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        _isCompiling
                            ? 'Compiling code & running test assertions...'
                            : _codeCompiledSuccessfully
                                ? '> Sandbox compiler initialized. Ready for web-dev challenge execution.\n> Compiling main.script...\n> 3 sampling suite - PASSED.\n> [ [ 7, 2 ] ]\n> SUCCESS.'
                                : '> Sandbox compiler idle. Click "Run Code Compiler" to test execution.',
                        style: GoogleFonts.firaCode(color: _codeCompiledSuccessfully ? Colors.greenAccent : const Color(0xFF94A3B8), fontSize: 11),
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
  }

  // --- STAGE 3: VERBAL & CONCEPTUAL QUESTIONING ---
  Widget _buildVerbalAIChatScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF111726), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF1E293B))),
              child: Column(
                children: [
                  const CircleAvatar(radius: 40, backgroundColor: Color(0xFFFF6B35), child: Icon(Icons.smart_toy, size: 36, color: Colors.white)),
                  const SizedBox(height: 14),
                  Text('SOPHIA AI TEACHER', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF1A2234), borderRadius: BorderRadius.circular(14)),
                    child: Text(
                      'Awesome coding work! You\'ve earned 200 XP! Now, let me how you handle state management.',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 11, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(color: const Color(0xFF111726), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF1E293B))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _pillBadge('PHASE 3: VERBAL SYNTHESIS', Colors.purpleAccent),
                      Text('Sophia\'s Conceptual Question:', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '"How do you typically approach performance optimization and asynchronous task state handling in your applications?"',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                  Text('YOUR ANSWER INPUT', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: const Color(0xFF070A12), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF1E293B))),
                      child: TextField(
                        controller: _verbalAnswerController,
                        maxLines: null,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 12),
                        decoration: const InputDecoration(
                          hintText: 'Type your explanation here, or click the Microphone button on the left to dictate your answer aloud!',
                          hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => _assessmentStage = 4);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      child: Text('Submit Assessment & Generate Scorecard ➔', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- STAGE 4: SCORECARD & DETAILED REPORT ---
  Widget _buildFinalScorecardReportScreen() {
    return Center(
      child: Container(
        width: 750,
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: const Color(0xFF111726),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF222F43), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.verified, color: Colors.greenAccent, size: 28),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sophia\'s Detailed Level-Test Interview Report', style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Candidate: ${widget.userName} • WEB-DEV ASSESSMENT', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11)),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF1A2234), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Text('LOGICAL SCORE', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 9, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('35 / 100', style: GoogleFonts.inter(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text('Based on your interactive verbal technical screening and real-time execution in the built-in compiler, Sophia has synthesized your logical coding metrics and placed you in your level-wise paths.', style: GoogleFonts.inter(color: const Color(0xFFCBD5E1), fontSize: 12, height: 1.4)),
            const SizedBox(height: 24),

            // Metrics Progress Rows
            _scorecardMetricBar('Syntax Implementation Quality', 0.37),
            const SizedBox(height: 12),
            _scorecardMetricBar('Logical Complexity & Registers Optimization', 0.31),
            const SizedBox(height: 12),
            _scorecardMetricBar('Conceptual Depth (Sophia Questioning Grade)', 0.89),
            const SizedBox(height: 24),

            // Assessment Assessment Grade Note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Assessment Grade: 35%', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(height: 2),
                        Text('Sophia recommends a lower-level course path to reinforce programming fundamentals before advanced topics.', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Directs student to beginner track based on scorecard recommendation
                  widget.onAssessmentComplete('beginner');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text('Unlock Quantify AI Level Board & Path ➔', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scorecardMetricBar(String label, double val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            Text('${(val * 100).toInt()}%', style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(value: val, color: const Color(0xFFFF6B35), backgroundColor: const Color(0xFF1E293B), minHeight: 6),
      ],
    );
  }
}