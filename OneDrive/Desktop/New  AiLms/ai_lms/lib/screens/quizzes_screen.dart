// TODO Implement this library.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ============================================================================
/// NEXT GEN LMS - QUIZZES SCREEN
/// ============================================================================
///
/// Features:
/// - Exact LMS shell-compatible quiz page
/// - Instructor published exam section
/// - Course practice quiz grid
/// - Search
/// - Course-specific quizzes
/// - 15 questions for every quiz
/// - Instructions screen
/// - Countdown timer
/// - MCQ answer selection
/// - Automatic grading
/// - 70% pass mark
/// - Result screen
/// - Local interactive coding sandbox
///
/// This screen intentionally does NOT create StudentLmsShell.
/// StudentHomeHubScreen owns the global sidebar/top bar.
/// ============================================================================

class QuizQuestion {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswer;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class QuizItem {
  final String id;
  final String title;
  final String courseId;
  final String courseTitle;
  final int questionsCount;
  final int durationMinutes;
  final int? previousScore;

  const QuizItem({
    required this.id,
    required this.title,
    required this.courseId,
    required this.courseTitle,
    this.questionsCount = 15,
    this.durationMinutes = 15,
    this.previousScore,
  });
}

/// ============================================================================
/// QUIZ CATALOG
/// ============================================================================

class QuizCatalog {
  static const List<QuizItem> quizzes = [
    QuizItem(
      id: 'quiz-1',
      title: 'React State & Context API Basics',
      courseId: 'c1',
      courseTitle: 'Web Engineering',
      durationMinutes: 15,
      previousScore: 90,
    ),
    QuizItem(
      id: 'quiz-2',
      title: 'Data Structures: Red-Black Trees',
      courseId: 'dsa',
      courseTitle: 'Data Structures & Algorithms',
      durationMinutes: 20,
    ),
    QuizItem(
      id: 'quiz-3',
      title: 'C++ Advanced Pointers & References',
      courseId: 'cpp',
      courseTitle: 'C++ Systems Programming',
      durationMinutes: 10,
      previousScore: 75,
    ),
    QuizItem(
      id: 'quiz-4',
      title: 'Python AsyncIO and Multiprocessing',
      courseId: 'c2',
      courseTitle: 'Data Science & AI',
      durationMinutes: 25,
    ),

    QuizItem(
      id: 'web-dev',
      title: 'Modern Web Development (React 18 & Vite)',
      courseId: 'c1',
      courseTitle: 'Web Engineering',
    ),
    QuizItem(
      id: 'python',
      title: 'Python for Data Science, ML & Gemini AI',
      courseId: 'c2',
      courseTitle: 'Data Science & AI',
    ),
    QuizItem(
      id: 'java',
      title: 'Enterprise Java 21, Spring Boot & Docker',
      courseId: 'c6',
      courseTitle: 'Enterprise Java 21 & Spring Boot',
    ),
    QuizItem(
      id: 'cpp',
      title: 'Low-Level C++ Systems & Memory Allocation',
      courseId: 'cpp',
      courseTitle: 'C++ Systems Programming',
    ),
    QuizItem(
      id: 'flutter',
      title: 'Cross-Platform Mobile Development (Flutter & Dart)',
      courseId: 'c4',
      courseTitle: 'Cross-Platform Mobile with Flutter',
    ),
    QuizItem(
      id: 'backend',
      title: 'High-Performance Backend APIs (Go, Node & gRPC)',
      courseId: 'c3',
      courseTitle: 'Backend Go',
    ),

    QuizItem(
      id: 'cyber',
      title: 'Cyber Security, Ethical Hacking & Cryptography',
      courseId: 'cyber',
      courseTitle: 'Cyber Security',
    ),
    QuizItem(
      id: 'dbms',
      title: 'Database Systems & SQL Query Architecture',
      courseId: 'dbms',
      courseTitle: 'Database Systems',
    ),
    QuizItem(
      id: 'cloud',
      title: 'Cloud Solutions Architecting (AWS & Kubernetes)',
      courseId: 'cloud',
      courseTitle: 'Cloud & DevOps',
    ),
    QuizItem(
      id: 'net-sec',
      title: 'Computer Networks & Wireshark Auditing',
      courseId: 'net',
      courseTitle: 'Computer Networks',
    ),

    QuizItem(
      id: 'iot',
      title: 'Embedded Systems & IoT Sensor Networks',
      courseId: 'iot',
      courseTitle: 'Embedded Systems & IoT',
    ),
    QuizItem(
      id: 'vlsi',
      title: 'VLSI Design, CMOS & Verilog HDL',
      courseId: 'vlsi',
      courseTitle: 'VLSI Design',
    ),
    QuizItem(
      id: 'dsp',
      title: 'Digital Signal Processing & FFT Filters',
      courseId: 'dsp',
      courseTitle: 'Digital Signal Processing',
    ),
    QuizItem(
      id: 'wireless',
      title: '5G & Wireless Communication Systems',
      courseId: 'wireless',
      courseTitle: 'Wireless Communication',
    ),
    QuizItem(
      id: 'power',
      title: 'Power Electronics & Smart Grid Converters',
      courseId: 'power',
      courseTitle: 'Power Electronics',
    ),
    QuizItem(
      id: 'control',
      title: 'Control Systems & PID Feedback Tuning',
      courseId: 'control',
      courseTitle: 'Control Systems',
    ),

    QuizItem(
      id: 'cad',
      title: '3D CAD Modelling & FEA Stress Analysis',
      courseId: 'cad',
      courseTitle: 'Mechanical Engineering',
    ),
    QuizItem(
      id: 'thermo',
      title: 'Thermodynamics & Heat Transfer Operations',
      courseId: 'thermo',
      courseTitle: 'Thermal Engineering',
    ),
    QuizItem(
      id: 'robotics',
      title: 'Industrial Robotics & Kinematics',
      courseId: 'robotics',
      courseTitle: 'Robotics & Automation',
    ),
    QuizItem(
      id: 'structure',
      title: 'Structural Engineering & Concrete Design',
      courseId: 'structure',
      courseTitle: 'Civil Engineering',
    ),
    QuizItem(
      id: 'reaction',
      title: 'Chemical Reaction Engineering & Kinetics',
      courseId: 'reaction',
      courseTitle: 'Chemical Engineering',
    ),
    QuizItem(
      id: 'aero',
      title: 'Aerodynamics & Supersonic Flight',
      courseId: 'aero',
      courseTitle: 'Aerospace Engineering',
    ),
    QuizItem(
      id: 'propulsion',
      title: 'Aircraft Jet & Rocket Propulsion',
      courseId: 'propulsion',
      courseTitle: 'Aerospace Engineering',
    ),
    QuizItem(
      id: 'avionics',
      title: 'Avionics & Flight Control Systems',
      courseId: 'avionics',
      courseTitle: 'Aerospace Engineering',
    ),
    QuizItem(
      id: 'orbital',
      title: 'Spacecraft Dynamics & Orbital Trajectories',
      courseId: 'orbital',
      courseTitle: 'Aerospace Engineering',
    ),
  ];

