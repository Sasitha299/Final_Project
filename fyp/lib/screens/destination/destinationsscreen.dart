import 'package:flutter/material.dart';

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
                        () => _selectLine(context, 'Other Lines'),
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
    // Placeholder - replace with your actual navigation logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $lineName'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color(0xFF6D4C41),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
