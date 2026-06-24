import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constants.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWorkTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onViewWorkTap,
    required this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isPhotoHovered = false;

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 900;

    return Container(
      constraints: BoxConstraints(minHeight: size.height - 70),
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 80.0,
        vertical: 40.0,
      ),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildPhoto(true),
                const SizedBox(height: 40),
                _buildTextContent(true),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildTextContent(false),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 2,
                  child: Center(child: _buildPhoto(false)),
                ),
              ],
            ),
    );
  }

  Widget _buildTextContent(bool isCenter) {
    final align = isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isCenter ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Greeting
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Hi there ",
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              "👋",
              style: TextStyle(fontSize: 20),
            ).animate(onPlay: (controller) => controller.repeat()).shake(
                  delay: 1.seconds,
                  duration: 1.5.seconds,
                  curve: Curves.easeInOut,
                ),
            Text(
              ", I am",
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 12),
        // Name
        Text(
          DeveloperData.name,
          textAlign: textAlign,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: isCenter ? 42 : 64,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -1.5,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 16),
        // Title with Gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary, AppColors.accent],
          ).createShader(bounds),
          child: Text(
            DeveloperData.title,
            textAlign: textAlign,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: isCenter ? 24 : 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 24),
        // Bio description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            DeveloperData.bio,
            textAlign: textAlign,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 600.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 32),
        // Social Media Icons
        Row(
          mainAxisAlignment:
              isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, DeveloperData.githubUrl),
            _buildSocialIcon(FontAwesomeIcons.linkedin, DeveloperData.linkedinUrl),
            _buildSocialIcon(FontAwesomeIcons.envelope, DeveloperData.emailUrl),
            _buildSocialIcon(FontAwesomeIcons.twitter, DeveloperData.twitterUrl),
          ],
        )
            .animate()
            .fadeIn(delay: 800.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 40),
        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: widget.onViewWorkTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 10,
                shadowColor: AppColors.primary.withOpacity(0.5),
              ),
              child: Text(
                "View My Work",
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () => _launchURL(DeveloperData.resumeUrl),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: const BorderSide(color: AppColors.secondary, width: 2),
              ),
              child: Text(
                "Download CV",
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 1000.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildPhoto(bool isMobile) {
    final size = isMobile ? 250.0 : 350.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _isPhotoHovered = true),
      onExit: (_) => setState(() => _isPhotoHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: size,
        height: size,
        transform: _isPhotoHovered
            ? (Matrix4.identity()
              ..translate(-10.0, -10.0, 0.0)
              ..rotateZ(-0.02))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(_isPhotoHovered ? 0.6 : 0.3),
              blurRadius: _isPhotoHovered ? 40 : 25,
              spreadRadius: _isPhotoHovered ? 10 : 2,
            ),
            BoxShadow(
              color: AppColors.secondary.withOpacity(_isPhotoHovered ? 0.4 : 0.2),
              blurRadius: _isPhotoHovered ? 50 : 30,
              spreadRadius: _isPhotoHovered ? 5 : 0,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withOpacity(0.8),
              width: 4,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile_pic.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.cardBg,
                  child: const Icon(
                    Icons.person,
                    size: 100,
                    color: AppColors.textSecondary,
                  ),
                );
              },
            ),
          ),
        ),
      ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8)),
    );
  }

  Widget _buildSocialIcon(FaIconData icon, String url) {
    return _SocialIconButton(icon: icon, url: url, onTap: () => _launchURL(url));
  }
}

class _SocialIconButton extends StatefulWidget {
  final FaIconData icon;
  final String url;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.url,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 16),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -5.0, 0.0))
            : Matrix4.identity(),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.2)
                  : AppColors.cardBg,
              border: Border.all(
                color: _isHovered ? AppColors.primary : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: FaIcon(
              widget.icon,
              color: _isHovered ? AppColors.primary : AppColors.textPrimary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
