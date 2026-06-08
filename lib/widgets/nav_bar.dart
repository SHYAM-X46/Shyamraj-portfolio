import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/portfolio_theme.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final List<GlobalKey> sectionKeys;
  final List<String> sectionNames;
  final VoidCallback? onMenuPressed;

  const NavBar({
    super.key,
    required this.sectionKeys,
    required this.sectionNames,
    this.onMenuPressed,
  });

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        constraints: const BoxConstraints(maxWidth: 1200),
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withOpacity(0.7),
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _scrollToSection(sectionKeys[0]),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'SHYAMRAJ ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w800,
                              color: PortfolioTheme.textPrimary,
                              fontSize: 20,
                              letterSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: 'M V',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w800,
                              color: PortfolioTheme.accentCyan,
                              fontSize: 20,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Navigation Items
                if (!isMobile)
                  Row(
                    children: List.generate(sectionKeys.length, (index) {
                      return _NavBarItem(
                        title: sectionNames[index],
                        onTap: () => _scrollToSection(sectionKeys[index]),
                      );
                    }),
                  )
                else
                  IconButton(
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: PortfolioTheme.textPrimary,
                      size: 28,
                    ),
                    onPressed: onMenuPressed,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}

class _NavBarItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.title,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: _isHovered
                ? PortfolioTheme.accentCyan.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isHovered
                  ? PortfolioTheme.accentCyan
                  : PortfolioTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
