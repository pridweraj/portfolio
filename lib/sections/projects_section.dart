import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constants.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 900;
    final bool isTablet = size.width >= 900 && size.width < 1200;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 80.0,
        vertical: 80.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            "Featured Work",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: isMobile ? 32 : 40,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 12),
          Container(
            height: 4,
            width: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0, 1)),
          const SizedBox(height: 50),
          // Projects Grid
          _buildProjectsGrid(isMobile, isTablet),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(bool isMobile, bool isTablet) {
    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    if (isMobile) {
      return Column(
        children: DeveloperData.projects
            .map((project) => Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: _ProjectCard(project: project),
                ))
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: DeveloperData.projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.15,
      ),
      itemBuilder: (context, index) {
        return _ProjectCard(project: DeveloperData.projects[index]);
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -8.0, 0.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBg.withOpacity(_isHovered ? 0.95 : 0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withOpacity(0.8)
                : Colors.white.withOpacity(0.05),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.12)
                  : Colors.transparent,
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (Icon & Links)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.folder_open_rounded,
                      color: AppColors.primary,
                      size: 36,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.github,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          onPressed: () => _launchURL(widget.project.githubLink),
                          hoverColor: Colors.transparent,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.open_in_new_rounded,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          onPressed: () => _launchURL(widget.project.liveLink),
                          hoverColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  widget.project.title,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Description
                Text(
                  widget.project.description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tech Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.techStack
                  .map((tech) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.background.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.inter(
                            color: AppColors.textPrimary.withOpacity(0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}
