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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6D4C41), Color(0xFF5D4037)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        lineDetail.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Details Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailCard(
                        context,
                        title: 'Description',
                        content: lineDetail.description,
                        icon: Icons.description,
                      ),
                      SizedBox(height: 16),
                      _buildDetailCard(
                        context,
                        title: 'Distance from Station',
                        content: lineDetail.distance,
                        icon: Icons.straighten,
                      ),
                      SizedBox(height: 16),
                      _buildDetailCard(
                        context,
                        title: 'Travel Tips',
                        content: lineDetail.travelTips,
                        icon: Icons.lightbulb,
                      ),
                      SizedBox(height: 16),
                      _buildDetailCard(
                        context,
                        title: 'Best Season',
                        content: lineDetail.bestSeason,
                        icon: Icons.calendar_today,
                      ),
                      SizedBox(height: 16),
                      _buildDetailCard(
                        context,
                        title: 'Nearby Transport',
                        content: lineDetail.nearbyTransport,
                        icon: Icons.directions_bus,
                      ),
                      SizedBox(height: 30),
                      // Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                          label: Text('Go Back'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFF3E0),
                            foregroundColor: Color(0xFF5D4037),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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
    );
  }

  Widget _buildDetailCard(
    BuildContext ctx, {
    required String title,
    required String content,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => TopicDetailScreen(
              lineName: lineDetail.name,
              topicTitle: title,
              topicContent: content,
              topicIcon: icon,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Color(0xFF5D4037), size: 24),
                    SizedBox(width: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3E2723),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward, color: Color(0xFF5D4037), size: 20),
              ],
            ),
            SizedBox(height: 12),
            Text(
              content.length > 100
                  ? '${content.substring(0, 100)}...'
                  : content,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5D4037),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
