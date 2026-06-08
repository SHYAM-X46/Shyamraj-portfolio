import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/portfolio_theme.dart';
import 'widgets/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/experience_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const ShyamrajPortfolioApp());
}

class ShyamrajPortfolioApp extends StatelessWidget {
  const ShyamrajPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shyamraj M V | Software Engineer & Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: PortfolioTheme.themeData,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  // GlobalKeys for sections to support smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late final List<GlobalKey> _sectionKeys;
  final List<String> _sectionNames = [
    'Home',
    'About',
    'Experience',
    'Skills',
    'Projects',
    'Contact',
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _sectionKeys = [
      _heroKey,
      _aboutKey,
      _experienceKey,
      _skillsKey,
      _projectsKey,
      _contactKey,
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      // Mobile Drawer (Glassmorphic dark design)
      drawer: Drawer(
        child: Container(
          color: PortfolioTheme.background,
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: PortfolioTheme.borderLight, width: 1),
                  ),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'SHYAMRAJ ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            color: PortfolioTheme.textPrimary,
                            fontSize: 22,
                            letterSpacing: 1.2,
                          ),
                        ),
                        TextSpan(
                          text: 'M V',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            color: PortfolioTheme.accentCyan,
                            fontSize: 22,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: _sectionKeys.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      title: Text(
                        _sectionNames[index],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: PortfolioTheme.textSecondary,
                        ),
                      ),
                      hoverColor: PortfolioTheme.accentCyan.withOpacity(0.08),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection(_sectionKeys[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background subtle gradients and stars simulation
          Positioned.fill(
            child: Container(
              color: PortfolioTheme.background,
            ),
          ),
          
          // Custom Parallax Glowing Orbs
          Positioned(
            top: -200,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PortfolioTheme.accentCyan.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PortfolioTheme.accentPurple.withOpacity(0.08),
              ),
            ),
          ),

          // Main Page Layout
          SafeArea(
            child: Column(
              children: [
                // Floating glassmorphic navbar
                NavBar(
                  sectionKeys: _sectionKeys,
                  sectionNames: _sectionNames,
                  onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
                ),

                // Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Hero Section
                        Container(
                          key: _heroKey,
                          alignment: Alignment.center,
                          child: HeroSection(
                            contactKey: _contactKey,
                            projectsKey: _projectsKey,
                          ),
                        ),
                        
                        // About Section
                        Container(
                          key: _aboutKey,
                          alignment: Alignment.center,
                          child: const AboutSection(),
                        ),

                        // Experience Section
                        Container(
                          key: _experienceKey,
                          alignment: Alignment.center,
                          child: const ExperienceSection(),
                        ),

                        // Skills Section
                        Container(
                          key: _skillsKey,
                          alignment: Alignment.center,
                          child: const SkillsSection(),
                        ),

                        // Projects Section
                        Container(
                          key: _projectsKey,
                          alignment: Alignment.center,
                          child: const ProjectsSection(),
                        ),

                        // Contact Section
                        Container(
                          key: _contactKey,
                          alignment: Alignment.center,
                          child: const ContactSection(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
