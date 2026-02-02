import 'package:flutter/material.dart';

class LiveTrainAlertsView extends StatelessWidget {
  const LiveTrainAlertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAlertCard(
          title: 'Express 101 - Delayed',
          description: 'Expected delay of 15 minutes due to track maintenance.',
          severity: 'High',
          severityColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildAlertCard(
          title: 'Local 205 - On Schedule',
          description: 'All systems normal. Running on time.',
          severity: 'Normal',
          severityColor: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildAlertCard(
          title: 'Rapid 312 - Service Update',
          description: 'Minor delay expected. Please check station displays.',
          severity: 'Medium',
          severityColor: Colors.amber,
        ),
      ],
    );
  }

  Widget _buildAlertCard({
    required String title,
    required String description,
    required String severity,
    required Color severityColor,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: severityColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    severity,
                    style: TextStyle(
                      color: severityColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: TextStyle(fontSize: 11, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
