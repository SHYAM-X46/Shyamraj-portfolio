import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/portfolio_theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create mailto URI for contact form
      final name = Uri.encodeComponent(_nameController.text);
      final email = Uri.encodeComponent(_emailController.text);
      final msg = Uri.encodeComponent(_messageController.text);
      final mailtoUrl = 'mailto:shyam2003raj666@gmail.com?subject=Portfolio Contact from $name&body=From: $email%0A%0AMessage:%0A$msg';

      _launchURL(mailtoUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Opening your default email application to send...',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: PortfolioTheme.accentCyan,
          behavior: SnackBarBehavior.floating,
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

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
                '05. ',
                style: GoogleFonts.poppins(
                  color: PortfolioTheme.accentCyan,
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Get In Touch',
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

          // Contact Content Layout
          isMobile
              ? Column(
                  children: [
                    _buildInfoColumn(),
                    const SizedBox(height: 48),
                    _buildFormCard(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildInfoColumn(),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 5,
                      child: _buildFormCard(),
                    ),
                  ],
                ),

          const SizedBox(height: 100),

          // Footer Copyright
          Center(
            child: Column(
              children: [
                Divider(color: Colors.white.withOpacity(0.05)),
                const SizedBox(height: 20),
                Text(
                  'Designed & Built by Shyamraj M V',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: PortfolioTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '© 2026. All Rights Reserved.',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: PortfolioTheme.textSecondary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Collaborate",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PortfolioTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "My inbox is always open. Whether you have a project idea, want to talk about Flutter development, "
          "discuss AI applications, or just say hello, I will do my best to get back to you as soon as possible!",
          style: GoogleFonts.inter(
            fontSize: 15,
            color: PortfolioTheme.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),

        // Contact details list
        _ContactDetailTile(
          icon: Icons.email_outlined,
          title: 'Email Me',
          value: 'shyam2003raj666@gmail.com',
          onTap: () => _launchURL('mailto:shyam2003raj666@gmail.com'),
        ),
        const SizedBox(height: 20),
        _ContactDetailTile(
          icon: Icons.phone_android_outlined,
          title: 'Call Me',
          value: '+91 6282618966',
          onTap: () => _launchURL('tel:+916282618966'),
        ),
        const SizedBox(height: 20),
        _ContactDetailTile(
          icon: Icons.link_rounded,
          title: 'LinkedIn',
          value: 'linkedin.com/in/shyamrajmv',
          onTap: () => _launchURL('https://linkedin.com/in/shyamrajmv'),
        ),
        const SizedBox(height: 20),
        _ContactDetailTile(
          icon: Icons.code_rounded,
          title: 'GitHub Repo',
          value: 'github.com/SHYAM-X46',
          onTap: () => _launchURL('https://github.com/SHYAM-X46'),
        ),
      ],
    );
  }

  Widget _buildFormCard() {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: PortfolioTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // Name Field
            _buildTextField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'John Doe',
              validator: (val) => val == null || val.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 20),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: 'Your Email',
              hint: 'john@example.com',
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val == null || val.isEmpty) return 'Please enter your email';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Message Field
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              hint: 'Hi Shyamraj, let\'s collaborate on a mobile app...',
              maxLines: 5,
              validator: (val) => val == null || val.isEmpty ? 'Please enter your message' : null,
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ).copyWith(
                  elevation: ButtonStyleButton.allOrNull(0.0),
                ),
                onPressed: _submitForm,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: PortfolioTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Send Message',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.inter(color: PortfolioTheme.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: PortfolioTheme.textSecondary, fontSize: 13),
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: PortfolioTheme.textSecondary.withOpacity(0.4), fontSize: 13),
        floatingLabelStyle: GoogleFonts.poppins(color: PortfolioTheme.accentCyan, fontSize: 13),
        filled: true,
        fillColor: Colors.white.withOpacity(0.02),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: PortfolioTheme.accentCyan, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}

class _ContactDetailTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactDetailTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactDetailTile> createState() => _ContactDetailTileState();
}

class _ContactDetailTileState extends State<_ContactDetailTile> {
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isHovered
                ? PortfolioTheme.accentCyan.withOpacity(0.05)
                : const Color(0xFF0F172A).withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? PortfolioTheme.accentCyan.withOpacity(0.3)
                  : Colors.white.withOpacity(0.04),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _isHovered
                      ? PortfolioTheme.accentCyan.withOpacity(0.12)
                      : Colors.white.withOpacity(0.03),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: _isHovered ? PortfolioTheme.accentCyan : PortfolioTheme.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: PortfolioTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.value,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: _isHovered ? PortfolioTheme.accentCyan : PortfolioTheme.textPrimary,
                        fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
