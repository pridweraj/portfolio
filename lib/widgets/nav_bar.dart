import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final int activeIndex;
  final Function(int) onNavItemTap;
  final VoidCallback onMenuTap;
  final bool isMobile;

  const NavBar({
    super.key,
    required this.activeIndex,
    required this.onNavItemTap,
    required this.onMenuTap,
    required this.isMobile,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 70,
          color: AppColors.background.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              GestureDetector(
                onTap: () => onNavItemTap(0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "AR",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      DeveloperData.name,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation Items
              if (isMobile)
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                  onPressed: onMenuTap,
                )
              else
                Row(
                  children: [
                    _buildNavItem("Home", 0),
                    _buildNavItem("Skills", 1),
                    _buildNavItem("Projects", 2),
                    _buildNavItem("Contact", 3),
                    const SizedBox(width: 20),
                    // Glassmorphic Contact button
                    TextButton(
                      onPressed: () => onNavItemTap(3),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                      ),
                      child: const Text(
                        "Let's Chat",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
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

  Widget _buildNavItem(String label, int index) {
    final bool isActive = activeIndex == index;
    return InkWell(
      onTap: () => onNavItemTap(index),
      hoverColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isActive ? 20 : 0,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
