import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SophiaAIScreen extends StatefulWidget {
  final String userName;
  final String selectedCourseTitle;

  final VoidCallback onExit;
  final ValueChanged<String> onAssessmentComplete;

  /// Theme is owned by the main StudentHomeHub shell.
  final bool isDarkMode;
  final VoidCallback? onToggleDarkMode;

  const SophiaAIScreen({
    super.key,
    required this.userName,
    required this.selectedCourseTitle,
    required this.onExit,
    required this.onAssessmentComplete,
    this.isDarkMode = false,
    this.onToggleDarkMode,
  });

  @override
  State<SophiaAIScreen> createState() =>
      _SophiaAIScreenState();
}

class _SophiaAIScreenState
    extends State<SophiaAIScreen> {
  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color orange =
      Color(0xFFFF7A30);

  static const Color violet =
      Color(0xFF7C3AED);

  static const Color background =
      Color(0xFFF6F7FB);

  static const Color border =
      Color(0xFFE7EAF3);

  static const Color darkCard =
      Color(0xFF1B1E27);

  static const Color darkBackground =
      Color(0xFF12141B);

  // ==========================================================
  // STATE
  // ==========================================================

  int activeTab = 0;

  bool isThinking = false;

  bool isVideoAnalyzing = false;

  String? activeDiagram;

  String? activeVideo;

  // ==========================================================
  // CONTROLLERS
  // ==========================================================

  final TextEditingController questionController =
      TextEditingController();

  final TextEditingController youtubeController =
      TextEditingController();

  final ScrollController chatScrollController =
      ScrollController();

  // ==========================================================
  // CHAT
  // ==========================================================

  final List<_SophiaMessage> messages = [];

  // ==========================================================
  // PREBUILT VISUAL DIAGRAMS
  // ==========================================================

  final List<_DiagramData> diagrams = [
    _DiagramData(
      category: 'Web Development',
      title: 'How an API Request Works',
      diagram: '''
[ USER ]
    |
    v
[ FRONTEND ]
    |
    | HTTP Request
    v
[ API SERVER ]
    |
    v
[ DATABASE ]
    |
    | Response
    v
[ FRONTEND ]
    |
    v
[ USER ]
''',
      explanation:
          'An API acts as a communication bridge between '
          'the application and the server.',
    ),

    _DiagramData(
      category: 'Programming',
      title: 'Recursion Flow',
      diagram: '''
        [ FUNCTION CALL ]
                |
                v
        [ BASE CONDITION? ]
           /          \\
         YES           NO
          |             |
          v             v
       RETURN      CALL FUNCTION
                        |
                        v
                 [ SMALLER INPUT ]
                        |
                        └───────┐
                                |
                                v
                         [ BASE CASE ]
''',
      explanation:
          'Recursion means a function calls itself with a '
          'smaller version of the original problem.',
    ),

    _DiagramData(
      category: 'Artificial Intelligence',
      title: 'Machine Learning Pipeline',
      diagram: '''
[ DATA ]
   |
   v
[ CLEANING ]
   |
   v
[ FEATURES ]
   |
   v
[ TRAIN MODEL ]
   |
   v
[ EVALUATION ]
   |
   v
[ PREDICTION ]
''',
      explanation:
          'A machine-learning system learns patterns from '
          'prepared data and uses those patterns to predict.',
    ),

    _DiagramData(
      category: 'Computer Science',
      title: 'Database Query Flow',
      diagram: '''
[ APPLICATION ]
       |
       v
[ SQL QUERY ]
       |
       v
[ DATABASE ENGINE ]
       |
       v
[ TABLES / INDEX ]
       |
       v
[ RESULT ]
       |
       v
[ APPLICATION ]
''',
      explanation:
          'A database engine receives a query, searches '
          'stored information and returns the result.',
    ),
  ];

  // ==========================================================
  // VIDEO LIBRARY
  // ==========================================================

  final List<_VideoData> videos = [
    _VideoData(
      title: 'Programming Fundamentals',
      category: 'Programming',
      level: 'Beginner',
      youtubeUrl:
          'https://www.youtube.com/results?search_query=programming+fundamentals',
    ),
    _VideoData(
      title: 'Data Structures & Algorithms',
      category: 'DSA',
      level: 'Intermediate',
      youtubeUrl:
          'https://www.youtube.com/results?search_query=data+structures+algorithms',
    ),
    _VideoData(
      title: 'Machine Learning Basics',
      category: 'AI / ML',
      level: 'Beginner',
      youtubeUrl:
          'https://www.youtube.com/results?search_query=machine+learning+basics',
    ),
    _VideoData(
      title: 'React & Modern Web Development',
      category: 'Web Development',
      level: 'Intermediate',
      youtubeUrl:
          'https://www.youtube.com/results?search_query=react+web+development',
    ),
    _VideoData(
      title: 'Python for Data Science',
      category: 'Data Science',
      level: 'Beginner',
      youtubeUrl:
          'https://www.youtube.com/results?search_query=python+data+science',
    ),
    _VideoData(
      title: 'SQL & Database Fundamentals',
      category: 'Database',
      level: 'Beginner',
      youtubeUrl:
          'https://www.youtube.com/results?search_query=sql+database+fundamentals',
    ),
  ];

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();

    messages.add(
      _SophiaMessage(
        isUser: false,
        text:
            '👋 Hello ${widget.userName}! I am Sophia, '
            'your AI learning tutor.\n\n'
            'Ask me any technical question and I can '
            'break it down into a simple explanation, '
            'visual flow, examples and recommended '
            'learning videos.',
      ),
    );
  }

  @override
  void dispose() {
    questionController.dispose();
    youtubeController.dispose();
    chatScrollController.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final bg = widget.isDarkMode ? darkBackground : background;

    return Container(
      color: bg,
      child: _buildSophiaWorkspace(),
    );
  }

  // ==========================================================
  // SIDEBAR
  // ==========================================================

  // ==========================================================
  // SOPHIA WORKSPACE
  // ==========================================================

  Widget _buildSophiaWorkspace() {
    final text = widget.isDarkMode
        ? Colors.white
        : const Color(0xFF111827);

    final sub = widget.isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'AI Tutor Workspace',
            style: TextStyle(
              color: text,
              fontSize: 21,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'Learn through conversation, visuals and curated videos.',
            style: TextStyle(
              color: sub,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 16),

          _buildMainTabs(),

          const SizedBox(height: 14),

          Expanded(
            child: IndexedStack(
              index: activeTab,
              children: [
                _buildChatTab(),
                _buildVisualizationTab(),
                _buildYoutubeTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MAIN TABS
  // ==========================================================

  Widget _buildMainTabs() {
    final labels = [
      '💬 Interactive Tutor Chat',
      '📊 Visual Diagrams & Flowcharts',
      '📺 YouTube Video Learning Hub',
    ];

    return SingleChildScrollView(
      scrollDirection:
          Axis.horizontal,
      child: Row(
        children:
            List.generate(
          labels.length,
          (index) {
            final selected =
                activeTab == index;

            return Padding(
              padding:
                  const EdgeInsets.only(
                right: 8,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    activeTab = index;
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
                    horizontal: 15,
                    vertical: 11,
                  ),
                  decoration:
                      BoxDecoration(
                    color: selected
                        ? orange
                        : (widget.isDarkMode
                            ? darkCard
                            : Colors.white),
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                    border: Border.all(
                      color: selected
                          ? orange
                          : (widget.isDarkMode
                              ? const Color(
                                  0xFF262A34,
                                )
                              : border),
                    ),
                    boxShadow:
                        selected
                            ? [
                                BoxShadow(
                                  color: orange
                                      .withOpacity(
                                    .18,
                                  ),
                                  blurRadius:
                                      10,
                                  offset:
                                      const Offset(
                                    0,
                                    4,
                                  ),
                                ),
                              ]
                            : null,
                  ),
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : (widget.isDarkMode
                              ? Colors.white
                              : const Color(
                                  0xFF475569,
                                )),
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // CHAT TAB
  // ==========================================================

  Widget _buildChatTab() {
    final card = widget.isDarkMode
        ? darkCard
        : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF262A34)
              : border,
        ),
      ),
      child: Column(
        children: [
          // ----------------------------------------------------
          // CHAT HEADER
          // ----------------------------------------------------

          Container(
            padding:
                const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? const Color(
                      0xFF12141B,
                    )
                  : const Color(
                      0xFFF8F9FC,
                    ),
              border: Border(
                bottom: BorderSide(
                  color: widget.isDarkMode
                      ? const Color(
                          0xFF262A34,
                        )
                      : border,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration:
                      const BoxDecoration(
                    gradient:
                        LinearGradient(
                      colors: [
                        violet,
                        Color(0xFF4F46E5),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.all(
                      Radius.circular(9),
                    ),
                  ),
                  child: const Icon(
                    Icons.smart_toy_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),

                const SizedBox(width: 10),

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sophia AI Tutor',
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? Colors.white
                            : const Color(
                                0xFF111827,
                              ),
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Visual & Video Mode Enabled',
                      style: TextStyle(
                        color:
                            Colors.grey.shade500,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                IconButton(
                  tooltip: 'Clear chat',
                  onPressed: () {
                    setState(() {
                      messages.clear();

                      messages.add(
                        _SophiaMessage(
                          isUser: false,
                          text:
                              '👋 Chat cleared. What would you like to learn?',
                        ),
                      );
                    });
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color:
                        Colors.grey.shade500,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),

          // ----------------------------------------------------
          // MESSAGES
          // ----------------------------------------------------

          Expanded(
            child: ListView.builder(
              controller:
                  chatScrollController,
              padding:
                  const EdgeInsets.all(18),
              itemCount:
                  messages.length +
                      (isThinking ? 1 : 0),
              itemBuilder:
                  (context, index) {
                if (index >=
                    messages.length) {
                  return _buildThinking();
                }

                return _buildMessage(
                  messages[index],
                );
              },
            ),
          ),

          // ----------------------------------------------------
          // QUICK PROMPTS
          // ----------------------------------------------------

          if (messages.length <= 1)
            _buildQuickPrompts(),

          // ----------------------------------------------------
          // INPUT
          // ----------------------------------------------------

          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildMessage(
    _SophiaMessage message,
  ) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints:
            const BoxConstraints(
          maxWidth: 760,
        ),
        margin:
            const EdgeInsets.only(
          bottom: 14,
        ),
        padding:
            const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser
              ? orange
              : (widget.isDarkMode
                  ? const Color(
                      0xFF242735,
                    )
                  : const Color(
                      0xFFF7F8FC,
                    )),
          borderRadius:
              BorderRadius.circular(
            16,
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser
                ? Colors.white
                : (widget.isDarkMode
                    ? Colors.white
                    : const Color(
                        0xFF374151,
                      )),
            fontSize: 12,
            height: 1.55,
          ),
        ),
      ),
    );
  }

  Widget _buildThinking() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? const Color(0xFF242735)
              : const Color(0xFFF7F8FC),
          borderRadius:
              BorderRadius.circular(14),
        ),
        child: const Row(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            SizedBox(
              width: 15,
              height: 15,
              child:
                  CircularProgressIndicator(
                strokeWidth: 2,
                color: violet,
              ),
            ),
            SizedBox(width: 9),
            Text(
              'Sophia is thinking...',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPrompts() {
    final prompts = [
      'Explain recursion like I am a beginner',
      'Explain how an API works',
      'Visualize a machine learning pipeline',
      'Give me a roadmap to learn Python',
    ];

    return SizedBox(
      height: 45,
      child: ListView.builder(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        scrollDirection:
            Axis.horizontal,
        itemCount: prompts.length,
        itemBuilder:
            (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(
              right: 7,
            ),
            child: ActionChip(
              label: Text(
                prompts[index],
                style:
                    const TextStyle(
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              onPressed: () {
                questionController.text =
                    prompts[index];
                _sendQuestion();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding:
          const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: widget.isDarkMode
                ? const Color(
                    0xFF262A34,
                  )
                : border,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller:
                  questionController,
              maxLines: 3,
              minLines: 1,
              onSubmitted: (_) {
                _sendQuestion();
              },
              decoration:
                  InputDecoration(
                hintText:
                    'Ask Sophia anything...',
                hintStyle:
                    TextStyle(
                  fontSize: 11,
                  color:
                      Colors.grey.shade500,
                ),
                filled: true,
                fillColor:
                    widget.isDarkMode
                        ? const Color(
                            0xFF12141B,
                          )
                        : const Color(
                            0xFFF8F9FC,
                          ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    13,
                  ),
                  borderSide:
                      BorderSide(
                    color:
                        widget.isDarkMode
                            ? const Color(
                                0xFF262A34,
                              )
                            : border,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 9),

          Container(
            decoration:
                const BoxDecoration(
              color: orange,
              borderRadius:
                  BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: IconButton(
              onPressed: isThinking
                  ? null
                  : _sendQuestion,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SEND QUESTION
  // ==========================================================

  Future<void> _sendQuestion() async {
    final question =
        questionController.text.trim();

    if (question.isEmpty ||
        isThinking) {
      return;
    }

    setState(() {
      messages.add(
        _SophiaMessage(
          isUser: true,
          text: question,
        ),
      );

      questionController.clear();

      isThinking = true;
    });

    await Future.delayed(
      const Duration(
        milliseconds: 850,
      ),
    );

    if (!mounted) return;

    final reply =
        _generateExplanation(question);

    setState(() {
      isThinking = false;

      messages.add(
        _SophiaMessage(
          isUser: false,
          text: reply,
        ),
      );
    });

    _scrollChat();

    // Automatically prepare visualization
    // when the user asks for a visual explanation.
    final lower =
        question.toLowerCase();

    if (lower.contains('visual') ||
        lower.contains('diagram') ||
        lower.contains('flowchart')) {
      setState(() {
        activeTab = 1;
      });
    }
  }

  void _scrollChat() {
    Future.delayed(
      const Duration(
        milliseconds: 80,
      ),
      () {
        if (!mounted) return;

        if (chatScrollController
            .hasClients) {
          chatScrollController.animateTo(
            chatScrollController
                .position.maxScrollExtent,
            duration:
                const Duration(
              milliseconds: 250,
            ),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  String _generateExplanation(
    String question,
  ) {
    final lower =
        question.toLowerCase();

    if (lower.contains('recursion')) {
      return '''
🌟 SIMPLE EXPLANATION

Recursion means a function solves a problem by calling itself with a smaller version of that problem.

Think about standing between two mirrors. You see another smaller reflection, which creates another reflection, and so on.

📌 The important parts:

1. Start with a problem.
2. Check the BASE CASE.
3. If the base case is not reached, call the function again.
4. Give it a smaller problem.
5. Eventually the base case stops the recursion.

📊 VISUAL FLOW

Problem
   ↓
Base Case?
   ↓ No
Smaller Problem
   ↓
Recursive Call
   ↓
Base Case
   ↓
Return

💡 Ask me to "visualize recursion" and I'll open the Visual Diagrams section.
''';
    }

    if (lower.contains('api')) {
      return '''
🌟 SIMPLE EXPLANATION

An API is like a waiter in a restaurant.

You tell the waiter what you want.
The waiter sends your request to the kitchen.
The kitchen prepares the result.
The waiter brings the result back.

📊

Frontend
   ↓
API Request
   ↓
Backend
   ↓
Database
   ↓
Backend
   ↓
API Response
   ↓
Frontend

For example:

GET /users/123

The frontend asks the API for user 123 and receives the user's information.

💡 You can now open Visual Diagrams to see the API flow.
''';
    }

    if (lower.contains('machine learning') ||
        lower.contains('ml')) {
      return '''
🌟 SIMPLE EXPLANATION

Machine Learning allows a computer to learn patterns from data instead of being explicitly programmed for every decision.

The basic process is:

DATA
 ↓
CLEAN DATA
 ↓
FEATURES
 ↓
TRAIN MODEL
 ↓
EVALUATE
 ↓
PREDICT

Example:

If we give a model thousands of house records containing size and price, it can learn the relationship between them and predict the price of a new house.

📌 Important concepts:

• Dataset
• Features
• Model
• Training
• Testing
• Prediction
''';
    }

    return '''
🌟 SOPHIA'S EXPLANATION

You asked:

"$question"

Let's break the concept into smaller pieces.

1. First understand the basic definition.
2. Identify the important components.
3. Understand how those components interact.
4. Connect the concept to a real-world example.
5. Practice with a small example.

📊 VISUAL LEARNING

I can convert this concept into a flowchart and step-by-step visual explanation.

📺 VIDEO LEARNING

You can also paste a YouTube learning video in the YouTube Learning Hub and Sophia can prepare a learning brief from the information available to the app.

💡 Try asking:
"Explain this like I'm a beginner"
or
"Visualize this concept".
''';
  }

  // ==========================================================
  // VISUALIZATION TAB
  // ==========================================================

  Widget _buildVisualizationTab() {
    final text = widget.isDarkMode
        ? Colors.white
        : const Color(0xFF111827);

    final sub = widget.isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(
                colors: [
                  violet.withOpacity(.12),
                  orange.withOpacity(.08),
                ],
              ),
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
              border: Border.all(
                color:
                    violet.withOpacity(.18),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_tree_outlined,
                  color: violet,
                  size: 25,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visual Diagrams & Flowcharts',
                        style: TextStyle(
                          color: text,
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Turn complex concepts into visual learning maps.',
                        style: TextStyle(
                          color: sub,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          if (activeDiagram != null)
            _buildActiveDiagram(),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 440,
              mainAxisExtent: 310,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount:
                diagrams.length,
            itemBuilder:
                (context, index) {
              return _buildDiagramCard(
                diagrams[index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDiagramCard(
    _DiagramData diagram,
  ) {
    final text = widget.isDarkMode
        ? Colors.white
        : const Color(0xFF111827);

    final sub = widget.isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Container(
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? darkCard
            : Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF262A34)
              : border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFF3E8FF,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    6,
                  ),
                ),
                child: Text(
                  diagram.category
                      .toUpperCase(),
                  style:
                      const TextStyle(
                    color: violet,
                    fontSize: 8,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),

              const Spacer(),

              IconButton(
                onPressed: () {
                  setState(() {
                    activeDiagram =
                        diagram.title;
                  });
                },
                icon: Icon(
                  Icons
                      .fullscreen_outlined,
                  size: 17,
                  color:
                      Colors.grey.shade500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            diagram.title,
            style: TextStyle(
              color: text,
              fontSize: 13,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(
                color: const Color(
                  0xFF1E1E2E,
                ),
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),
              child: SingleChildScrollView(
                child: Text(
                  diagram.diagram,
                  style:
                      const TextStyle(
                    color:
                        Color(0xFF34D399),
                    fontFamily:
                        'monospace',
                    fontSize: 9,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            diagram.explanation,
            maxLines: 2,
            overflow:
                TextOverflow.ellipsis,
            style: TextStyle(
              color: sub,
              fontSize: 9,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 9),

          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    questionController
                            .text =
                        'Explain the "${diagram.title}" diagram using a simple analogy for beginners';

                    setState(() {
                      activeTab = 0;
                    });

                    _sendQuestion();
                  },
                  icon: const Icon(
                    Icons.smart_toy_outlined,
                    size: 15,
                  ),
                  label: const Text(
                    'Ask Sophia',
                    style:
                        TextStyle(
                      fontSize: 9,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      activeTab = 2;
                    });
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 15,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Watch Video',
                    style:
                        TextStyle(
                      fontSize: 9,
                      color: Colors.red,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDiagram() {
    final diagram =
        diagrams.firstWhere(
      (d) => d.title == activeDiagram,
      orElse: () => diagrams.first,
    );

    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? darkCard
            : Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: violet.withOpacity(.35),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_tree,
                color: violet,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  diagram.title,
                  style:
                      const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    activeDiagram = null;
                  });
                },
                icon: const Icon(
                  Icons.close,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(20),
            decoration:
                const BoxDecoration(
              color: Color(0xFF1E1E2E),
              borderRadius:
                  BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            child: Text(
              diagram.diagram,
              style:
                  const TextStyle(
                color:
                    Color(0xFF34D399),
                fontFamily:
                    'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // YOUTUBE TAB
  // ==========================================================

  Widget _buildYoutubeTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(
                colors: [
                  Colors.red
                      .withOpacity(.08),
                  orange.withOpacity(.08),
                ],
              ),
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
              border: Border.all(
                color: Colors.red
                    .withOpacity(.16),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons
                      .ondemand_video_outlined,
                  color: Colors.red,
                  size: 27,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YouTube Video Learning Hub',
                        style:
                            TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Paste a learning video and get a concise learning brief.',
                        style:
                            TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _buildYoutubeAnalyzer(),

          const SizedBox(height: 24),

          const Text(
            'Suggested Video Library',
            style: TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 330,
              mainAxisExtent: 170,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount:
                videos.length,
            itemBuilder:
                (context, index) {
              return _buildVideoCard(
                videos[index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildYoutubeAnalyzer() {
    return Container(
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? darkCard
            : Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF262A34)
              : border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Analyze Your Learning Video',
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Paste the YouTube URL below.',
            style: TextStyle(
              color:
                  Colors.grey.shade500,
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 13),

          TextField(
            controller:
                youtubeController,
            decoration:
                InputDecoration(
              hintText:
                  'https://www.youtube.com/watch?v=...',
              prefixIcon:
                  const Icon(
                Icons.link,
                size: 18,
              ),
              filled: true,
              fillColor:
                  widget.isDarkMode
                      ? const Color(
                          0xFF12141B,
                        )
                      : const Color(
                          0xFFF8F9FC,
                        ),
              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed:
                    isVideoAnalyzing
                        ? null
                        : _analyzeYoutube,
                icon: isVideoAnalyzing
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color:
                              Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.auto_awesome,
                        size: 16,
                      ),
                label: Text(
                  isVideoAnalyzing
                      ? 'Analyzing...'
                      : 'Analyze Video',
                ),
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      orange,
                  foregroundColor:
                      Colors.white,
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 17,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _analyzeYoutube() async {
    final url =
        youtubeController.text.trim();

    if (url.isEmpty) {
      _showMessage(
        'Please paste a YouTube URL.',
      );
      return;
    }

    if (!url.contains(
          'youtube.com',
        ) &&
        !url.contains(
          'youtu.be',
        )) {
      _showMessage(
        'Please enter a valid YouTube URL.',
      );
      return;
    }

    setState(() {
      isVideoAnalyzing = true;
    });

    await Future.delayed(
      const Duration(
        milliseconds: 1200,
      ),
    );

    if (!mounted) return;

    setState(() {
      isVideoAnalyzing = false;
    });

    _showVideoBrief(url);
  }

  void _showVideoBrief(String url) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: violet,
              ),
              SizedBox(width: 8),
              Text(
                'Sophia Video Brief',
              ),
            ],
          ),
          content:
              const SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Learning Summary',
                  style:
                      TextStyle(
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sophia has received your video link. '
                  'The production version can send the URL '
                  'to your backend/video-transcript service '
                  'to extract the title, transcript, topics '
                  'and key takeaways.',
                ),
                SizedBox(height: 16),
                Text(
                  'Suggested learning flow:',
                  style:
                      TextStyle(
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '• Watch the introduction\n'
                  '• Identify the main concept\n'
                  '• Review the important examples\n'
                  '• Ask Sophia questions\n'
                  '• Complete a short practice task',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text('Close'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(
                  context,
                );
                _openUrl(url);
              },
              icon: const Icon(
                Icons.play_arrow,
              ),
              label:
                  const Text(
                'Watch Video',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVideoCard(
    _VideoData video,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? darkCard
            : Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF262A34)
              : border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFFFFEEF0),
                  borderRadius:
                      BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons
                      .play_circle_outline,
                  color: Colors.red,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  video.title,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            children: [
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
                      const Color(
                    0xFFF1F5F9,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    6,
                  ),
                ),
                child: Text(
                  video.level,
                  style:
                      const TextStyle(
                    fontSize: 8,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: 7),

              Text(
                video.category,
                style:
                    TextStyle(
                  fontSize: 9,
                  color:
                      Colors.grey.shade500,
                ),
              ),

              const Spacer(),

              TextButton.icon(
                onPressed: () {
                  _openUrl(
                    video.youtubeUrl,
                  );
                },
                icon:
                    const Icon(
                  Icons.play_arrow,
                  size: 15,
                ),
                label:
                    const Text(
                  'Watch',
                  style:
                      TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // HELPERS
  // ==========================================================

  Future<void> _openUrl(
    String url,
  ) async {
    final uri =
        Uri.tryParse(url);

    if (uri == null) return;

    try {
      await launchUrl(
        uri,
        mode:
            LaunchMode.externalApplication,
      );
    } catch (_) {
      _showMessage(
        'Unable to open the video.',
      );
    }
  }

  void _showMessage(
    String text,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}

// ============================================================
// MESSAGE MODEL
// ============================================================

class _SophiaMessage {
  final bool isUser;
  final String text;

  const _SophiaMessage({
    required this.isUser,
    required this.text,
  });
}

// ============================================================
// DIAGRAM MODEL
// ============================================================

class _DiagramData {
  final String category;
  final String title;
  final String diagram;
  final String explanation;

  const _DiagramData({
    required this.category,
    required this.title,
    required this.diagram,
    required this.explanation,
  });
}

// ============================================================
// VIDEO MODEL
// ============================================================

class _VideoData {
  final String title;
  final String category;
  final String level;
  final String youtubeUrl;

  const _VideoData({
    required this.title,
    required this.category,
    required this.level,
    required this.youtubeUrl,
  });
}
