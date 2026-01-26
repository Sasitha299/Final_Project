import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as dart_math;

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A2E),
              const Color(0xFF0F3460),
              const Color(0xFF16213E),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Section with modern gradient
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 32.0,
                  vertical: isMobile ? 30.0 : 40.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Welcome text
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.cyan.shade400,
                          Colors.blue.shade400,
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        'WELCOME TO RAILPULSE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Modern Logo with Glassmorphism effect
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.cyan.shade400.withOpacity(0.3),
                            Colors.blue.shade400.withOpacity(0.1),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.cyan.shade400.withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.shade400.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.train,
                        color: Colors.cyan.shade300,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.cyan.shade300,
                          Colors.blue.shade300,
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        'RailPulse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Modern Clock with glassmorphism
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.cyan.shade400.withOpacity(0.15),
                            Colors.blue.shade400.withOpacity(0.05),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.cyan.shade400.withOpacity(0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.shade400.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CustomPaint(painter: ClockPainter(_currentTime)),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        border: Border.all(
                          color: Colors.cyan.shade400.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.cyan.shade300,
                                Colors.blue.shade300,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              _formatTime(_currentTime),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _formatDate(_currentTime),
                            style: TextStyle(
                              color: Colors.cyan.shade200.withOpacity(0.7),
                              fontSize: 14,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Modern Live Train Alerts Banner
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade600.withOpacity(0.2),
                            Colors.orange.shade600.withOpacity(0.1),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.red.shade400.withOpacity(0.5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.shade400.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.shade400.withOpacity(0.6),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'LIVE TRAIN ALERTS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '→',
                            style: TextStyle(
                              color: Colors.red.shade300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Section - Modern Card Design
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12.0 : 24.0,
                  vertical: 24.0,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.cyan.shade600.withOpacity(0.15),
                      Colors.blue.shade600.withOpacity(0.1),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.cyan.shade400.withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.shade400.withOpacity(0.15),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.cyan.shade400,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Quick Info',
                          style: TextStyle(
                            color: Colors.cyan.shade300,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Explore railway routes, check schedules, and plan your journey with RailPulse.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        height: 1.6,
                        letterSpacing: 0.5,
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