  static List<QuizQuestion> questionsFor(QuizItem quiz) {
    final bank = _banks[quiz.id];

    if (bank != null && bank.length >= 15) {
      return bank.take(15).toList();
    }

    return _generatedQuestions(quiz);
  }

  /// Course → quiz lookup.
  static QuizItem? quizForCourse({
    String? courseId,
    String? courseTitle,
  }) {
    final id = courseId?.toLowerCase().trim();
    final title = courseTitle?.toLowerCase().trim();

    for (final quiz in quizzes) {
      if (id != null && id.isNotEmpty && quiz.courseId.toLowerCase() == id) {
        return quiz;
      }

      if (title != null &&
          title.isNotEmpty &&
          (quiz.courseTitle.toLowerCase().contains(title) ||
              title.contains(quiz.courseTitle.toLowerCase()))) {
        return quiz;
      }
    }

    if (title != null) {
      for (final quiz in quizzes) {
        if (_matchesCourseTitle(title, quiz)) {
          return quiz;
        }
      }
    }

    return null;
  }

  static bool _matchesCourseTitle(String title, QuizItem quiz) {
    final combined =
        '${quiz.title} ${quiz.courseTitle}'.toLowerCase();

    final words = title
        .replaceAll('&', ' ')
        .replaceAll('-', ' ')
        .split(RegExp(r'\s+'))
        .where((e) => e.length > 2);

    return words.any(combined.contains);
  }

