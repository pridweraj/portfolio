import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF070A13); // Even deeper black/navy
  static const Color cardBg = Color(0xFF131A2E); // Vibrant dark card
  static const Color primary = Color(0xFF00F0FF); // Cyber Neon Cyan
  static const Color secondary = Color(0xFFBD00FF); // Cyber Neon Purple
  static const Color accent = Color(0xFFFF007A); // Cyber Neon Pink
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color navHighlight = Color(0xFF39FF14); // Neon Green
}

class DeveloperData {
  static const String name = "pridweraj.a";
  static const String title = "Flutter Developer";
  static const String subtitle = "Enthusiastic Fresher | Building high-performance, beautiful cross-platform applications.";
  
  static const String bio = "As a passionate and detail-oriented Fresher in Flutter development, I specialize in crafting clean, pixel-perfect user interfaces and smooth cross-platform experiences. Equipped with solid fundamentals in Dart and Node.js, I love translating creative concepts into interactive, production-ready apps. I am a fast learner and motivated problem solver, eager to bring positive energy, dedication, and clean code to a forward-thinking development team.";

  static const String resumeUrl = "https://example.com/resume.pdf";
  
  static const String githubUrl = "https://github.com/pridweraj";
  static const String linkedinUrl = "https://linkedin.com";
  static const String emailUrl = "mailto:pridweraj.a@example.com";
  static const String twitterUrl = "https://twitter.com";

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: "Core Technologies",
      skills: [
        SkillItem(name: "Flutter", level: 0.90),
        SkillItem(name: "Dart", level: 0.85),
        SkillItem(name: "Node.js", level: 0.75),
      ],
    ),
  ];

  static const List<ProjectItem> projects = [
    ProjectItem(
      title: "HeartSync - Dating App",
      description: "A modern, highly engaging dating application featuring swipe-based matching, instant real-time chat, detailed user profiles, and a premium glassmorphic UI. Optimized for smooth animations and high responsiveness.",
      techStack: ["Flutter", "Dart", "Firebase", "WebSockets", "Flutter Animate"],
      githubLink: "https://github.com/pridweraj",
      liveLink: "https://example.com",
    ),
    ProjectItem(
      title: "MyDesk - Kitchen App",
      description: "An intuitive kitchen assistant app designed to track pantry inventory, plan daily meals, and recommend recipes based on currently available ingredients. Powered by a robust Node.js backend.",
      techStack: ["Flutter", "Dart", "Node.js", "Express", "MongoDB"],
      githubLink: "https://github.com/pridweraj",
      liveLink: "https://example.com",
    ),
    ProjectItem(
      title: "ScanMe - QR Scan App",
      description: "A fast, lightweight QR code scanner and generator. Allows instant scanning from camera or gallery images, stores history logs locally with search capability, and generates customized QR codes.",
      techStack: ["Flutter", "Dart", "QR Code Generator", "Hive DB"],
      githubLink: "https://github.com/pridweraj",
      liveLink: "https://example.com",
    ),
  ];
}

class SkillCategory {
  final String title;
  final List<SkillItem> skills;

  const SkillCategory({required this.title, required this.skills});
}

class SkillItem {
  final String name;
  final double level; // 0.0 to 1.0

  const SkillItem({required this.name, required this.level});
}

class ProjectItem {
  final String title;
  final String description;
  final List<String> techStack;
  final String githubLink;
  final String liveLink;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubLink,
    required this.liveLink,
  });
}
