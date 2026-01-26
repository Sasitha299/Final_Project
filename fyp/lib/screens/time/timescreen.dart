import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Train Schedule'), elevation: 0),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTabIndex = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTabIndex == 0
                                ? Colors.grey[400]!
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Live Train',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedTabIndex == 0
                              ? Colors.grey[700]
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTabIndex = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTabIndex == 1
                                ? Colors.grey[400]!
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Time Table',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedTabIndex == 1
                              ? Colors.grey[700]
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content Area
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildLiveTrainView()
                : _buildTimeTableView(),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTrainView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTrainCard(
          trainName: 'Express 101',
          from: 'Central Station',
          to: 'North Station',
          departureTime: '14:30',
          arrivalTime: '15:45',
          status: 'On Time',
          statusColor: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildTrainCard(
          trainName: 'Local 205',
          from: 'Central Station',
          to: 'South Station',
          departureTime: '14:50',
          arrivalTime: '15:20',
          status: 'Delayed',
          statusColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildTrainCard(
          trainName: 'Rapid 312',
          from: 'Central Station',
          to: 'East Station',
          departureTime: '15:15',
          arrivalTime: '16:00',
          status: 'On Time',
          statusColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildTimeTableView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTimeTableCard(
          trainName: 'Express 101',
          schedule: [
            {'station': 'Central Station', 'time': '14:30'},
            {'station': 'Main Stop', 'time': '14:50'},
            {'station': 'West Junction', 'time': '15:15'},
            {'station': 'North Station', 'time': '15:45'},
          ],
        ),
        const SizedBox(height: 12),
        _buildTimeTableCard(
          trainName: 'Local 205',
          schedule: [
            {'station': 'Central Station', 'time': '14:50'},
            {'station': 'Avenue Stop', 'time': '15:00'},
            {'station': 'South Station', 'time': '15:20'},
          ],
        ),
        const SizedBox(height: 12),
        _buildTimeTableCard(
          trainName: 'Rapid 312',
          schedule: [
            {'station': 'Central Station', 'time': '15:15'},
            {'station': 'Plaza Stop', 'time': '15:35'},
            {'station': 'East Station', 'time': '16:00'},
          ],
        ),
      ],
    );
  }

  Widget _buildTrainCard({
    required String trainName,
    required String from,
    required String to,
    required String departureTime,
    required String arrivalTime,
    required String status,
    required Color statusColor,
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
                Text(
                  trainName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      from,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      departureTime,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Icon(Icons.arrow_forward, size: 20),
                    Text(
                      arrivalTime,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'To',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      to,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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

  Widget _buildTimeTableCard({
    required String trainName,
    required List<Map<String, String>> schedule,
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
              trainName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(
                schedule.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          schedule[index]['station']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        schedule[index]['time']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
