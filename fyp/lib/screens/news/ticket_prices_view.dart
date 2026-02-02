import 'package:flutter/material.dart';

class TicketPricesView extends StatelessWidget {
  const TicketPricesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildPriceCard(
          routeName: 'Central to North Station',
          basicPrice: '₹50',
          premiumPrice: '₹80',
          distance: '25 km',
        ),
        const SizedBox(height: 12),
        _buildPriceCard(
          routeName: 'Central to South Station',
          basicPrice: '₹40',
          premiumPrice: '₹65',
          distance: '18 km',
        ),
        const SizedBox(height: 12),
        _buildPriceCard(
          routeName: 'Central to East Station',
          basicPrice: '₹60',
          premiumPrice: '₹95',
          distance: '30 km',
        ),
      ],
    );
  }

  Widget _buildPriceCard({
    required String routeName,
    required String basicPrice,
    required String premiumPrice,
    required String distance,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              routeName,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              distance,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Basic',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                    Text(
                      basicPrice,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(height: 40, width: 1, color: Colors.grey[300]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Premium',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                    Text(
                      premiumPrice,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
