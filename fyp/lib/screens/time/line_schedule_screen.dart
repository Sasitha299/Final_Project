import 'package:flutter/material.dart';

/// Line Schedule Screen
/// Shows Up Route and Down Route tabs with trains for a selected line
class LineScheduleScreen extends StatefulWidget {
  final String lineName;

  const LineScheduleScreen({super.key, required this.lineName});

  @override
  State<LineScheduleScreen> createState() => _LineScheduleScreenState();
}

class _LineScheduleScreenState extends State<LineScheduleScreen> {
  int _selectedRouteIndex = 0;

  // Sample train data for each line
  final Map<String, Map<String, List<Map<String, dynamic>>>> lineData = {
    'North Line': {
      'upRoute': [
        {
          'trainNo': '4021',
          'route': 'Colombo Fort toward Kankesanthurai',
          'departure': '05:15AM',
          'arrival': '12:15PM',
        },
        {
          'trainNo': '4023',
          'route': 'Colombo Fort toward Kankesanthurai',
          'departure': '08:30AM',
          'arrival': '03:30PM',
        },
        {
          'trainNo': '4025',
          'route': 'Colombo Fort toward Kankesanthurai',
          'departure': '02:45PM',
          'arrival': '09:45PM',
        },
      ],
      'downRoute': [
        {
          'trainNo': '4020',
          'route': 'Kankesanthurai toward Colombo Fort',
          'departure': '05:30AM',
          'arrival': '12:30PM',
        },
        {
          'trainNo': '4022',
          'route': 'Kankesanthurai toward Colombo Fort',
          'departure': '09:00AM',
          'arrival': '04:00PM',
        },
      ],
    },
    'Coastal Line': {
      'upRoute': [
        {
          'trainNo': '0065',
          'route': 'Colombo toward Matara',
          'departure': '06:00AM',
          'arrival': '09:00AM',
        },
        {
          'trainNo': '0067',
          'route': 'Colombo toward Matara',
          'departure': '12:30PM',
          'arrival': '03:30PM',
        },
      ],
      'downRoute': [
        {
          'trainNo': '0064',
          'route': 'Matara toward Colombo',
          'departure': '07:00AM',
          'arrival': '10:00AM',
        },
      ],
    },
    'Main Line': {
      'upRoute': [
        {
          'trainNo': '001',
          'route': 'Colombo toward Jaffna',
          'departure': '06:30AM',
          'arrival': '02:30PM',
        },
      ],
      'downRoute': [
        {
          'trainNo': '002',
          'route': 'Jaffna toward Colombo',
          'departure': '04:00PM',
          'arrival': '12:00AM',
        },
      ],
    },
    'Eastern Line': {
      'upRoute': [
        {
          'trainNo': '501',
          'route': 'Colombo toward Batticaloa',
          'departure': '07:15AM',
          'arrival': '04:15PM',
        },
      ],
      'downRoute': [
        {
          'trainNo': '500',
          'route': 'Batticaloa toward Colombo',
          'departure': '05:30AM',
          'arrival': '02:30PM',
        },
      ],
    },
    'Kelani Valley Line': {
      'upRoute': [
        {
          'trainNo': '301',
          'route': 'Colombo toward Avissawella',
          'departure': '06:45AM',
          'arrival': '08:45AM',
        },
      ],
      'downRoute': [
        {
          'trainNo': '300',
          'route': 'Avissawella toward Colombo',
          'departure': '04:00PM',
          'arrival': '06:00PM',
        },
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final routeData = lineData[widget.lineName] ?? lineData['North Line']!;
    final upTrains = routeData['upRoute'] ?? [];
    final downTrains = routeData['downRoute'] ?? [];
    final currentTrains =
        _selectedRouteIndex == 0 ? upTrains : downTrains;

    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            color: Colors.teal[800],
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      SizedBox(width: 8),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Line name
                Text(
                  widget.lineName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Route Tabs
          Container(
            color: const Color(0xFF1A2F42),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildRouteTab(
                    label: 'Up Route',
                    isSelected: _selectedRouteIndex == 0,
                    onTap: () => setState(() => _selectedRouteIndex = 0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRouteTab(
                    label: 'Down Route',
                    isSelected: _selectedRouteIndex == 1,
                    onTap: () => setState(() => _selectedRouteIndex = 1),
                  ),
                ),
              ],
            ),
          ),
          // Train Cards List
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: currentTrains.length,
                itemBuilder: (context, index) {
                  return _buildTrainCard(currentTrains[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B6944) : const Color(0xFF5D4037),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrainCard(Map<String, dynamic> train) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FF),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Train number with icon
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.train,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Train No: ${train['trainNo']}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    train['route'],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Departure and Arrival times
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DEPARTURE TIME:',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    train['departure'],
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'ARRIVAL TIME:',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    train['arrival'],
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
