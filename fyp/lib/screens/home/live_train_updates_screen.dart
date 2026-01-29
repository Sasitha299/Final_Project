import 'package:flutter/material.dart';

/// Live Train Updates Screen
/// Shows real-time train updates with My Trains and Search functionality
/// SOLID Principles: Single Responsibility, Open/Closed, Dependency Inversion
class LiveTrainUpdatesScreen extends StatefulWidget {
  const LiveTrainUpdatesScreen({Key? key}) : super(key: key);

  @override
  State<LiveTrainUpdatesScreen> createState() => _LiveTrainUpdatesScreenState();
}

class _LiveTrainUpdatesScreenState extends State<LiveTrainUpdatesScreen> {
  int _selectedTabIndex = 0;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> trainUpdates = [
      {
        'trainNo': '2345',
        'time': '05:05AM',
        'route': 'ANURADHAPURA TO BELIATHTHA',
      },
      {
        'trainNo': '2345',
        'time': '05:05AM',
        'route': 'ANURADHAPURA TO BELIATHTHA',
      },
      {
        'trainNo': '2345',
        'time': '05:05AM',
        'route': 'ANURADHAPURA TO BELIATHTHA',
      },
      {'trainNo': '0675', 'time': '08:30AM', 'route': 'COLOMBO TO GALLE'},
      {'trainNo': '0123', 'time': '10:15AM', 'route': 'COLOMBO TO KANDY'},
    ];

    return Scaffold(
      body: Column(
        children: [
          // Header with back button and title
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back, color: Colors.black, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // LIVE TRAIN UPDATES title
                const Text(
                  'LIVE TRAIN UPDATES',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Tabs
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTabIndex = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 0
                                ? const Color(0xFF8B6944)
                                : const Color(0xFFD7CCC8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'MY TRAINS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTabIndex = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 1
                                ? const Color(0xFF8B6944)
                                : const Color(0xFFD7CCC8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Search...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Content area
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildMyTrainsView(trainUpdates)
                : _buildSearchView(),
          ),
        ],
      ),
    );
  }

  Widget _buildMyTrainsView(List<Map<String, dynamic>> trainUpdates) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: trainUpdates.length,
        itemBuilder: (context, index) {
          return _buildTrainUpdateCard(trainUpdates[index]);
        },
      ),
    );
  }

  Widget _buildSearchView() {
    final List<Map<String, dynamic>> searchResults =
        _searchController.text.isEmpty
        ? []
        : [
            {
              'trainNo': '2345',
              'time': '05:05AM',
              'route': 'ANURADHAPURA TO BELIATHTHA',
            },
            {'trainNo': '0675', 'time': '08:30AM', 'route': 'COLOMBO TO GALLE'},
            {'trainNo': '0123', 'time': '10:15AM', 'route': 'COLOMBO TO KANDY'},
          ];

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search train number or route...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          if (_searchController.text.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'Enter train number or route to search',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return _buildSearchResultCard(searchResults[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchResultCard(Map<String, dynamic> train) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFB8A892),
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
                  color: Colors.grey[600],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.train, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Train No: ${train['trainNo']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    train['time'],
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Route
          Text(
            train['route'],
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 14),
          // Live Station button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Live Station - Train No: ${train['trainNo']}',
                    ),
                    backgroundColor: const Color(0xFF8B6944),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0B8B8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'LIVE STATION',
                style: TextStyle(
                  color: Color(0xFFD32F2F),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Bidirectional arrow
          Center(
            child: Icon(Icons.unfold_more, color: Colors.white70, size: 28),
          ),
          const SizedBox(height: 12),
          // Search field for estimated arrival
          TextField(
            decoration: InputDecoration(
              hintText: 'SEARCH...',
              hintStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white70,
                size: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.white30),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          // Estimated arrival text
          const Text(
            'Estimated Arrival Time at Your Station',
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 12),
          // Stop Stations button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Stop Stations - Train No: ${train['trainNo']}',
                    ),
                    backgroundColor: const Color(0xFF8B6944),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0B8B8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'STOP STATIONS',
                style: TextStyle(
                  color: Color(0xFFD32F2F),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainUpdateCard(Map<String, dynamic> train) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FF),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Train number with icon
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.train, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Train No: ${train['trainNo']}',
                style: const TextStyle(
                  color: Color(0xFF424242),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Time
          Text(
            train['time'],
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Route
          Text(
            train['route'],
            style: const TextStyle(color: Color(0xFF424242), fontSize: 12),
          ),
          const SizedBox(height: 10),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Live Station - Train No: ${train['trainNo']}',
                        ),
                        backgroundColor: const Color(0xFF8B6944),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0B8B8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'LIVE STATION',
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Stop Stations - Train No: ${train['trainNo']}',
                        ),
                        backgroundColor: const Color(0xFF8B6944),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0B8B8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'STOP STATIONS',
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
