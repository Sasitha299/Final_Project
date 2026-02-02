import 'package:flutter/material.dart';

/// Contact Us Screen - User contact and feedback management
/// Follows:
/// - Single Responsibility Principle (SRP): Handles only contact display
/// - Open/Closed Principle (OCP): Can be extended without modification
/// - Dependency Inversion Principle (DIP): Depends on abstractions
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/train_background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4A5F6F).withOpacity(0.7),
                Color(0xFF2C3E50).withOpacity(0.8),
                Color(0xFF1A1A1A).withOpacity(0.85),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header Section
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 30.0 : 40.0,
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: [
                        // Back Button
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 20 : 30),
                        Text(
                          'WELCOME TO RAILPULSE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 16.0 : 18.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        // Logo
                        Container(
                          width: isMobile ? 60.0 : 70.0,
                          height: isMobile ? 60.0 : 70.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 2.5),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: isMobile ? 45.0 : 52.0,
                                height: isMobile ? 45.0 : 52.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Icon(
                                Icons.train,
                                color: Colors.white,
                                size: isMobile ? 28.0 : 32.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Section Title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20.0 : 40.0,
                    ),
                    child: Text(
                      'CONTACT US',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 24.0 : 28.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 30),

                  // Main Content Card
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16.0 : 40.0,
                      vertical: isMobile ? 16.0 : 20.0,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(isMobile ? 20.0 : 24.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title in card
                          Text(
                            'Get in Touch',
                            style: TextStyle(
                              color: Color(0xFF2C3E50),
                              fontSize: isMobile ? 18.0 : 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: isMobile ? 16 : 20),

                          // Contact info text
                          Text(
                            'Have questions or feedback? We\'d love to hear from you! Our team is here to help and ready to assist you with any inquiries about RailPulse.',
                            style: TextStyle(
                              color: Color(0xFF2C3E50).withOpacity(0.8),
                              fontSize: isMobile ? 13.0 : 14.0,
                              fontWeight: FontWeight.w400,
                              height: 1.6,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(height: isMobile ? 20 : 24),

                          // Contact Methods
                          _buildContactMethod(
                            'Email',
                            'railpulse@sliit.lk',
                            Icons.email_outlined,
                            isMobile,
                            () => _launchEmail('railpulse@sliit.lk'),
                          ),
                          SizedBox(height: 16),
                          _buildContactMethod(
                            'Phone',
                            '+94 (0) 760763600',
                            Icons.phone_outlined,
                            isMobile,
                            () => _launchPhone('+94760763600'),
                          ),
                          SizedBox(height: 16),
                          _buildContactMethod(
                            'Address',
                            'SLIIT, Malabe, Sri Lanka',
                            Icons.location_on_outlined,
                            isMobile,
                            () => _launchMaps('Malabe, Sri Lanka'),
                          ),
                          SizedBox(height: 16),
                          _buildContactMethod(
                            'Operating Hours',
                            'Mon - Fri: 9:00 AM - 5:00 PM',
                            Icons.schedule_outlined,
                            isMobile,
                            null,
                          ),
                          SizedBox(height: isMobile ? 20 : 24),

                          // Team Section
                          Divider(
                            color: Color(0xFF2C3E50).withOpacity(0.2),
                            height: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Project Team',
                            style: TextStyle(
                              color: Color(0xFF2C3E50),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 12),
                          _buildTeamMember(
                            'Supervisor',
                            'Prof. Chulantha Kulasekara',
                            isMobile,
                          ),
                          SizedBox(height: 8),
                          _buildTeamMember(
                            'Co-Supervisor',
                            'Ms. Nayomi Fernando',
                            isMobile,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Team Members',
                            style: TextStyle(
                              color: Color(0xFF2C3E50),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(height: 8),
                          _buildTeamMember(
                            '• RAIR WijeSekara',
                            '',
                            isMobile,
                            showSubtitle: false,
                          ),
                          _buildTeamMember(
                            '• RMSS Subasinha',
                            '',
                            isMobile,
                            showSubtitle: false,
                          ),
                          _buildTeamMember(
                            '• TN Ramanayaka',
                            '',
                            isMobile,
                            showSubtitle: false,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Send Message Button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16.0 : 40.0,
                      vertical: isMobile ? 20.0 : 24.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showContactForm(context, isMobile),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8B6944),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          shadowColor: Color(0xFF8B6944).withOpacity(0.4),
                        ),
                        child: Text(
                          'Send Message',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 15.0 : 16.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactMethod(
    String label,
    String value,
    IconData icon,
    bool isMobile,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF8B6944).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFF8B6944).withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF8B6944),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Color(0xFF2C3E50).withOpacity(0.7),
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      color: Color(0xFF2C3E50),
                      fontSize: isMobile ? 13.0 : 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.arrow_forward_ios, color: Color(0xFF8B6944), size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(
    String name,
    String role,
    bool isMobile, {
    bool showSubtitle = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: isMobile ? 13.0 : 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
        if (showSubtitle && role.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              role,
              style: TextStyle(
                color: Color(0xFF2C3E50).withOpacity(0.6),
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }

  void _showContactForm(BuildContext context, bool isMobile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A2F42),
        title: Text(
          'Send us a Message',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Full Name'),
              SizedBox(height: 12),
              _buildTextField('Email'),
              SizedBox(height: 12),
              _buildTextField('Subject'),
              SizedBox(height: 12),
              _buildTextField('Message', maxLines: 4),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Message sent successfully!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Send', style: TextStyle(color: Color(0xFF8B6944))),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF8B6944)),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  void _launchEmail(String email) {
    // In production, use url_launcher package
    // Launch email client with pre-filled recipient
  }

  void _launchPhone(String phone) {
    // In production, use url_launcher package
    // Launch phone dialer with pre-filled number
  }

  void _launchMaps(String location) {
    // In production, use url_launcher package
    // Launch maps app with location
  }
}
