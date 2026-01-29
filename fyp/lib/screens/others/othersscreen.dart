import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class OthersScreen extends StatelessWidget {
  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
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
            child: Column(
              children: [
                // Header Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 40.0 : 50.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
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
                      SizedBox(height: 20),
                      // Logo
                      Container(
                        width: isMobile ? 70.0 : 80.0,
                        height: isMobile ? 70.0 : 80.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white, width: 2.5),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: isMobile ? 52.0 : 60.0,
                              height: isMobile ? 52.0 : 60.0,
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
                              size: isMobile ? 30.0 : 35.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'RailPulse',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.95),
                          fontSize: isMobile ? 18.0 : 20.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Helpful information and support',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: isMobile ? 13.0 : 14.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Menu Grid
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24.0 : 40.0,
                      vertical: 20.0,
                    ),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: isMobile ? 20 : 24,
                      crossAxisSpacing: isMobile ? 20 : 24,
                      childAspectRatio: isMobile ? 0.95 : 1.0,
                      children: [
                        _buildMenuCard(
                          context,
                          'PROFILE',
                          Icons.person_outline,
                          () => _navigateToPage(context, 'Profile'),
                          isMobile,
                        ),
                        _buildMenuCard(
                          context,
                          'ABOUT US',
                          Icons.info_outline,
                          () => _navigateToPage(context, 'About Us'),
                          isMobile,
                        ),
                        _buildMenuCard(
                          context,
                          'EMERGENCY\nCONTACTS',
                          Icons.phone_in_talk_outlined,
                          () => _navigateToPage(context, 'Emergency Contacts'),
                          isMobile,
                        ),
                        _buildMenuCard(
                          context,
                          'CONTACT US',
                          Icons.mail_outline,
                          () => _navigateToPage(context, 'Contact Us'),
                          isMobile,
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

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
    bool isMobile,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 18 : 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: isMobile ? 38 : 42,
                color: Color(0xFF2C3E50),
              ),
            ),
            SizedBox(height: isMobile ? 16 : 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 12.0 : 13.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                  letterSpacing: 0.8,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String pageName) {
    // Navigate based on page name following Dependency Inversion Principle
    switch (pageName) {
      case 'Profile':
        Navigator.pushNamed(context, AppRoutes.profile);
        break;
      case 'About Us':
        Navigator.pushNamed(context, AppRoutes.aboutUs);
        break;
      case 'Emergency Contacts':
        Navigator.pushNamed(context, AppRoutes.emergencyContacts);
        break;
      case 'Contact Us':
        Navigator.pushNamed(context, AppRoutes.contactUs);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navigating to $pageName'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Color(0xFF6D4C41),
            duration: Duration(seconds: 2),
          ),
        );
    }
  }
}
