import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReserveSeatsView extends StatelessWidget {
  const ReserveSeatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildReservationCard(
          context: context,
          trainName: 'Express 101',
          from: 'Central Station',
          to: 'North Station',
          departureTime: '14:30',
          availableSeats: 45,
          totalSeats: 120,
        ),
        const SizedBox(height: 12),
        _buildReservationCard(
          context: context,
          trainName: 'Local 205',
          from: 'Central Station',
          to: 'South Station',
          departureTime: '14:50',
          availableSeats: 12,
          totalSeats: 80,
        ),
        const SizedBox(height: 12),
        _buildReservationCard(
          context: context,
          trainName: 'Rapid 312',
          from: 'Central Station',
          to: 'East Station',
          departureTime: '15:15',
          availableSeats: 67,
          totalSeats: 150,
        ),
      ],
    );
  }

  Widget _buildReservationCard({
    required BuildContext context,
    required String trainName,
    required String from,
    required String to,
    required String departureTime,
    required int availableSeats,
    required int totalSeats,
  }) {
    double occupancyPercentage = (availableSeats / totalSeats) * 100;

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
                Text(
                  trainName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse('http://bit.ly/45IYPNj');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      // Handle error, maybe show a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not launch URL')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    'Reserve',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  from,
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
                Text(
                  departureTime,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  to,
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: availableSeats / totalSeats,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  availableSeats > 20 ? Colors.green : Colors.orange,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Available: $availableSeats / $totalSeats seats',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
