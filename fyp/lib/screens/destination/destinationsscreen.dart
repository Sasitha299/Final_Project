import 'package:flutter/material.dart';
import 'other_lines_screen.dart';
import 'line_detail_screen.dart';

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6D4C41), Color(0xFF5D4037)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.train, size: 48, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'WELCOME TO RAILPULSE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'RailPulse',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'YOUR JOURNEY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'BEGINS HERE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),

              // Railway Lines Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.95,
                    children: [
                      _buildLineCard(
                        context,
                        'MAIN LINE',
                        Icons.train_outlined,
                        () => _selectLine(context, 'Main Line'),
                      ),
                      _buildLineCard(
                        context,
                        'COASTAL LINE',
                        Icons.water,
                        () => _selectLine(context, 'Coastal Line'),
                      ),
                      _buildLineCard(
                        context,
                        'PUTTALAM LINE',
                        Icons.landscape_outlined,
                        () => _selectLine(context, 'Puttalam Line'),
                      ),
                      _buildLineCard(
                        context,
                        'NORTHERN LINE',
                        Icons.explore_outlined,
                        () => _selectLine(context, 'Northern Line'),
                      ),
                      _buildLineCard(
                        context,
                        'KELANI VALLEY LINE',
                        Icons.nature_outlined,
                        () => _selectLine(context, 'Kelani Valley Line'),
                      ),
                      _buildLineCard(
                        context,
                        'EASTERN LINE',
                        Icons.directions_railway_outlined,
                        () => _selectLine(context, 'Eastern Line'),
                      ),
                      _buildLineCard(
                        context,
                        'OTHER LINES',
                        Icons.more_horiz,
                        () => _navigateToOtherLines(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF6D4C41).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: Color(0xFF5D4037)),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3E2723),
                  letterSpacing: 0.5,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectLine(BuildContext context, String lineName) {
    final lineDetails = {
      'Main Line': LineDetail(
        name: 'MAIN LINE',
        description:
            'The Main Line is Sri Lanka\'s primary railway route, connecting the capital city of Colombo to Jaffna in the north. This historic line passes through central highlands and numerous important cities, serving as the backbone of the national rail network.',
        distance: 'Total Length: 348 km from Colombo to Jaffna',
        travelTips:
            '• Book tickets in advance during peak seasons\n• Trains offer first and second class compartments\n• Bring water and snacks as journey takes 8-10 hours\n• The journey offers stunning views of the countryside',
        bestSeason:
            'December to February (cooler and dry season) or May to July (southwest coast)',
        nearbyTransport:
            'Auto-rickshaws, taxis, and local buses are available at major stations. Bicycle rentals at Colombo Fort Station.',
      ),
      'Coastal Line': LineDetail(
        name: 'COASTAL LINE',
        description:
            'The Coastal Line runs along Sri Lanka\'s western coast from Colombo to Matara, offering breathtaking ocean views and access to beautiful beaches, fishing villages, and coastal towns.',
        distance: 'Total Length: 115 km from Colombo to Matara',
        travelTips:
            '• Perfect for day trips from Colombo\n• Many stops near popular beaches\n• Bring swimwear and light clothing\n• Evening trains offer sunset views\n• Photography opportunities abundant',
        bestSeason: 'November to February (dry season on south coast)',
        nearbyTransport:
            'Beach shuttles, tuk-tuks, and local buses. Bicycle rentals available at coastal towns.',
      ),
      'Puttalam Line': LineDetail(
        name: 'PUTTALAM LINE',
        description:
            'The Puttalam Line connects Colombo to Puttalam in the northwest, passing through salt marshes, lagoons, and fishing villages. It\'s known for its scenic lagoon views and access to salt production areas.',
        distance: 'Total Length: 142 km from Colombo to Puttalam',
        travelTips:
            '• Stop at Negombo for beach activities\n• Visit during bird watching season\n• Bring camera for wildlife photography\n• Afternoon trains are less crowded\n• Explore salt marshes on foot',
        bestSeason: 'July to September (bird watching season)',
        nearbyTransport:
            'Boats for lagoon tours, tuk-tuks, and local buses. Bicycle rentals in Negombo.',
      ),
      'Northern Line': LineDetail(
        name: 'NORTHERN LINE',
        description:
            'The Northern Line extends from the Main Line to various locations in the Northern Province, providing access to culturally significant sites, temples, and historical landmarks with unique Jaffna Peninsula heritage.',
        distance: 'Total Length: Approximately 180 km depending on route',
        travelTips:
            '• Allow extra time for security checks\n• Respectful clothing required for temple visits\n• Book accommodation in advance\n• Local guides available at major stops\n• Photography permits may be required',
        bestSeason: 'May to August (northeast dry season)',
        nearbyTransport:
            'Tuk-tuks, shared vans, and local buses. Car rentals available in Jaffna.',
      ),
      'Kelani Valley Line': LineDetail(
        name: 'KELANI VALLEY LINE',
        description:
            'The scenic Kelani Valley Line runs through lush valleys and hills, offering views of tea plantations, waterfalls, and misty mountains. It\'s an excellent route for nature lovers and those seeking mountain scenery.',
        distance: 'Total Length: 113 km from Colombo to Avissawella',
        travelTips:
            '• Bring waterproof jacket for misty areas\n• Tea estate tours available at stops\n• Perfect for photography in early morning\n• Stand on platforms to catch mountain breeze\n• Visit during rainy season for green landscapes',
        bestSeason: 'May to July (post-monsoon fresh scenery)',
        nearbyTransport:
            'Hiking trails, tuk-tuks, and jeeps for plantation tours. Bicycle rentals in valley towns.',
      ),
      'Eastern Line': LineDetail(
        name: 'EASTERN LINE',
        description:
            'The Eastern Line serves the Eastern Province, connecting major towns and providing access to pristine eastern beaches, dry zone wildlife, and historical sites with Hindu temple heritage.',
        distance: 'Total Length: Approximately 200+ km',
        travelTips:
            '• Less crowded than western coast routes\n• Excellent for experiencing authentic villages\n• Bring sun protection for dry climate\n• Local food highly recommended\n• Photography of wildlife and landscapes stunning',
        bestSeason: 'April to September (dry season)',
        nearbyTransport:
            'Safari jeeps for wildlife viewing, tuk-tuks, and local buses. Boat tours available at Batticaloa lagoon.',
      ),
    };

    final detail = lineDetails[lineName];
    if (detail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LineDetailScreen(lineDetail: detail),
        ),
      );
    }
  }

  void _navigateToOtherLines(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OtherLinesScreen()),
    );
  }
}
