import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/portfolio_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    // List of key competencies
    final List<Map<String, dynamic>> competencies = [
      {'name': 'Flutter Development', 'icon': Icons.phone_android_rounded},
      {'name': 'REST API Integration', 'icon': Icons.swap_horiz_rounded},
      {'name': 'Firebase Integration', 'icon': Icons.local_fire_department_rounded},
      {'name': 'Object Oriented Programming', 'icon': Icons.code_rounded},
      {'name': 'Problem Solving & Debugging', 'icon': Icons.bug_report_rounded},
      {'name': 'Software Development Lifecycle (SDLC)', 'icon': Icons.settings_suggest_rounded},
      {'name': 'Agile Development', 'icon': Icons.loop_rounded},
      {'name': 'Flask Backend Development', 'icon': Icons.dns_rounded},
      {'name': 'Provider State Management', 'icon': Icons.schema_rounded},
      {'name': 'AI Integration & Prompt Eng.', 'icon': Icons.psychology_rounded},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 60.0,
        vertical: 80.0,
      ),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            children: [
              Text(
                '01. ',
                style: GoogleFonts.poppins(
                  color: PortfolioTheme.accentCyan,
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'About Me',
                style: GoogleFonts.poppins(
                  color: PortfolioTheme.textPrimary,
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Divider(
                  color: Colors.white.withOpacity(0.08),
                  thickness: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Content Layout
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBioCard(context),
                    const SizedBox(height: 40),
                    _buildCompetencyHeader(context),
                    const SizedBox(height: 16),
                    _buildCompetencyGrid(competencies, isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildBioCard(context),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCompetencyHeader(context),
                          const SizedBox(height: 20),
                          _buildCompetencyGrid(competencies, isMobile),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildBioCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who I Am',
            style: GoogleFonts.poppins(
              color: PortfolioTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: textTheme.bodyLarge?.copyWith(fontSize: 15),
              children: const [
                TextSpan(
                  text: "I recently completed my ",
                ),
                TextSpan(
                  text: "Master of Computer Applications (MCA)",
                  style: TextStyle(
                    color: PortfolioTheme.accentCyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ", which laid a strong academic foundation in Object-Oriented Programming (OOP), Data Structures, and problem-solving. "
                      "I'm an aspiring Associate Software Engineer, eager to design and develop next-generation mobile and web applications.\n\n"
                      "I have hands-on experience in building Flutter applications, integrating secure RESTful APIs, testing, and troubleshooting. "
                      "As a tech enthusiast, I am extremely passionate about the AI space. I actively integrate AI models and leverage advanced AI tools to accelerate development and craft highly optimized solutions.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetencyHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Core Competencies',
          style: GoogleFonts.poppins(
            color: PortfolioTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'A snapshot of the key areas of my software engineering capabilities:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: PortfolioTheme.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildCompetencyGrid(List<Map<String, dynamic>> items, bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isMobile ? 5.5 : 4.5,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _CompetencyChip(
          name: items[index]['name'],
          iconData: items[index]['icon'],
        );
      },
    );
  }
}

class _CompetencyChip extends StatefulWidget {
  final String name;
  final IconData iconData;

  const _CompetencyChip({
    required this.name,
    required this.iconData,
  });

  @override
  State<_CompetencyChip> createState() => _CompetencyChipState();
}

class _CompetencyChipState extends State<_CompetencyChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? PortfolioTheme.accentCyan.withOpacity(0.08)
              : const Color(0xFF0F172A).withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? PortfolioTheme.accentCyan.withOpacity(0.4)
                : Colors.white.withOpacity(0.04),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.iconData,
              color: _isHovered ? PortfolioTheme.accentCyan : PortfolioTheme.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.name,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  color: _isHovered ? PortfolioTheme.textPrimary : PortfolioTheme.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
