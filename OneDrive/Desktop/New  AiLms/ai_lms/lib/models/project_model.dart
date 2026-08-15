class ProjectDeliverable {
  final String title;
  final bool isCompleted;

  ProjectDeliverable({required this.title, this.isCompleted = false});
}

class RoadmapStep {
  final String stepNumber;
  final String title;
  final String description;
  final String codeHint;
  final String tip;

  RoadmapStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.codeHint,
    required this.tip,
  });
}

class DebugIssue {
  final String title;
  final String rootCause;
  final String resolution;

  DebugIssue({
    required this.title,
    required this.rootCause,
    required this.resolution,
  });
}

class RubricItem {
  final String title;
  final String description;
  final int points;

  RubricItem({
    required this.title,
    required this.description,
    required this.points,
  });
}

class EngineeringProject {
  final String id;
  final String title;
  final String branchCode; // CSE, IT, ECE, EEE, ME, CE, CH, AE
  final String branchName;
  final String status; // IN PROGRESS, IN REVIEW, UNASSIGNED, NEEDS REVISION
  final String difficulty; // Intermediate, Advanced
  final String summary;
  final List<String> tags;
  final String dueDate;
  final String systemArchitecture;
  final List<ProjectDeliverable> deliverables;
  final List<String> techStack;
  final List<RoadmapStep> roadmap;
  final List<DebugIssue> debugIssues;
  final List<RubricItem> rubrics;
  final String initialCode;

  EngineeringProject({
    required this.id,
    required this.title,
    required this.branchCode,
    required this.branchName,
    required this.status,
    required this.difficulty,
    required this.summary,
    required this.tags,
    required this.dueDate,
    required this.systemArchitecture,
    required this.deliverables,
    required this.techStack,
    required this.roadmap,
    required this.debugIssues,
    required this.rubrics,
    required this.initialCode,
  });
}