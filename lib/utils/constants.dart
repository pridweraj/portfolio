import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0B0F19);
  static const Color cardBg = Color(0xFF1E293B);
  static const Color primary = Color(0xFF06B6D4); // Cyan
  static const Color secondary = Color(0xFF8B5CF6); // Purple
  static const Color accent = Color(0xFFEC4899); // Pink
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color navHighlight = Color(0xFF22C55E); // Green
}

class DeveloperData {
  static const String name = "Alex Rivera";
  static const String title = "Full-Stack Mobile & Web Developer";
  static const String subtitle = "Crafting premium, high-performance applications with Flutter & Cloud Architectures.";
  
  static const String bio = "I am a passionate software engineer with 4+ years of experience building cross-platform mobile apps and modern web platforms. Specializing in Flutter, Dart, Firebase, and Cloud architectures, I design clean, pixel-perfect user interfaces backed by robust backend APIs. I love turning complex problems into elegant, user-friendly digital solutions.";

  static const String resumeUrl = "https://example.com/resume.pdf";
  
  static const String githubUrl = "https://github.com";
  static const String linkedinUrl = "https://linkedin.com";
  static const String emailUrl = "mailto:alex.rivera@example.com";
  static const String twitterUrl = "https://twitter.com";

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: "Frontend & Mobile",
      skills: [
        SkillItem(name: "Flutter & Dart", level: 0.95),
        SkillItem(name: "Responsive UI", level: 0.90),
        SkillItem(name: "React & Next.js", level: 0.80),
        SkillItem(name: "HTML/CSS/JS", level: 0.85),
      ],
    ),
    SkillCategory(
      title: "Backend & Database",
      skills: [
        SkillItem(name: "Firebase Suite", level: 0.90),
        SkillItem(name: "Node.js & Express", level: 0.85),
        SkillItem(name: "PostgreSQL & SQLite", level: 0.80),
        SkillItem(name: "GraphQL & REST APIs", level: 0.88),
      ],
    ),
    SkillCategory(
      title: "DevOps & Tools",
      skills: [
        SkillItem(name: "Git & GitHub", level: 0.92),
        SkillItem(name: "Docker & Containers", level: 0.75),
        SkillItem(name: "CI/CD Pipelines", level: 0.80),
        SkillItem(name: "Figma UI/UX Design", level: 0.85),
      ],
    ),
  ];

  static const List<ProjectItem> projects = [
    ProjectItem(
      title: "Aether - Smart Home IoT Client",
      description: "A comprehensive IoT dashboard built with Flutter to monitor and control smart home appliances. Features real-time MQTT telemetry, automated rule scheduling, interactive charts, and glassmorphic device control panels.",
      techStack: ["Flutter", "MQTT", "Node.js", "FL Chart", "Hive DB"],
      githubLink: "https://github.com",
      liveLink: "https://example.com",
    ),
    ProjectItem(
      title: "Nexus - Crypto & Stock Portfolio",
      description: "A high-performance finance tracker allowing users to manage asset portfolios. Integrates real-time price feeds via WebSockets, clean interactive charts, transaction logging, and automated portfolio rebalancing suggestions.",
      techStack: ["Flutter", "Firebase", "WebSockets", "CoinGecko API", "Provider"],
      githubLink: "https://github.com",
      liveLink: "https://example.com",
    ),
    ProjectItem(
      title: "Delivry - Logistics & Geofencing System",
      description: "On-demand dispatch and delivery app featuring real-time location tracking for drivers and clients, map-based route optimizations, instant push notifications, and customer-merchant direct messaging.",
      techStack: ["Flutter", "Google Maps SDK", "NestJS", "Socket.io", "MongoDB"],
      githubLink: "https://github.com",
      liveLink: "https://example.com",
    ),
    ProjectItem(
      title: "Synapse - Collaborative Task Hub",
      description: "Team collaboration tool implementing real-time Kanban boards, instant chat rooms, offline-first data synchronization, role-based access control, and customizable project analytics reports.",
      techStack: ["Flutter", "GraphQL", "Hasura", "Hive DB", "Firebase Auth"],
      githubLink: "https://github.com",
      liveLink: "https://example.com",
    ),
  ];

  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      role: "Senior Mobile Engineer",
      company: "TechWave Solutions",
      duration: "2024 - Present",
      description: "Re-architected flag-ship mobile applications using clean architecture and BLoC pattern, improving app load speed by 35% and crash-free users to 99.8%. Mentored 4 junior Flutter developers.",
    ),
    ExperienceItem(
      role: "Flutter Developer",
      company: "PixelCraft Digital Studio",
      duration: "2022 - 2024",
      description: "Developed and launched 8 client applications targeting Web, iOS, and Android. Integrated advanced offline sync solutions and optimized Flutter web builds for sub-second visual load times.",
    ),
    ExperienceItem(
      role: "Associate Software Engineer",
      company: "AppStart Inc.",
      duration: "2021 - 2022",
      description: "Created robust Node.js backend services serving REST APIs. Maintained legacy native Android codebases and spearheaded their migration to Flutter platforms.",
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

class ExperienceItem {
  final String role;
  final String company;
  final String duration;
  final String description;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
  });
}
