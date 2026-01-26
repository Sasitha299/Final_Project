import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> categories = [
    'Main News',
    'Live Train Alerts',
    'Reserve Seats',
    'Ticket Prices',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Category Navigation
          Container(
            color: Colors.grey[200],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  categories.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _selectedCategoryIndex = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedCategoryIndex == index
                                ? const Color.fromARGB(255, 132, 88, 88)!
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _selectedCategoryIndex == index
                              ? Colors.grey[700]
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Content Area
          Expanded(child: _buildCategoryContent()),
        ],
      ),
    );
  }

  Widget _buildCategoryContent() {
    switch (_selectedCategoryIndex) {
      case 0:
        return _buildMainNewsView();
      case 1:
        return _buildLiveTrainAlertsView();
      case 2:
        return _buildReserveSeatsView();
      case 3:
        return _buildTicketPricesView();
      default:
        return const Center(child: Text('No content'));
    }
  }

  Widget _buildMainNewsView() {
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

  Widget _buildLiveTrainAlertsView() {
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

  Widget _buildReserveSeatsView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildReservationCard(
          trainName: 'Express 101',
          from: 'Central Station',
          to: 'North Station',
          departureTime: '14:30',
          availableSeats: 45,
          totalSeats: 120,
        ),
        const SizedBox(height: 12),
        _buildReservationCard(
          trainName: 'Local 205',
          from: 'Central Station',
          to: 'South Station',
          departureTime: '14:50',
          availableSeats: 12,
          totalSeats: 80,
        ),
        const SizedBox(height: 12),
        _buildReservationCard(
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

  Widget _buildTicketPricesView() {
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

  Widget _buildReservationCard({
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
                  onPressed: () {},
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
