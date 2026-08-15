import 'package:flutter/material.dart';

enum CourseStatus {
  ongoing,
  notStarted,
  completed,
  available,
}

// ============================================================
// MODULE MODEL
// ============================================================

class ModuleModel {
  final String title;
  final String duration;
  final int lessonsCount;

  const ModuleModel({
    required this.title,
    required this.duration,
    required this.lessonsCount,
  });
}

// ============================================================
// BRANCH FILTER
// ============================================================

class BranchFilter {
  final String label;
  final String code;
  final IconData icon;
  final int count;

  const BranchFilter({
    required this.label,
    required this.code,
    required this.icon,
    required this.count,
  });
}

// ============================================================
// COURSE MODEL
// ============================================================

class Course {
  final String id;

  final String title;

  final String branch;

  final String department;

  final String departmentCode;

  final String instructorName;

  final String instructorRole;

  final int lessons;

  final int lessonsCount;

  final String duration;

  final String difficulty;

  final double rating;

  final int studentsCount;

  final List<String> tags;

  final double progress;

  final CourseStatus status;

  final String type;

  final String category;

  final String techSnippet;

  final String description;

  final List<String> outcomes;

  final List<ModuleModel> modules;

  const Course({
    required this.id,
    required this.title,
    required this.branch,
    required this.department,
    required this.departmentCode,
    required this.instructorName,
    required this.instructorRole,
    required this.lessons,
    required this.lessonsCount,
    required this.duration,
    required this.difficulty,
    required this.rating,
    required this.studentsCount,
    required this.tags,
    required this.progress,
    required this.status,
    required this.type,
    required this.category,
    required this.techSnippet,
    required this.description,
    required this.outcomes,
    required this.modules,
  });

  // ==========================================================
  // FROM COURSE SUGGESTION
  // ==========================================================

  factory Course.fromSuggestionMap(
    String branchName,
    Map<String, String> data, [
    String? customId,
  ]) {
    final parsedTags = (data['tags'] ?? '')
        .split(RegExp(r'[,&]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // ----------------------------------------------------------
    // Department code
    // ----------------------------------------------------------

    String deptCode = 'GEN';

    if (branchName.contains('(') &&
        branchName.contains(')')) {
      deptCode = branchName.substring(
        branchName.indexOf('(') + 1,
        branchName.indexOf(')'),
      );
    } else if (branchName.contains('-')) {
      deptCode = branchName
          .split('-')
          .last
          .trim();
    }

    // ----------------------------------------------------------
    // Course title
    // ----------------------------------------------------------

    final title =
        data['title'] ?? 'Engineering Track';

    // ----------------------------------------------------------
    // ID
    // ----------------------------------------------------------

    final generatedId = title
        .toLowerCase()
        .replaceAll(
          RegExp(r'[^a-z0-9]+'),
          '_',
        )
        .replaceAll(
          RegExp(r'_+'),
          '_',
        )
        .replaceAll(
          RegExp(r'^_|_$'),
          '',
        );

    // ----------------------------------------------------------
    // Type
    // ----------------------------------------------------------

    final courseType =
        data['type'] ?? 'web';

    // ----------------------------------------------------------
    // Category
    // ----------------------------------------------------------

    final courseCategory =
        courseType.toUpperCase();

    // ----------------------------------------------------------
    // Technology snippet
    // ----------------------------------------------------------

    final techSnippet =
        parsedTags.isNotEmpty
            ? parsedTags.first
            : 'Engineering';

    return Course(
      id: customId ?? generatedId,

      title: title,

      branch: branchName,

      department: branchName,

      departmentCode: deptCode,

      instructorName:
          'Abhijeet Sahu',

      instructorRole:
          'Lead Engineering Mentor',

      lessons: 14,

      lessonsCount: 14,

      duration: '12h 30m',

      difficulty:
          'Intermediate to Advanced',

      rating: 4.9,

      studentsCount: 1840,

      tags: parsedTags,

      progress: 0.0,

      status:
          CourseStatus.available,

      type: courseType,

      category: courseCategory,

      techSnippet:
          techSnippet,

      description:
          'Master core concepts of $title tailored for $branchName students.',

      outcomes: [
        'Master core principles of $title with industry-standard practices',

        'Build real-world projects integrated with Next Gen LMS Sandbox',

        'Learn advanced optimization, state management, and architecture patterns',

        'Earn a Polygon Blockchain-verified completion certificate',
      ],

      modules: [
        ModuleModel(
          title:
              'Module 1: Foundations & Core Architecture of $title',
          duration: '3h 15m',
          lessonsCount: 4,
        ),

        ModuleModel(
          title:
              'Module 2: Advanced Implementation & Tooling',
          duration: '4h 00m',
          lessonsCount: 5,
        ),

        ModuleModel(
          title:
              'Module 3: Capstone Hands-On Project & Live Deployment',
          duration: '5h 15m',
          lessonsCount: 5,
        ),
      ],
    );
  }

  // ==========================================================
  // COPY WITH
  // ==========================================================

  Course copyWith({
    String? id,
    String? title,
    String? branch,
    String? department,
    String? departmentCode,
    String? instructorName,
    String? instructorRole,
    int? lessons,
    int? lessonsCount,
    String? duration,
    String? difficulty,
    double? rating,
    int? studentsCount,
    List<String>? tags,
    double? progress,
    CourseStatus? status,
    String? type,
    String? category,
    String? techSnippet,
    String? description,
    List<String>? outcomes,
    List<ModuleModel>? modules,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      branch: branch ?? this.branch,
      department: department ?? this.department,
      departmentCode:
          departmentCode ?? this.departmentCode,
      instructorName:
          instructorName ?? this.instructorName,
      instructorRole:
          instructorRole ?? this.instructorRole,
      lessons: lessons ?? this.lessons,
      lessonsCount:
          lessonsCount ?? this.lessonsCount,
      duration: duration ?? this.duration,
      difficulty:
          difficulty ?? this.difficulty,
      rating: rating ?? this.rating,
      studentsCount:
          studentsCount ?? this.studentsCount,
      tags: tags ?? this.tags,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      type: type ?? this.type,
      category: category ?? this.category,
      techSnippet:
          techSnippet ?? this.techSnippet,
      description:
          description ?? this.description,
      outcomes:
          outcomes ?? this.outcomes,
      modules:
          modules ?? this.modules,
    );
  }
}