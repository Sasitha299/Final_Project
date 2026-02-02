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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              final url = Uri.parse(
                'https://seatreservation.railway.gov.lk/mtktwebslr/',
              );
              await launchUrl(url);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              minimumSize: const Size(80, 80),
            ),
            child: const Text('Reserve', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