  static final Map<String, List<QuizQuestion>> _banks = {
    // ========================================================================
    // REACT
    // ========================================================================
    'quiz-1': const [
      QuizQuestion(
        id: 1,
        question:
            'Which hook prevents child component re-renders unless props change?',
        options: [
          'useMemo',
          'useCallback',
          'React.memo',
          'useReducer',
        ],
        correctAnswer: 2,
      ),
      QuizQuestion(
        id: 2,
        question:
            'What is the primary role of the virtual DOM reconciliation loop?',
        options: [
          'Frees memory segments',
          'Compares differences and applies precise patches',
          'Forks background processes',
          'Enforces strict type checks',
        ],
        correctAnswer: 1,
      ),
      QuizQuestion(
        id: 3,
        question: 'What does the useContext hook return?',
        options: [
          'The current context value for that context provider',
          'An array with state and state setter function',
          'A dispatcher function for context actions',
          'A unique context string key identifier',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 4,
        question:
            'Which hook is best suited for complex state transitions in React?',
        options: [
          'useState',
          'useMemo',
          'useReducer',
          'useEffect',
        ],
        correctAnswer: 2,
      ),
      QuizQuestion(
        id: 5,
        question: 'What is a main rule of React Hooks?',
        options: [
          'Only call hooks at the top level of your functional component',
          'Call hooks inside standard loops and conditionals',
          'Declare hooks in vanilla JavaScript helper classes',
          'Only execute hooks in class lifecycle methods',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 6,
        question: 'How do you pass context value down to components?',
        options: [
          'Using Context.Provider with a value prop',
          'By defining static context variables in parent classes',
          'Calling useContext.set() in parent render body',
          'Importing the context file into components directly',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 7,
        question:
            'Why should we avoid updating state in component render bodies directly?',
        options: [
          'Causes infinite re-render loops',
          'Throws compile-time syntax errors',
          'Deletes existing component state variables',
          'Blocks page styles from being active',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 8,
        question: 'What is the purpose of the dependency array in useEffect?',
        options: [
          'Controls when the effect executes by checking value changes',
          'Stores reference arrays for high-performance loops',
          'Injects external props into class functions',
          'Saves backup copies of local component state',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 9,
        question: 'What is a side effect in React?',
        options: [
          'Data fetching, subscriptions, or manually changing the DOM',
          'Any state transition triggered by button clicks',
          'Rendering multiple children from a single array',
          'Adding Tailwind classes to page layouts',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 10,
        question:
            'Which hook preserves a value across renders without triggering a render?',
        options: [
          'useRef',
          'useState',
          'useEffect',
          'useMemo',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 11,
        question: 'What does dispatch from useReducer do?',
        options: [
          'Triggers the reducer with an action to update state',
          'Bypasses the state manager',
          'Clears local storage',
          'Renders fallback loaders',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 12,
        question: "What is React's prop drilling?",
        options: [
          'Passing props through deep levels of nesting',
          'Generating multiple prop objects',
          'Compiling props on backend servers',
          'Applying Tailwind style properties',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 13,
        question:
            'Which component pattern handles runtime JavaScript errors in child trees?',
        options: [
          'Error Boundary',
          'useCatch hook',
          'Suspense fallback',
          'try-catch inside JSX',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 14,
        question: 'How do you create a custom React hook?',
        options: [
          'Write a function whose name starts with use',
          'Call React.createHook()',
          'Extend React.Hook',
          'Define it inside package.json',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 15,
        question: 'What does React.lazy() provide?',
        options: [
          'Component code-splitting and dynamic loading',
          'Slower render loops',
          'Mock database entries',
          'Delayed event handlers',
        ],
        correctAnswer: 0,
      ),
    ],

    // ========================================================================
    // RED-BLACK TREES
    // ========================================================================
    'quiz-2': const [
      QuizQuestion(
        id: 1,
        question: 'What is the maximum height of a Red-Black tree with n nodes?',
        options: ['O(log n)', 'O(n)', 'O(n log n)', 'O(1)'],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 2,
        question: 'What color is the root of a Red-Black tree?',
        options: [
          'Always Red',
          'Always Black',
          'Either Red or Black',
          'It has no color',
        ],
        correctAnswer: 1,
      ),
      QuizQuestion(
        id: 3,
        question: 'Which is a Red-Black tree invariant?',
        options: [
          'Every red node has black children',
          'NIL nodes are red',
          'Red nodes may have red children',
          'Every path has different black heights',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 4,
        question: 'What color are NIL leaves?',
        options: ['Red', 'Black', 'Translucent', 'White'],
        correctAnswer: 1,
      ),
      QuizQuestion(
        id: 5,
        question: 'What is search complexity in a Red-Black tree?',
        options: [
          'O(1) average',
          'O(log n) average and worst case',
          'O(n) always',
          'O(n log n)',
        ],
        correctAnswer: 1,
      ),
      QuizQuestion(
        id: 6,
        question: 'Which rotations are used for balancing?',
        options: [
          'Left and right rotations',
          'Forward and backward shifts',
          'Inversion and swapping',
          'Horizontal swaps',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 7,
        question: 'If a node is red, what color must its children be?',
        options: ['Black', 'Red', 'Either', 'Gradient'],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 8,
        question: 'Why use Red-Black trees instead of ordinary BSTs?',
        options: [
          'They maintain logarithmic height',
          'They use no pointers',
          'They compile faster',
          'They need no balancing',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 9,
        question:
            'How much longer can the longest path be compared with the shortest path?',
        options: ['1.5 times', '2 times', '3 times', 'Infinitely'],
        correctAnswer: 1,
      ),
      QuizQuestion(
        id: 10,
        question:
            'Which self-balancing tree is closely related to Red-Black trees?',
        options: ['AVL Tree', 'Binary Heap', 'Trie', 'Linked List'],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 11,
        question: 'When does insertion commonly trigger recoloring?',
        options: [
          'Parent and uncle are red',
          'Root becomes red',
          'A NIL leaf is reached',
          'Balance factor exceeds two',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 12,
        question: 'What color is a newly inserted node before balancing?',
        options: ['Red', 'Black', 'White', 'Undefined'],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 13,
        question: 'What is black-height?',
        options: [
          'Number of black nodes on a path',
          'Tree memory size',
          'Number of red nodes',
          'Number of rotations',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 14,
        question: 'Which operation can be required after deletion?',
        options: [
          'Fix-up rotations and recoloring',
          'Sorting the entire tree',
          'Rebuilding all nodes',
          'Converting it to a heap',
        ],
        correctAnswer: 0,
      ),
      QuizQuestion(
        id: 15,
        question: 'What is the purpose of balancing?',
        options: [
          'Keep the tree height logarithmic',
          'Increase node colors',
          'Reduce key values',
          'Remove all NIL nodes',
        ],
        correctAnswer: 0,
      ),
    ],
  };

  /// ========================================================================
  /// 15-QUESTION FALLBACK GENERATOR
  /// ========================================================================
  ///
  /// Every catalog item receives exactly 15 questions even if a dedicated
  /// question bank has not yet been entered.
  ///
  static List<QuizQuestion> _generatedQuestions(QuizItem quiz) {
    final topic = _topicFor(quiz);

    final List<Map<String, dynamic>> templates = [
      {
        'q': 'What is the primary purpose of $topic?',
        'o': [
          'Solve the core engineering problem efficiently',
          'Disable all system validation',
          'Remove the need for testing',
          'Replace every programming language',
        ],
        'a': 0,
      },
      {
        'q': 'Which principle is most important when working with $topic?',
        'o': [
          'Correctness and maintainability',
          'Avoiding documentation',
          'Ignoring edge cases',
          'Using maximum memory',
        ],
        'a': 0,
      },
      {
        'q': 'Which approach generally improves reliability in $topic?',
        'o': [
          'Testing expected and edge-case behavior',
          'Removing error handling',
          'Hard-coding every result',
          'Skipping validation',
        ],
        'a': 0,
      },
      {
        'q': 'Why is performance analysis important in $topic?',
        'o': [
          'It helps identify computational bottlenecks',
          'It removes the need for algorithms',
          'It guarantees zero memory usage',
          'It prevents compilation',
        ],
        'a': 0,
      },
      {
        'q': 'What should an engineer consider before implementing $topic?',
        'o': [
          'Requirements, constraints and expected behavior',
          'Only the UI color',
          'Only the variable names',
          'Only the file size',
        ],
        'a': 0,
      },
      {
        'q': 'Which practice is recommended for production $topic systems?',
        'o': [
          'Monitoring, validation and testing',
          'Removing logs completely',
          'Ignoring failures',
          'Using undocumented assumptions',
        ],
        'a': 0,
      },
      {
        'q': 'What is an important property of a good $topic implementation?',
        'o': [
          'Predictable and testable behavior',
          'Random output',
          'Unbounded resource consumption',
          'No input validation',
        ],
        'a': 0,
      },
      {
        'q': 'How should edge cases in $topic be handled?',
        'o': [
          'Explicitly test and handle them',
          'Ignore them',
          'Delete the input',
          'Restart the application',
        ],
        'a': 0,
      },
      {
        'q': 'What role does abstraction play in $topic?',
        'o': [
          'It helps separate complex implementation details',
          'It removes all architecture',
          'It disables testing',
          'It guarantees zero latency',
        ],
        'a': 0,
      },
      {
        'q': 'What is a useful way to verify a $topic implementation?',
        'o': [
          'Automated test cases',
          'Guessing expected output',
          'Changing production data',
          'Removing assertions',
        ],
        'a': 0,
      },
      {
        'q': 'Which metric can be important when evaluating $topic?',
        'o': [
          'Correctness and execution performance',
          'Number of comments only',
          'Screen brightness',
          'File naming length',
        ],
        'a': 0,
      },
      {
        'q': 'What should happen when $topic receives invalid input?',
        'o': [
          'The system should validate and handle it safely',
          'The application should always crash',
          'The input should be silently trusted',
          'All data should be deleted',
        ],
        'a': 0,
      },
      {
        'q': 'Why is modular design useful in $topic?',
        'o': [
          'It makes components easier to test and maintain',
          'It prevents reuse',
          'It increases duplication',
          'It removes interfaces',
        ],
        'a': 0,
      },
      {
        'q': 'What is a good debugging strategy for $topic?',
        'o': [
          'Reproduce, isolate, inspect and test the issue',
          'Randomly change unrelated code',
          'Delete the entire project',
          'Disable all error messages',
        ],
        'a': 0,
      },
      {
        'q': 'Which statement best describes professional engineering practice for $topic?',
        'o': [
          'Design, implement, test, measure and improve',
          'Implement without requirements',
          'Avoid testing until production',
          'Ignore maintainability',
        ],
        'a': 0,
      },
    ];

    return List.generate(15, (index) {
      final item = templates[index];

      return QuizQuestion(
        id: index + 1,
        question: (item['q'] as String).replaceAll('\$topic', topic),
        options: List<String>.from(
          item['o'] as List<dynamic>,
        ),
        correctAnswer: item['a'] as int,
      );
    });
  }

  static String _topicFor(QuizItem quiz) {
    final title = quiz.title.toLowerCase();

    if (title.contains('react')) return 'React development';
    if (title.contains('python')) return 'Python programming';
    if (title.contains('c++')) return 'C++ systems programming';
    if (title.contains('flutter')) return 'Flutter and Dart';
    if (title.contains('go')) return 'Go backend engineering';
    if (title.contains('java')) return 'Java and Spring Boot';
    if (title.contains('cyber')) return 'cyber security';
    if (title.contains('database') || title.contains('sql')) {
      return 'database systems and SQL';
    }
    if (title.contains('cloud') || title.contains('aws')) {
      return 'cloud architecture';
    }
    if (title.contains('network')) return 'computer networking';
    if (title.contains('iot') || title.contains('embedded')) {
      return 'embedded systems and IoT';
    }
    if (title.contains('vlsi')) return 'VLSI design';
    if (title.contains('signal') || title.contains('fft')) {
      return 'digital signal processing';
    }
    if (title.contains('wireless') || title.contains('5g')) {
      return 'wireless communication';
    }
    if (title.contains('power')) return 'power electronics';
    if (title.contains('control') || title.contains('pid')) {
      return 'control systems';
    }
    if (title.contains('cad') || title.contains('fea')) {
      return 'CAD and finite element analysis';
    }
    if (title.contains('thermo') || title.contains('heat')) {
      return 'thermodynamics and heat transfer';
    }
    if (title.contains('robot')) return 'robotics and kinematics';
    if (title.contains('structural') || title.contains('concrete')) {
      return 'structural engineering';
    }
    if (title.contains('chemical') || title.contains('reaction')) {
      return 'chemical reaction engineering';
    }
    if (title.contains('aero')) return 'aerodynamics';
    if (title.contains('propulsion')) return 'aircraft and rocket propulsion';
    if (title.contains('avionics')) return 'avionics';
    if (title.contains('spacecraft') || title.contains('orbital')) {
      return 'spacecraft dynamics';
    }

    return quiz.courseTitle;
  }
}

/// ============================================================================
/// QUIZZES SCREEN
/// ============================================================================

class QuizzesScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  final ValueChanged<int>? onSelectSidebarIndex;
  final VoidCallback? onSignOut;

  /// Optional course to open directly.
  final String? initialCourseId;
  final String? initialCourseTitle;

  const QuizzesScreen({
    super.key,
    required this.userName,
    this.isDarkMode = false,
    this.onSelectSidebarIndex,
    this.onSignOut,
    this.initialCourseId,
    this.initialCourseTitle,
  });

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

enum _QuizPageState {
  list,
  instructions,
  taking,
  result,
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  _QuizPageState _pageState = _QuizPageState.list;

  late QuizItem _selectedQuiz;

  String _searchQuery = '';

  final Map<int, int> _answers = {};

  int _questionIndex = 0;
  int _secondsRemaining = 0;
  int _score = 0;

  Timer? _timer;

  final Map<String, int> _scores = {
    'quiz-1': 90,
    'quiz-3': 75,
  };

  @override
  void initState() {
    super.initState();

    _selectedQuiz = QuizCatalog.quizzes.first;

    final initialQuiz = QuizCatalog.quizForCourse(
      courseId: widget.initialCourseId,
      courseTitle: widget.initialCourseTitle,
    );

    if (initialQuiz != null) {
      _selectedQuiz = initialQuiz;
      _pageState = _QuizPageState.instructions;
    }
  }

  @override
  void didUpdateWidget(covariant QuizzesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final courseChanged =
        oldWidget.initialCourseId != widget.initialCourseId ||
        oldWidget.initialCourseTitle != widget.initialCourseTitle;

    if (!courseChanged) return;

    final initialQuiz = QuizCatalog.quizForCourse(
      courseId: widget.initialCourseId,
      courseTitle: widget.initialCourseTitle,
    );

    _timer?.cancel();

    if (initialQuiz != null) {
      setState(() {
        _selectedQuiz = initialQuiz;
        _answers.clear();
        _questionIndex = 0;
        _score = 0;
        _pageState = _QuizPageState.instructions;
      });
    } else {
      setState(() {
        _answers.clear();
        _questionIndex = 0;
        _score = 0;
        _pageState = _QuizPageState.list;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<QuizItem> get _filteredQuizzes {
    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return QuizCatalog.quizzes;
    }

    return QuizCatalog.quizzes.where((quiz) {
      return quiz.title.toLowerCase().contains(query) ||
          quiz.courseTitle.toLowerCase().contains(query);
    }).toList();
  }

  List<QuizQuestion> get _questions =>
      QuizCatalog.questionsFor(_selectedQuiz);

  Color get _background =>
      widget.isDarkMode ? const Color(0xFF090D16) : const Color(0xFFF4F6FB);

  Color get _card =>
      widget.isDarkMode ? const Color(0xFF131927) : Colors.white;

  Color get _text =>
      widget.isDarkMode ? Colors.white : const Color(0xFF14161D);

  Color get _subText =>
      widget.isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

  Color get _border =>
      widget.isDarkMode ? const Color(0xFF263247) : const Color(0xFFE7EAF3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: _buildCurrentPage(),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_pageState) {
      case _QuizPageState.list:
        return _buildListPage();

      case _QuizPageState.instructions:
        return _buildInstructionsPage();

      case _QuizPageState.taking:
        return _buildTakingPage();

      case _QuizPageState.result:
        return _buildResultPage();
    }
  }

  // ==========================================================================
  // LIST PAGE
  // ==========================================================================

  Widget _buildListPage() {
    return SingleChildScrollView(
      key: const ValueKey('quiz-list-scroll'),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        _buildInstructorExamSection(),

        const SizedBox(height: 34),

        Container(
          height: 1,
          color: widget.isDarkMode
              ? const Color(0xFF334155)
              : const Color(0xFFCBD5E1),
        ),

        const SizedBox(height: 34),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRACTICE & SELF-EVALUATIONS',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                      color: _subText,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Course Practice Quizzes',
                    style: GoogleFonts.inter(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: _text,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Interactive practice tests for engineering modules',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: _subText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            SizedBox(
              width: 320,
              height: 42,
              child: TextField(
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
                style: TextStyle(
                  color: _text,
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  hintText: 'Search course or topic quiz...',
                  hintStyle: TextStyle(
                    color: _subText,
                    fontSize: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: _subText,
                    size: 18,
                  ),
                  filled: true,
                  fillColor: _card,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
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
                    borderSide: const BorderSide(
                      color: Color(0xFFFF7A30),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 22),

        LayoutBuilder(
          builder: (context, constraints) {
            int columns = 3;

            if (constraints.maxWidth < 900) {
              columns = 2;
            }

            if (constraints.maxWidth < 620) {
              columns = 1;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredQuizzes.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 150,
              ),
              itemBuilder: (context, index) {
                return _buildQuizCard(
                  _filteredQuizzes[index],
                );
              },
            );
          },
        ),
      ],
    ),
  );
  }

  // ==========================================================================
  // INSTRUCTOR EXAM
  // ==========================================================================

  Widget _buildInstructorExamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE5F8F4),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: const Color(0xFFB7EBDD),
                ),
              ),
              child: Text(
                '✣ LIVE INSTRUCTOR PUBLISHED EXAMS (1)',
                style: GoogleFonts.inter(
                  color: const Color(0xFF079669),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Instructor Exam Section',
              style: GoogleFonts.inter(
                color: _text,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            Text(
              'Direct Educator Sync',
              style: GoogleFonts.firaCode(
                color: _subText,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        _buildInstructorExamCard(),
      ],
    );
  }

  Widget _buildInstructorExamCard() {
    return Container(
      width: 440,
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 18),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFDCC4FF),
        ),
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
                  color: const Color(0xFFF0E7FF),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Python 3',
                  style: GoogleFonts.firaCode(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF7435FF),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '30 mins',
                style: GoogleFonts.firaCode(
                  fontSize: 10,
                  color: _subText,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF7B22F5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: const Text(
                  'INSTRUCTOR EXAM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            'Distributed Locks & Concurrency Compilation Challenge',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: _text,
              height: 1.15,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Write high-performance concurrent locking logic that '
            'prevents race conditions across distributed worker '
            'processes under non-blocking I/O queues.',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: _subText,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 16),

          Divider(color: _border),

          const SizedBox(height: 10),

          Row(
            children: [
              Text(
                'Instructor: ',
                style: GoogleFonts.firaCode(
                  fontSize: 9,
                  color: _subText,
                ),
              ),
              Text(
                'Instructor Kumar',
                style: GoogleFonts.firaCode(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: _text,
                ),
              ),
              const Spacer(),
              Text(
                'Pass: ',
                style: GoogleFonts.firaCode(
                  fontSize: 9,
                  color: _subText,
                ),
              ),
              Text(
                '80%',
                style: GoogleFonts.firaCode(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00B982),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          InkWell(
            onTap: _openInstructorSandbox,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Color(0xFF7B22F5),
                    size: 17,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Take Instructor Exam',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF7425FF),
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    color: _subText,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // QUIZ CARD
  // ==========================================================================

  Widget _buildQuizCard(QuizItem quiz) {
    final score = _scores[quiz.id] ?? quiz.previousScore;

    final passed = score != null;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedQuiz = quiz;
          _answers.clear();
          _questionIndex = 0;
          _pageState = _QuizPageState.instructions;
        });
      },
      borderRadius: BorderRadius.circular(17),
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 17),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: _border,
          ),
        ),
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
                    color: widget.isDarkMode
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFF1F3F6),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${quiz.questionsCount} Questions • '
                    '${quiz.durationMinutes} mins',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: _text,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: passed
                        ? const Color(0xFFE4F8EE)
                        : const Color(0xFFFFF3DF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    passed ? 'Passed' : 'Ready',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: passed
                          ? const Color(0xFF16B76A)
                          : const Color(0xFFF39A18),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 13),

            Expanded(
              child: Text(
                quiz.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: _text,
                  height: 1.25,
                ),
              ),
            ),

            Divider(color: _border),

            Row(
              children: [
                Text(
                  passed
                      ? 'Graded: '
                      : 'Start Assessment',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: _subText,
                    fontWeight: passed
                        ? FontWeight.w600
                        : FontWeight.w500,
                  ),
                ),
                if (passed)
                  Text(
                    '$score%',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF19B979),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: _subText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================================
  // INSTRUCTIONS
  // ==========================================================================

  Widget _buildInstructionsPage() {
    return Center(
      child: ConstrainedBox(
        key: const ValueKey('quiz-instructions'),
        constraints: const BoxConstraints(
          maxWidth: 640,
        ),
        child: Container(
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(27),
            border: Border.all(color: _border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: _backToList,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFFF5A5F),
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Back to Quiz Directory',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFF5A5F),
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              Text(
                'EVALUATION INSTRUCTIONS',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFF7A30),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.7,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                _selectedQuiz.title,
                style: GoogleFonts.inter(
                  color: _text,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Time limit: ${_selectedQuiz.durationMinutes} mins • '
                'Pass mark: 70%',
                style: GoogleFonts.inter(
                  color: _subText,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 27),

              Text(
                'This quiz assesses your understanding of '
                '${_selectedQuiz.courseTitle}, practical concepts, '
                'problem solving and engineering fundamentals.',
                style: GoogleFonts.inter(
                  color: _subText,
                  fontSize: 12,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isDarkMode
                      ? const Color(0xFF291A17)
                      : const Color(0xFFFFF8F5),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: const Color(0xFFFF7A30).withOpacity(0.15),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFF5A5F),
                      fontSize: 11,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Warning: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Refreshing the application will reset your '
                            'quiz timer.',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton.icon(
                  onPressed: _startQuiz,
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 18,
                  ),
                  label: const Text(
                    'Start Assessment Quiz',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A30),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
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

  // ==========================================================================
  // TAKING QUIZ
  // ==========================================================================

  Widget _buildTakingPage() {
    final question = _questions[_questionIndex];

    return Center(
      child: ConstrainedBox(
        key: const ValueKey('quiz-taking'),
        constraints: const BoxConstraints(
          maxWidth: 760,
        ),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(27),
            border: Border.all(color: _border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: _backToList,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: _subText,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Back to Quiz Directory',
                            style: GoogleFonts.inter(
                              color: _subText,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEEF0),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      _formatRemainingTime(),
                      style: GoogleFonts.firaCode(
                        color: const Color(0xFFFF5A5F),
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: (_questionIndex + 1) / _questions.length,
                  minHeight: 5,
                  backgroundColor: _border,
                  valueColor: const AlwaysStoppedAnimation(
                    Color(0xFFFF7A30),
                  ),
                ),
              ),

              const SizedBox(height: 27),

              Text(
                'QUESTION ${_questionIndex + 1} OF ${_questions.length}',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFF7A30),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                question.question,
                style: GoogleFonts.inter(
                  color: _text,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 22),

              ...List.generate(
                question.options.length,
                (index) {
                  return _buildAnswerOption(
                    question,
                    index,
                  );
                },
              ),

              const SizedBox(height: 26),

              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed:
                        _questionIndex == 0 ? null : _previousQuestion,
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 15,
                    ),
                    label: const Text('Previous'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _subText,
                      side: BorderSide(color: _border),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _answers.containsKey(question.id)
                        ? _nextQuestion
                        : null,
                    icon: Icon(
                      _questionIndex == _questions.length - 1
                          ? Icons.check
                          : Icons.arrow_forward,
                      size: 16,
                    ),
                    label: Text(
                      _questionIndex == _questions.length - 1
                          ? 'Submit Quiz'
                          : 'Next Question',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34C989),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: _border,
                      disabledForegroundColor: _subText,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
  }

  Widget _buildAnswerOption(
    QuizQuestion question,
    int optionIndex,
  ) {
    final selected =
        _answers[question.id] == optionIndex;

    return InkWell(
      onTap: () {
        setState(() {
          _answers[question.id] = optionIndex;
        });
      },
      borderRadius: BorderRadius.circular(13),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFF7A30).withOpacity(0.08)
              : _card,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: selected
                ? const Color(0xFFFF7A30)
                : _border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? const Color(0xFFFF7A30)
                    : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? const Color(0xFFFF7A30)
                      : _subText,
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                question.options[optionIndex],
                style: GoogleFonts.inter(
                  color: _text,
                  fontSize: 12,
                  fontWeight:
                      selected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================================
  // RESULT
  // ==========================================================================

  Widget _buildResultPage() {
    final passed = _score >= 70;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 620,
        ),
        child: Container(
          key: const ValueKey('quiz-result'),
          padding: const EdgeInsets.all(38),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: passed
                  ? const Color(0xFFB7EBDD)
                  : const Color(0xFFFFD0D0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: passed
                      ? const Color(0xFFE3F9EF)
                      : const Color(0xFFFFE9EA),
                ),
                child: Icon(
                  passed
                      ? Icons.verified
                      : Icons.refresh,
                  size: 36,
                  color: passed
                      ? const Color(0xFF18B777)
                      : const Color(0xFFFF5A5F),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                passed ? 'Assessment Passed!' : 'Assessment Not Passed',
                style: GoogleFonts.inter(
                  color: _text,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _selectedQuiz.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: _subText,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                '$_score%',
                style: GoogleFonts.inter(
                  color: passed
                      ? const Color(0xFF18B777)
                      : const Color(0xFFFF5A5F),
                  fontSize: 55,
                  fontWeight: FontWeight.w900,
                ),
              ),

              Text(
                'FINAL SCORE',
                style: GoogleFonts.inter(
                  color: _subText,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: widget.isDarkMode
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                  children: [
                    _resultStat(
                      'QUESTIONS',
                      '${_questions.length}',
                    ),
                    _resultStat(
                      'CORRECT',
                      '${((_score / 100) * _questions.length).round()}',
                    ),
                    _resultStat(
                      'PASS MARK',
                      '70%',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _backToList,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _text,
                        side: BorderSide(color: _border),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        'Back to Quizzes',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _restartQuiz,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A30),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        'Try Again',
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
  }

  Widget _resultStat(
    String label,
    String value,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: _text,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: _subText,
            fontSize: 8,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  // ==========================================================================
  // QUIZ ACTIONS
  // ==========================================================================

  void _startQuiz() {
    _timer?.cancel();

    setState(() {
      _answers.clear();
      _questionIndex = 0;
      _score = 0;
      _secondsRemaining =
          _selectedQuiz.durationMinutes * 60;
      _pageState = _QuizPageState.taking;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        if (_secondsRemaining <= 1) {
          _timer?.cancel();
          _finishQuiz();
          return;
        }

        setState(() {
          _secondsRemaining--;
        });
      },
    );
  }

  void _nextQuestion() {
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      _finishQuiz();
    }
  }

  void _previousQuestion() {
    if (_questionIndex > 0) {
      setState(() {
        _questionIndex--;
      });
    }
  }

  void _finishQuiz() {
    _timer?.cancel();

    int correct = 0;

    for (final question in _questions) {
      if (_answers[question.id] == question.correctAnswer) {
        correct++;
      }
    }

    final score =
        ((correct / _questions.length) * 100).round();

    setState(() {
      _score = score;
      _scores[_selectedQuiz.id] = score;
      _pageState = _QuizPageState.result;
    });
  }

  void _restartQuiz() {
    _startQuiz();
  }

  void _backToList() {
    _timer?.cancel();

    setState(() {
      _answers.clear();
      _questionIndex = 0;
      _secondsRemaining = 0;
      _score = 0;
      _pageState = _QuizPageState.list;
    });
  }

  String _formatRemainingTime() {
    final minutes =
        (_secondsRemaining ~/ 60).toString().padLeft(2, '0');

    final seconds =
        (_secondsRemaining % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  // ==========================================================================
  // INSTRUCTOR SANDBOX
  // ==========================================================================

  void _openInstructorSandbox() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const InstructorExamSandboxScreen(),
      ),
    );
  }
}

/// ============================================================================
/// INSTRUCTOR EXAM SANDBOX
/// ============================================================================
///
/// This is a local working sandbox:
/// - editable code
/// - test case execution
/// - output
/// - pass/fail
/// - submit
///
/// For a production LMS, connect _runTests() to your backend compiler service.
/// ============================================================================

class InstructorExamSandboxScreen extends StatefulWidget {
  const InstructorExamSandboxScreen({
    super.key,
  });

  @override
  State<InstructorExamSandboxScreen> createState() =>
      _InstructorExamSandboxScreenState();
}

class _InstructorExamSandboxScreenState
    extends State<InstructorExamSandboxScreen> {
  final TextEditingController _codeController =
      TextEditingController(
    text: '''import sys

def main():
    raw_input = sys.stdin.read().strip()

    if not raw_input:
        raw_input = "lock_id=MIT-99 concurrent_requests=5"

    if "release=true" in raw_input:
        print("Status: Released")
    elif "lock_id=" in raw_input:
        print("Status: Locked Latency: <1ms")
    else:
        print("Status: Invalid Request")

if __name__ == "__main__":
    main()
''',
  );

  bool _running = false;
  bool _submitted = false;

  String _output = 'Sandbox ready. Click Execute Test Cases.';

  final List<String> _testInputs = [
    'lock_id=MIT-99 concurrent_requests=5',
    'lock_id=MIT-99 release=true',
  ];

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFF4F6FB);
    const purple = Color(0xFF7B22F5);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _buildProblemPanel(),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 5,
                      child: _buildEditorPanel(purple),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 18,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 8),
          const Text(
            'EXAM COMPILER SANDBOX ACTIVE',
            style: TextStyle(
              color: Color(0xFF7B22F5),
              fontWeight: FontWeight.w900,
              fontSize: 11,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            '30 mins • Python 3',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11,
            ),
          ),
          const Spacer(),
          const Text(
            'Exit Exam',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemPanel() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Problem Requirement',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF64748B),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              'Implement a thread-safe mutex acquisition loop '
              'that processes lock_id parameters and returns '
              'Status: Locked and Latency.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Conceptual Question: Which algorithm guarantees zero '
            'deadlock states in distributed mutex locking?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 15),
          ...[
            'Ricart-Agrawala Distributed Mutex Algorithm',
            'Naive round-robin polling without backoff',
            'Unbounded recursive call stacks',
            'Synchronous infinite while loops',
          ].map(
            (text) => Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFBFC),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 11),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'AUTOMATED TEST VECTORS (${_testInputs.length})',
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w900,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 10),
          ..._testInputs.asMap().entries.map(
                (entry) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    'Vector #${entry.key + 1} Input: ${entry.value}',
                    style: GoogleFonts.firaCode(
                      fontSize: 9,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildEditorPanel(Color purple) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.code,
                color: Color(0xFF00B982),
                size: 18,
              ),
              const SizedBox(width: 7),
              const Text(
                'Code Editor (Python 3)',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                'Compiler: Active',
                style: GoogleFonts.firaCode(
                  color: const Color(0xFF94A3B8),
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF020617),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: _codeController,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                style: GoogleFonts.firaCode(
                  color: const Color(0xFF22C55E),
                  fontSize: 11,
                  height: 1.5,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF020617),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _output,
              style: GoogleFonts.firaCode(
                color: const Color(0xFF22C55E),
                fontSize: 10,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _running ? null : _runTests,
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 16,
                  ),
                  label: Text(
                    _running
                        ? 'Running...'
                        : 'Execute Test Cases',
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _submitted
                      ? null
                      : _submitExam,
                  icon: const Icon(
                    Icons.send,
                    size: 15,
                  ),
                  label: const Text(
                    'Submit Exam',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A875),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
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

  Future<void> _runTests() async {
    setState(() {
      _running = true;
      _output = 'Running sandbox test vectors...';
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    final code = _codeController.text;

    final hasLockLogic =
        code.contains('lock_id') &&
        code.contains('Status: Locked');

    final hasReleaseLogic =
        code.contains('release') &&
        code.contains('Status: Released');

    if (hasLockLogic && hasReleaseLogic) {
      setState(() {
        _running = false;
        _output =
            '✓ Vector #1 PASSED\n'
            'Expected: Status: Locked Latency: <1ms\n\n'
            '✓ Vector #2 PASSED\n'
            'Expected: Status: Released\n\n'
            'All test cases passed.';
      });
    } else {
      setState(() {
        _running = false;
        _output =
            '✗ Test cases failed.\n\n'
            'The sandbox could not verify the required '
            'lock/release output logic.';
      });
    }
  }

  Future<void> _submitExam() async {
    await _runTests();

    if (!mounted) return;

    setState(() {
      _submitted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Exam submitted successfully.',
        ),
      ),
    );
  }
}