import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/portfolio_theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    final List<String> duties = [
      'Participated in design, development, testing, and deployment of Flutter mobile applications.',
      'Built and integrated RESTful APIs for efficient, low-latency data communication.',
      'Debugged and resolved issues to improve application performance, memory footprint, and reliability.',
      'Collaborated with cross-functional teams to analyze requirements and deliver sprint solutions.',
      'Assisted in testing and validation to ensure high-quality deliverables and smooth UX.',
      'Contributed actively to Agile development cycles, sprint planning, and peer review discussions.'
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
                '02. ',
                style: GoogleFonts.poppins(
                  color: PortfolioTheme.accentCyan,
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Professional Experience',
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

          // Experience Layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) ...[
                // Left Column: Timeline vertical line & dot decoration
                Column(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PortfolioTheme.accentCyan,
                          width: 4,
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 360,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            PortfolioTheme.accentCyan,
                            PortfolioTheme.accentPurple.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 32),
              ],
              Expanded(
                child: _buildJobCard(
                  context: context,
                  role: 'Junior Software Developer (Flutter)',
                  company: 'BigMonks Technologies',
                  duration: 'Dec 2025 – May 2026',
                  duties: duties,
                  isMobile: isMobile,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard({
    required BuildContext context,
    required String role,
    required String company,
    required String duration,
    required List<String> duties,
    required bool isMobile,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Header
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: PortfolioTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      company,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: PortfolioTheme.accentCyan,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      duration,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: PortfolioTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          role,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: PortfolioTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          company,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: PortfolioTheme.accentCyan,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        duration,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: PortfolioTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 30),

          // Job Duties
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: duties.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.check_circle_outline_rounded,
                        color: PortfolioTheme.accentCyan.withOpacity(0.8),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        duties[index],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 15,
                              color: PortfolioTheme.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
