import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/portfolio_theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final isTablet = size.width >= 900 && size.width < 1200;

    final List<String> languages = ['Dart', 'Python', 'JavaScript', 'SQL', 'Java', 'C'];
    final List<String> tools = ['Flutter', 'Firebase', 'Flask', 'Django (Basics)', 'TensorFlow', 'Git', 'GitHub', 'Postman'];
    final List<String> practices = ['SDLC', 'Debugging', 'Troubleshooting', 'Code Optimization', 'Clean Coding', 'Unit Testing', 'Validation'];
    final List<String> aiTools = [
      'ChatGPT', 'Claude', 'Cursor AI', 'Windsurf', 'GitHub Copilot',
      'TensorFlow', 'YOLOv8', 'OpenCV', 'Flask AI Integration',
      'Machine Learning', 'AI Model Integration', 'Prompt Engineering'
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
                '03. ',
                style: GoogleFonts.poppins(
                  color: PortfolioTheme.accentCyan,
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Skills & Expertise',
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
          const SizedBox(height: 50),

          // Grid Layout
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 2),
            childAspectRatio: isMobile ? 1.2 : 1.4,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            children: [
              _buildSkillCategoryCard(
                title: 'Programming Languages',
                icon: Icons.code_rounded,
                skills: languages,
                accentColor: PortfolioTheme.accentCyan,
              ),
              _buildSkillCategoryCard(
                title: 'Tools & Frameworks',
                icon: Icons.biotech_rounded,
                skills: tools,
                accentColor: PortfolioTheme.accentPurple,
              ),
              _buildSkillCategoryCard(
                title: 'Software Engineering',
                icon: Icons.architecture_rounded,
                skills: practices,
                accentColor: Colors.amberAccent,
              ),
              _buildSkillCategoryCard(
                title: 'AI Tools & Technologies',
                icon: Icons.psychology_rounded,
                skills: aiTools,
                accentColor: PortfolioTheme.accentTeal,
                isAiCard: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategoryCard({
    required String title,
    required IconData icon,
    required List<String> skills,
    required Color accentColor,
    bool isAiCard = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isAiCard ? accentColor.withOpacity(0.3) : Colors.white.withOpacity(0.05),
          width: isAiCard ? 2 : 1.5,
        ),
        boxShadow: isAiCard
            ? [
                BoxShadow(
                  color: accentColor.withOpacity(0.05),
                  blurRadius: 16,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(icon, color: accentColor, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PortfolioTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Wrap of Skills Chips
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: skills.map((skill) => _SkillChip(name: skill, accentColor: accentColor)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String name;
  final Color accentColor;

  const _SkillChip({
    required this.name,
    required this.accentColor,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.accentColor.withOpacity(0.12)
              : Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? widget.accentColor : Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Text(
          widget.name,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
            color: _isHovered ? PortfolioTheme.textPrimary : PortfolioTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
