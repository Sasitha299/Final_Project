import 'package:flutter/material.dart';
import 'topic_detail_screen.dart';

class LineDetail {
  final String name;
  final String description;
  final String distance;
  final String travelTips;
  final String bestSeason;
  final String nearbyTransport;

  LineDetail({
    required this.name,
    required this.description,
    required this.distance,
    required this.travelTips,
    required this.bestSeason,
    required this.nearbyTransport,
  });
}

class LineDetailScreen extends StatelessWidget {
  final LineDetail lineDetail;

  const LineDetailScreen({super.key, required this.lineDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image Section
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(color: Color(0xFF6D4C41)),
                  child: Image.asset(
                    _getImageForLine(lineDetail.name),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Color(0xFF6D4C41),
                        child: Icon(
                          Icons.train,
                          size: 100,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      );
                    },
                  ),
                ),
                // Gradient overlay
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
                // Back button
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                // Title on image
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Text(
                    lineDetail.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),

            // Menu Buttons Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: Column(
                children: [
                  _buildMenuButton(
                    context,
                    title: 'DESCRIPTION',
                    content: lineDetail.description,
                    topicTitle: 'Description',
                  ),
                  SizedBox(height: 12),
                  _buildMenuButton(
                    context,
                    title: 'DISTANCE FROM STATION',
                    content: lineDetail.distance,
                    topicTitle: 'Distance from Station',
                  ),
                  SizedBox(height: 12),
                  _buildMenuButton(
                    context,
                    title: 'BEST SEASON',
                    content: lineDetail.bestSeason,
                    topicTitle: 'Best Season',
                  ),
                  SizedBox(height: 12),
                  _buildMenuButton(
                    context,
                    title: 'TRAVEL TIPS',
                    content: lineDetail.travelTips,
                    topicTitle: 'Travel Tips',
                  ),
                  SizedBox(height: 12),
                  _buildMenuButton(
                    context,
                    title: 'NEARBY TRANSPORT',
                    content: lineDetail.nearbyTransport,
                    topicTitle: 'Nearby Transport',
                  ),
                  SizedBox(height: 24),
                  // Back button at bottom
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5D4037),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'GO BACK',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext ctx, {
    required String title,
    required String content,
    required String topicTitle,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => TopicDetailScreen(
              lineName: lineDetail.name,
              topicTitle: topicTitle,
              topicContent: content,
              topicIcon: Icons.info,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Color(0xFF5D4037),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  String _getImageForLine(String lineName) {
    switch (lineName) {
      case 'MAIN LINE':
        return 'assets/images/main_line.jpg';
      case 'COASTAL LINE':
        return 'assets/images/coastal_line.jpg';
      case 'PUTTALAM LINE':
        return 'assets/images/puttalam_line.jpg';
      case 'NORTHERN LINE':
        return 'assets/images/northern_line.jpg';
      case 'KELANI VALLEY LINE':
        return 'assets/images/kelani_line.jpg';
      case 'EASTERN LINE':
        return 'assets/images/eastern_line.jpg';
      default:
        return 'assets/images/main_line.jpg';
    }
  }
}
