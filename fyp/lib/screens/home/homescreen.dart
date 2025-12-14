import 'package:flutter/material.dart';

/// Home Screen - Main content area
/// Responsive design for all device sizes
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    // Responsive padding
    final horizontalPadding = isMobile
        ? 16.0
        : isTablet
        ? 32.0
        : 48.0;
    final verticalPadding = isMobile ? 16.0 : 24.0;
    final titleFontSize = isMobile
        ? 24.0
        : isTablet
        ? 28.0
        : 32.0;
    final subtitleFontSize = isMobile ? 14.0 : 16.0;
    final cardFontSize = isMobile ? 16.0 : 18.0;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              'Welcome to RailPulse',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your railway information companion',
              style: TextStyle(
                fontSize: subtitleFontSize,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: isMobile ? 24.0 : 32.0),

            // Featured Cards
            _buildFeatureCard(
              context,
              'Train Status',
              'Check real-time train information',
              Icons.train,
              cardFontSize,
              isMobile,
            ),
            SizedBox(height: isMobile ? 16.0 : 20.0),
            _buildFeatureCard(
              context,
              'Schedule',
              'View upcoming train schedules',
              Icons.schedule,
              cardFontSize,
              isMobile,
            ),
            SizedBox(height: isMobile ? 16.0 : 20.0),
            _buildFeatureCard(
              context,
              'Announcements',
              'Latest railway announcements',
              Icons.notifications,
              cardFontSize,
              isMobile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    double fontSize,
    bool isMobile,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16.0 : 20.0),
        child: Row(
          children: [
            Container(
              width: isMobile ? 50 : 60,
              height: isMobile ? 50 : 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.blue.shade600,
                size: isMobile ? 28 : 32,
              ),
            ),
            SizedBox(width: isMobile ? 16.0 : 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: isMobile ? 12.0 : 14.0,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
