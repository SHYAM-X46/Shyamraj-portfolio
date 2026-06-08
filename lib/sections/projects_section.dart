import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/portfolio_theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final isTablet = size.width >= 900 && size.width < 1200;

    final List<Map<String, dynamic>> projects = [
      {
        'title': 'Veggie Market – AI-Powered E-commerce App',
        'tech': ['Flutter', 'Firebase', 'Flask', 'TensorFlow', 'Provider'],
        'image': 'assets/images/veggie_market.png',
        'points': [
          'Developed an e-commerce mobile application connecting farmers directly with customers.',
          'Built custom, AI-based Flask APIs for intelligent features like crop demand/price analytics.',
          'Integrated secure Firebase authentication, database services, and chat functionalities.',
          'Implemented robust Provider state management, performing unit testing and debugging.'
        ],
        'isCompanyProject': false,
        'githubUrl': 'https://github.com/SHYAM-X46',
      },
      {
        'title': 'Employee Scheduler Application',
        'tech': ['Flutter', 'Firebase', 'Firestore', 'Real-Time Sync'],
        'image': 'assets/images/employee_scheduler.png',
        'points': [
          'Developed a task allocation and shift scheduling application for multi-tier team management.',
          'Integrated Firebase Firestore database for real-time schedule updates and notifications.',
          'Designed intuitive UI/UX with smooth transitions and conducted debugging and testing.'
        ],
        'isCompanyProject': true,
        'githubUrl': '',
      },
      {
        'title': 'AI-Based Harmful Weapon Detection System',
        'tech': ['Python', 'YOLOv8', 'OpenCV', 'Computer Vision'],
        'image': 'assets/images/weapon_detection.png',
        'points': [
          'Developed a real-time object detection and weapon tracking system using YOLOv8.',
          'Processed multi-source live video streams for immediate threat detection and alert triggers.',
          'Optimized inference performance and model accuracy under diverse lighting conditions.'
        ],
        'isCompanyProject': false,
        'githubUrl': 'https://github.com/SHYAM-X46',
      }
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
                '04. ',
                style: GoogleFonts.poppins(
                  color: PortfolioTheme.accentCyan,
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Selected Projects',
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

          // Projects Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
              crossAxisSpacing: 24,
              mainAxisSpacing: 32,
              childAspectRatio: isMobile ? 0.75 : (isTablet ? 0.68 : 0.65),
            ),
            itemBuilder: (context, index) {
              final proj = projects[index];
              return _ProjectCard(
                title: proj['title'],
                tech: proj['tech'],
                imagePath: proj['image'],
                points: proj['points'],
                isCompanyProject: proj['isCompanyProject'],
                githubUrl: proj['githubUrl'],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final List<String> tech;
  final String imagePath;
  final List<String> points;
  final bool isCompanyProject;
  final String githubUrl;

  const _ProjectCard({
    required this.title,
    required this.tech,
    required this.imagePath,
    required this.points,
    required this.isCompanyProject,
    required this.githubUrl,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchURL(String urlString) async {
    if (urlString.isEmpty) return;
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _showCompanyProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0F172A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: Colors.white.withOpacity(0.08),
              width: 1.5,
            ),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.lock_outline_rounded,
                color: PortfolioTheme.accentPurple,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Company Project',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: PortfolioTheme.textPrimary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Text(
            "Access Restricted: This is a commercial project developed for BigMonks Technologies. "
            "The source code and repositories are proprietary and cannot be accessed publicly.",
            style: GoogleFonts.inter(
              color: PortfolioTheme.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: GoogleFonts.poppins(
                  color: PortfolioTheme.accentCyan,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.isCompanyProject) {
            _showCompanyProjectDialog(context);
          } else {
            _launchURL(widget.githubUrl);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: _isHovered ? (Matrix4.identity()..translate(0, -10, 0)) : Matrix4.identity(),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withOpacity(0.4),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? PortfolioTheme.accentCyan.withOpacity(0.3) : Colors.white.withOpacity(0.05),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? PortfolioTheme.accentCyan.withOpacity(0.08)
                    : Colors.black.withOpacity(0.2),
                blurRadius: _isHovered ? 24 : 16,
                spreadRadius: _isHovered ? 2 : 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Image Showcase
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedScale(
                          scale: _isHovered ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          child: Image.asset(
                            widget.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: PortfolioTheme.surface,
                                child: const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: PortfolioTheme.textSecondary,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                const Color(0xFF070A13).withOpacity(0.8),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
  
                // Card Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: PortfolioTheme.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
  
                        // Tech Stack Tags
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: widget.tech.map((t) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: PortfolioTheme.accentCyan.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: PortfolioTheme.accentCyan.withOpacity(0.15),
                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                t,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: PortfolioTheme.accentCyan,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
  
                        // Points list
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.points.map((p) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5.0, right: 8.0),
                                        child: CircleAvatar(
                                          radius: 3.0,
                                          backgroundColor: PortfolioTheme.accentPurple,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          p,
                                          style: GoogleFonts.inter(
                                            fontSize: 12.5,
                                            color: PortfolioTheme.textSecondary,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
