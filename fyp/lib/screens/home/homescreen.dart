import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

/// Home Screen - RailPulse Main Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final second = time.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  String _formatDate(DateTime time) {
    final year = time.year;
    final month = time.month.toString().padLeft(2, '0');
    final day = time.day.toString().padLeft(2, '0');
    return '$year / $month / $day';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF8B5A3C),
      body: Column(
        children: [
          // Top Brown Section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: isMobile ? 24 : 32,
            ),
            child: Column(
              children: [
                // Welcome Text
                Text(
                  'WELCOME TO RAILPULSE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 16 : 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 20 : 24),

                // Logo
                Container(
                  width: isMobile ? 80 : 100,
                  height: isMobile ? 80 : 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: isMobile ? 65 : 80,
                        height: isMobile ? 65 : 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Icon(
                        Icons.train,
                        color: Colors.white,
                        size: isMobile ? 35 : 40,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 16),

                // RailPulse Text
                Text(
                  'RailPulse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // Clock
                Container(
                  width: isMobile ? 100 : 120,
                  height: isMobile ? 100 : 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle,
                  ),
                  child: CustomPaint(
                    painter: ClockPainter(time: _currentTime),
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 16),

                // Time Display
                Text(
                  _formatTime(_currentTime),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: isMobile ? 4 : 8),

                // Date Display
                Text(
                  _formatDate(_currentTime),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 16,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 24),

                // Live Train Alerts Button
                GestureDetector(
                  onTap: () {
                    // Navigate to alerts page
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'LIVE TRAIN ALERTS',
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontSize: isMobile ? 14 : 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.red.shade600,
                          size: isMobile ? 20 : 24,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.red.shade600,
                          size: isMobile ? 20 : 24,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.red.shade600,
                          size: isMobile ? 20 : 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Train Image Section
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1474487548417-781cb71495f3?w=800',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF8B5A3C).withOpacity(0.3),
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Clock Painter
class ClockPainter extends CustomPainter {
  final DateTime time;

  ClockPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw clock circle markers (12 hour markers)
    final markerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 12; i++) {
      final angle = (i * 30 - 90) * math.pi / 180;
      final x = center.dx + (radius - 12) * math.cos(angle);
      final y = center.dy + (radius - 12) * math.sin(angle);
      canvas.drawCircle(Offset(x, y), 3, markerPaint);
    }

    // Hour hand
    final hourAngle =
        ((time.hour % 12) * 30 + time.minute * 0.5 - 90) * math.pi / 180;
    final hourPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      center,
      Offset(
        center.dx + (radius * 0.4) * math.cos(hourAngle),
        center.dy + (radius * 0.4) * math.sin(hourAngle),
      ),
      hourPaint,
    );

    // Minute hand
    final minuteAngle = (time.minute * 6 - 90) * math.pi / 180;
    final minutePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      center,
      Offset(
        center.dx + (radius * 0.6) * math.cos(minuteAngle),
        center.dy + (radius * 0.6) * math.sin(minuteAngle),
      ),
      minutePaint,
    );

    // Center dot
    canvas.drawCircle(center, 5, markerPaint);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}