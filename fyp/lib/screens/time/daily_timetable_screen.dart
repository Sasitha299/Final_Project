import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Daily Time Table Display Screen - Highway/Road View
/// Shows trains like a GPS/Navigation interface on a road background
/// SOLID Principles: Single Responsibility, Open/Closed, Dependency Inversion
class DailyTimeTableScreen extends StatelessWidget {
  const DailyTimeTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy - EEE').format(DateTime.now()).toUpperCase();

    final List<Map<String, dynamic>> trains = [
      {
        'trainNo': '675',
        'time': '10:05AM',
        'route': 'COLOMBO TO BELIATHTHA',
        'distance': '45 km',
      },
      {
        'trainNo': '0065',
        'time': '12:50PM',
        'route': 'COLOMBO TO GALLE',
        'distance': '115 km',
      },
      {
        'trainNo': '675',
        'time': '02:45PM',
        'route': 'COLOMBO TO ALUTHGAMA',
        'distance': '65 km',
      },
      {
        'trainNo': '123',
        'time': '04:30PM',
        'route': 'COLOMBO TO KANDY',
        'distance': '125 km',
      },
      {
        'trainNo': '456',
        'time': '06:15PM',
        'route': 'COLOMBO TO MATARA',
        'distance': '160 km',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daily Time Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Highway background
          Container(
            color: const Color(0xFFB0BEC5),
            child: CustomPaint(
              painter: HighwayPainter(),
              size: Size.infinite,
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Date display header
                Container(
                  color: const Color(0xFF8B6944).withOpacity(0.9),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Train cards on road
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: List.generate(
                      trains.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildRoadTrainCard(trains[index], context, index),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadTrainCard(Map<String, dynamic> train, BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Train header with number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B6944),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.train,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Train No: ${train['trainNo']}',
                        style: const TextStyle(
                          color: Color(0xFF8B6944),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '#${index + 1} on route',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B6944).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  train['distance'],
                  style: const TextStyle(
                    color: Color(0xFF8B6944),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Route and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      train['route'],
                      style: const TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          train['time'],
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Live Station - Train No: ${train['trainNo']}',
                        ),
                        backgroundColor: const Color(0xFF8B6944),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B6944),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'LIVE STATION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Stop Stations - Train No: ${train['trainNo']}',
                        ),
                        backgroundColor: const Color(0xFF8B6944),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Color(0xFF8B6944),
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'STOP STATIONS',
                    style: TextStyle(
                      color: Color(0xFF8B6944),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter to draw highway road lines
class HighwayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final dashedPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw road lanes
    for (int i = 0; i < 5; i++) {
      double yPosition = (i * size.height / 4).toDouble();
      
      // Draw dashed center lines
      for (double x = 0; x < size.width; x += 30) {
        canvas.drawLine(
          Offset(x, yPosition),
          Offset(x + 20, yPosition),
          dashedPaint,
        );
      }
    }

    // Draw road edges
    canvas.drawLine(
      Offset(0, size.height * 0.2),
      Offset(size.width, size.height * 0.2),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.8),
      Offset(size.width, size.height * 0.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
