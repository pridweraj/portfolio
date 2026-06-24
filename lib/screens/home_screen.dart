import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../widgets/nav_bar.dart';
import '../sections/hero_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Determine which section is currently most visible on screen
    double screenOffset = _scrollController.offset + 200; // offset buffer
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final context = _sectionKeys[i].currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final absoluteY = position.dy + _scrollController.offset;
          if (screenOffset >= absoluteY) {
            if (_activeIndex != i) {
              setState(() {
                _activeIndex = i;
              });
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
    
    final sectionContext = _sectionKeys[index].currentContext;
    if (sectionContext != null) {
      Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
      setState(() {
        _activeIndex = index;
      });
    }
  }

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

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: NavBar(
        activeIndex: _activeIndex,
        onNavItemTap: _scrollToSection,
        onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
        isMobile: isMobile,
      ),
      endDrawer: isMobile ? _buildDrawer() : null,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            // Decorative background glowing blur elements
            Positioned(
              top: 50,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.08),
                      blurRadius: 100,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 400,
              right: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.08),
                      blurRadius: 120,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 900,
              left: -100,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.06),
                      blurRadius: 110,
                      spreadRadius: 35,
                    ),
                  ],
                ),
              ),
            ),
            
            // Main content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section (Index 0)
                  HeroSection(
                    key: _sectionKeys[0],
                    onViewWorkTap: () => _scrollToSection(2),
                    onContactTap: () => _scrollToSection(3),
                  ),
                  
                  // Skills Section (Index 1)
                  SkillsSection(
                    key: _sectionKeys[1],
                  ),
                  
                  // Projects Section (Index 2)
                  ProjectsSection(
                    key: _sectionKeys[2],
                  ),
                  
                  // Contact Section (Index 3)
                  ContactSection(
                    key: _sectionKeys[3],
                  ),

                  // Footer
                  _buildFooter(isMobile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              child: Text(
                DeveloperData.name,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const Divider(color: Colors.white12),
            _buildDrawerItem("Home", 0),
            _buildDrawerItem("Skills", 1),
            _buildDrawerItem("Projects", 2),
            _buildDrawerItem("Contact", 3),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFooterIcon(FontAwesomeIcons.github, DeveloperData.githubUrl),
                  _buildFooterIcon(FontAwesomeIcons.linkedin, DeveloperData.linkedinUrl),
                  _buildFooterIcon(FontAwesomeIcons.envelope, DeveloperData.emailUrl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String label, int index) {
    final bool isActive = _activeIndex == index;
    return ListTile(
      title: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          fontSize: 18,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () => _scrollToSection(index),
    );
  }

  Widget _buildFooter(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      color: Colors.black.withOpacity(0.3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterIcon(FontAwesomeIcons.github, DeveloperData.githubUrl),
              _buildFooterIcon(FontAwesomeIcons.linkedin, DeveloperData.linkedinUrl),
              _buildFooterIcon(FontAwesomeIcons.envelope, DeveloperData.emailUrl),
              _buildFooterIcon(FontAwesomeIcons.twitter, DeveloperData.twitterUrl),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "© 2026 ${DeveloperData.name}. All rights reserved.",
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Built with ",
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const Icon(Icons.favorite, color: AppColors.accent, size: 14),
              Text(
                " using Flutter",
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(FaIconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon, size: 20),
      color: AppColors.textSecondary,
      hoverColor: Colors.transparent,
      onPressed: () => _launchURL(url),
    );
  }
}
