import 'package:flutter/material.dart';

/// Time Table Selection Screen
/// Shows 5 railway lines to choose from
class TimeTableSelectionScreen extends StatelessWidget {
  const TimeTableSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lines = [
      {'name': 'North Line', 'color': Color(0xFF7C4DFF)},
      {'name': 'Coastal Line', 'color': Color(0xFF00ACC1)},
      {'name': 'Main Line', 'color': Color(0xFFF57C00)},
      {'name': 'Eastern Line', 'color': Color(0xFF00796B)},
      {'name': 'Kelani Valley Line', 'color': Color(0xFF5E35B1)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Railway Line'),
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFF1A2F42),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: lines.length,
          itemBuilder: (context, index) {
            return _buildLineCard(
              context,
              lineName: lines[index]['name'] as String,
              color: lines[index]['color'] as Color,
            );
          },
        ),
      ),
    );
  }

  Widget _buildLineCard(
    BuildContext context, {
    required String lineName,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/lineSchedule',
          arguments: lineName,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lineName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tap to view schedule',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
