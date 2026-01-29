import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as dart_math;
import '../../routes/app_routes.dart';

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
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Section - Welcome header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 32.0,
                  vertical: isMobile ? 24.0 : 32.0,
                ),
                decoration: BoxDecoration(color: Color(0xFFE8E8E8)),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    // Welcome text
                    const Text(
                      'WELCOME TO RAILPULSE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Logo with Glassmorphism effect
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.9),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.train,
                        color: Colors.grey.shade600,
                        size: 38,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'RailPulse',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Card Section
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 32.0,
                  vertical: 24.0,
                ),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Column(
                    children: [
                      // Clock and time section with background
                      Container(
                        width: double.infinity,
                        height: 280,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/train_background.jpg',
                            ),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {},
                          ),
                          color: Colors.grey[300],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Gradient overlay
                            Container(
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
                            // Clock
                            Positioned(
                              top: 24,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: CustomPaint(
                                  painter: ClockPainter(_currentTime),
                                ),
                              ),
                            ),
                            // Time and date
                            Positioned(
                              bottom: 24,
                              child: Column(
                                children: [
                                  Text(
                                    _formatTime(_currentTime),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 42,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 4,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _formatDate(_currentTime),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Live Train Alerts Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.liveTrainUpdates,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF5252),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFFF5252).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.warning,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'LIVE TRAIN ALERTS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Quick Info Section
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 32.0,
                  vertical: 8.0,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF5F5),
                  border: Border.all(color: Color(0xFFFFE8E8), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey[600], size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Info',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Explore railway routes and plan your journey with railpulse',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for analog clock
class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = size.width / 2;

    final fillBrush = Paint()..color = const Color(0xFF8B5A3C);
    final outlineBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius - 2, fillBrush);

    // Draw hour markers
    final hourMarkerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    for (int i = 0; i < 12; i++) {
      final angle = (i * 30 - 90) * (3.14159 / 180);
      final x1 = centerX + (radius - 12) * cos(angle);
      final y1 = centerY + (radius - 12) * sin(angle);
      final x2 = centerX + (radius - 20) * cos(angle);
      final y2 = centerY + (radius - 20) * sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourMarkerPaint);
    }

    // Hour hand
    final hourAngle =
        ((dateTime.hour % 12 + dateTime.minute / 60) * 30 - 90) *
        (3.14159 / 180);
    final hourHandPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(
        centerX + (radius - 35) * cos(hourAngle),
        centerY + (radius - 35) * sin(hourAngle),
      ),
      hourHandPaint,
    );

    // Minute hand
    final minuteAngle = (dateTime.minute * 6 - 90) * (3.14159 / 180);
    final minuteHandPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(
        centerX + (radius - 20) * cos(minuteAngle),
        centerY + (radius - 20) * sin(minuteAngle),
      ),
      minuteHandPaint,
    );

    // Second hand
    final secondAngle = (dateTime.second * 6 - 90) * (3.14159 / 180);
    final secondHandPaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(
        centerX + (radius - 15) * cos(secondAngle),
        centerY + (radius - 15) * sin(secondAngle),
      ),
      secondHandPaint,
    );

    // Center dot
    final centerDotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 5, centerDotPaint);
  }

  double cos(double angle) => dart_math.cos(angle);
  double sin(double angle) => dart_math.sin(angle);

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;
}
