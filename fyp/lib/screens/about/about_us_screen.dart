import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

/// About Us Screen - Project and company information
/// Follows:
/// - Single Responsibility Principle (SRP): Handles only about display
/// - Open/Closed Principle (OCP): Can be extended without modification
/// - Dependency Inversion Principle (DIP): Depends on abstractions
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
                      'ABOUT US',
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
                          // Project Overview
                          _buildDescriptionText(
                            'This project is developed by a team of final-year undergraduate students at SLIIT. The project focuses on building a non-intrusive real-time train arrival information system to improve passenger experience in Sri Lanka.',
                            isMobile,
                          ),
                          SizedBox(height: isMobile ? 16 : 20),

                          // Project Leadership
                          _buildDescriptionText(
                            'The project is carried out under the guidance of:',
                            isMobile,
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Supervisors List
                          _buildListItem(
                            'Supervisor: Prof. Chulantha Kulasekara',
                            isMobile,
                          ),
                          SizedBox(height: 8),
                          _buildListItem(
                            'Co-Supervisor: Ms. Nayomi Fernando',
                            isMobile,
                          ),
                          SizedBox(height: isMobile ? 16 : 20),

                          // Team Section Header
                          _buildTeamHeader('✓ Project Team Members', isMobile),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Team Members List
                          _buildTeamMemberItem('RAIR WijeSekara', isMobile),
                          SizedBox(height: 8),
                          _buildTeamMemberItem('RMSS Subasinha', isMobile),
                          SizedBox(height: 8),
                          _buildTeamMemberItem('TN Ramanayaka', isMobile),
                          SizedBox(height: isMobile ? 16 : 20),

                          // Project Goals
                          _buildDescriptionText(
                            'This system is designed as part of our final year project, with the goal of using modern technology to provide accurate and reliable train information for both local passengers and tourists.',
                            isMobile,
                          ),
                        ],
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

  Widget _buildSectionTitle(String title, bool isMobile) {
    return Text(
      title,
      style: TextStyle(
        color: Color(0xFF2C3E50),
        fontSize: isMobile ? 16.0 : 18.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildDescriptionText(String text, bool isMobile) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFF2C3E50).withOpacity(0.8),
        fontSize: isMobile ? 13.0 : 14.0,
        fontWeight: FontWeight.w400,
        height: 1.6,
        letterSpacing: 0.3,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildListItem(String text, bool isMobile) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Color(0xFF2C3E50),
              fontSize: isMobile ? 14.0 : 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF2C3E50),
                fontSize: isMobile ? 13.0 : 14.0,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamHeader(String text, bool isMobile) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFF2C3E50),
        fontSize: isMobile ? 13.0 : 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildTeamMemberItem(String name, bool isMobile) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Color(0xFF2C3E50),
              fontSize: isMobile ? 14.0 : 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: Color(0xFF2C3E50),
                fontSize: isMobile ? 13.0 : 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(
    String role,
    String name,
    IconData icon,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF8B6944).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF8B6944).withOpacity(0.2), width: 1),
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
                  role,
                  style: TextStyle(
                    color: Color(0xFF2C3E50).withOpacity(0.7),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  name,
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
        ],
      ),
    );
  }

  Widget _buildTeamMembersList(bool isMobile) {
    final members = ['RAIR WijeSekara', 'RMSS Subasinha', 'TN Ramanayaka'];

    return Column(
      children: List.generate(
        members.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index < members.length - 1 ? 10 : 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(0xFF8B6944),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '✓',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  members[index],
                  style: TextStyle(
                    color: Color(0xFF2C3E50),
                    fontSize: isMobile ? 13.0 : 14.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList(bool isMobile) {
    final features = [
      'Real-time train arrival information',
      'Non-intrusive system design',
      'User-friendly mobile interface',
      'Multi-language support',
      'Offline functionality',
    ];

    return Column(
      children: List.generate(
        features.length,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index < features.length - 1 ? 10 : 0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '•',
                style: TextStyle(
                  color: Color(0xFF8B6944),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  features[index],
                  style: TextStyle(
                    color: Color(0xFF2C3E50),
                    fontSize: isMobile ? 13.0 : 14.0,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechStack(bool isMobile) {
    final technologies = [
      'Flutter - Mobile App Development',
      'Dart - Programming Language',
      'Firebase - Backend Services',
      'Google Maps API - Location Services',
      'REST API - Data Integration',
    ];

    return Column(
      children: List.generate(
        technologies.length,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index < technologies.length - 1 ? 10 : 0,
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF8B6944).withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF8B6944).withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF8B6944),
                  size: 18,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    technologies[index],
                    style: TextStyle(
                      color: Color(0xFF2C3E50),
                      fontSize: isMobile ? 13.0 : 14.0,
                      fontWeight: FontWeight.w500,
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
