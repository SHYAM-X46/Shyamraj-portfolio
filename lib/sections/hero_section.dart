import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/portfolio_theme.dart';
import '../widgets/typing_text.dart';

class HeroSection extends StatelessWidget {
  final GlobalKey contactKey;
  final GlobalKey projectsKey;

  const HeroSection({
    super.key,
    required this.contactKey,
    required this.projectsKey,
  });

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _scrollTo(GlobalKey key) {
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
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 60.0,
        vertical: isMobile ? 40.0 : 100.0,
      ),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(isMobile),
                const SizedBox(height: 40),
                _buildContent(context, isMobile),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildContent(context, isMobile),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 2,
                  child: _buildProfileImage(isMobile),
                ),
              ],
            ),
    );
  }

  Widget _buildProfileImage(bool isMobile) {
    final double imageSize = isMobile ? 240.0 : 360.0;

    return Center(
      child: Container(
        width: imageSize,
        height: imageSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: PortfolioTheme.accentCyan.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: PortfolioTheme.accentPurple.withOpacity(0.2),
              blurRadius: 40,
              spreadRadius: 2,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(imageSize / 2),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 4,
              ),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/profile.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: PortfolioTheme.surface,
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: PortfolioTheme.accentCyan,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isMobile) {
    final textTheme = Theme.of(context).textTheme;
    final alignment = isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlignment = isMobile ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Role Tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: PortfolioTheme.accentCyan.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: PortfolioTheme.accentCyan.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: Text(
            'ASSOCIATE SOFTWARE ENGINEER',
            style: GoogleFonts.poppins(
              color: PortfolioTheme.accentCyan,
              fontSize: isMobile ? 11 : 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Headline
        Text(
          "Hi, I'm Shyamraj M V",
          textAlign: textAlignment,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 36 : 56,
            fontWeight: FontWeight.w800,
            color: PortfolioTheme.textPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),

        // Animated Typing Text
        TypingText(
          texts: const [
            "Software Engineer",
            "Flutter Developer",
            "AI/ML Enthusiast",
            "Full Stack Developer",
          ],
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 22 : 30,
            fontWeight: FontWeight.w600,
            color: PortfolioTheme.accentPurple,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),

        // Short Description
        Text(
          "I am a passionate software engineer specializing in Flutter development and AI integration. "
          "I thrive on creating highly intuitive applications, integrating smart AI models, and optimizing "
          "user experiences with modern development workflows.",
          textAlign: textAlignment,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: isMobile ? 14 : 16,
            color: PortfolioTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 32),

        // Actions & Socials
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Contact Me Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ).copyWith(
                elevation: ButtonStyleButton.allOrNull(0.0),
              ),
              onPressed: () => _scrollTo(contactKey),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: PortfolioTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  child: Text(
                    'Get In Touch',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),

            // View Work Outline Button
            OutlinedButton(
              onPressed: () => _scrollTo(projectsKey),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                side: const BorderSide(color: PortfolioTheme.borderLight, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'View My Work',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: PortfolioTheme.textPrimary,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Social Buttons
            _SocialIconButton(
              iconData: Icons.link,
              label: 'LinkedIn',
              onTap: () => _launchURL('https://linkedin.com/in/shyamrajmv'),
            ),
            _SocialIconButton(
              iconData: Icons.code,
              label: 'GitHub',
              onTap: () => _launchURL('https://github.com/SHYAM-X46'),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.iconData,
    required this.label,
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
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _isHovered
                ? PortfolioTheme.accentCyan.withOpacity(0.15)
                : const Color(0xFF0F172A),
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered
                  ? PortfolioTheme.accentCyan
                  : PortfolioTheme.borderLight,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: PortfolioTheme.accentCyan.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: Icon(
            widget.iconData,
            color: _isHovered ? PortfolioTheme.accentCyan : PortfolioTheme.textSecondary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
