import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constants.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 900;

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
            "My Journey",
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
          // Timeline List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: DeveloperData.experiences.length,
            itemBuilder: (context, index) {
              return _buildTimelineItem(
                context,
                DeveloperData.experiences[index],
                index,
                index == DeveloperData.experiences.length - 1,
                isMobile,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    ExperienceItem item,
    int index,
    bool isLast,
    bool isMobile,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isMobile)
            // Left Side: Duration
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 32.0, top: 4.0),
                child: Text(
                  item.duration,
                  style: GoogleFonts.outfit(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),
            ),
          // Middle: Timeline Line & Node
          Column(
            children: [
              // Node Circle
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                  border: Border.all(
                    color: index == 0 ? AppColors.accent : AppColors.primary,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (index == 0 ? AppColors.accent : AppColors.primary)
                          .withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              // Line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                ),
            ],
          ),
          // Right Side: Content Card
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 8.0,
                bottom: isLast ? 0.0 : 40.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppColors.cardBg.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.04),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile) ...[
                      Text(
                        item.duration,
                        style: GoogleFonts.outfit(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                    Text(
                      item.role,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.company,
                      style: GoogleFonts.outfit(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.description,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.2, end: 0),
            ),
          ),
        ],
      ),
    );
  }
}
