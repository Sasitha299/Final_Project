import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

/// Time Screen - Navigation hub for train schedules
/// Shows three navigation buttons that lead to separate screens:
/// 1. Live Train - navigates to Live Train Updates
/// 2. Time Table - navigates to Time Table Selection (choose a line)
/// 3. Daily Time Table - navigates to Daily Time Table
class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFF1A2F42),
        child: Column(
          children: [
            // Navigation Buttons
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  _buildNavButton(
                    context,
                    label: 'Live Train',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.liveTrainUpdates);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildNavButton(
                    context,
                    label: 'Time Table',
                    onTap: () {
                      Navigator.pushNamed(context, '/timeTableSelection');
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildNavButton(
                    context,
                    label: 'Daily Time Table',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.dailyTimeTable);
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF8B6944),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
