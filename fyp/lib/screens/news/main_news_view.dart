import 'package:flutter/material.dart';

class MainNewsView extends StatelessWidget {
  const MainNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildNewsCard(
          title: 'New Express Route Launched',
          description:
              'The new Express Route connecting Central to North Station is now operational.',
          date: '26 Jan 2026',
          icon: Icons.announcement,
        ),
        const SizedBox(height: 12),
        _buildNewsCard(
          title: 'Maintenance Update',
          description:
              'Scheduled maintenance on Line 5 completed. Services resuming normally.',
          date: '25 Jan 2026',
          icon: Icons.build,
        ),
        const SizedBox(height: 12),
        _buildNewsCard(
          title: 'Peak Hour Schedule Changes',
          description:
              'New peak hour timings effective from next month. Check updated schedules.',
          date: '24 Jan 2026',
          icon: Icons.schedule,
        ),
      ],
    );
  }

  Widget _buildNewsCard({
    required String title,
    required String description,
    required String date,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.grey[600], size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        date,
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
