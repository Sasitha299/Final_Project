import 'package:flutter/material.dart';

import '../../api/train.dart';

/// Live Train Updates Screen - Enhanced
/// Shows real-time train updates with detailed information
/// Displays: Train Number, Train Name, Line, Train Type,
///           From/To Stations, Departure & Arrival Times
class LiveTrainUpdatesScreen extends StatefulWidget {
  const LiveTrainUpdatesScreen({super.key});

  @override
  State<LiveTrainUpdatesScreen> createState() => _LiveTrainUpdatesScreenState();
}

class _LiveTrainUpdatesScreenState extends State<LiveTrainUpdatesScreen> {
  int _selectedTabIndex = 0;
  late TextEditingController _searchController;

  bool _isLoading = true;
  String? _errorMessage;
  List<Train> _trains = [];
  List<Train> _filteredTrains = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadTrains();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTrains() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await fetchAllTrains();
    if (result['success'] == true && result['data'] is List<Train>) {
      setState(() {
        _trains = result['data'] as List<Train>;
        _filteredTrains = _trains;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage =
            result['message']?.toString() ?? 'Failed to load trains';
        _isLoading = false;
      });
    }
  }

  void _filterTrains(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTrains = _trains;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredTrains = _trains.where((train) {
          return train.trainNumber.toLowerCase().contains(lowerQuery) ||
              train.trainName.toLowerCase().contains(lowerQuery) ||
              train.departure.toLowerCase().contains(lowerQuery) ||
              train.destination.toLowerCase().contains(lowerQuery) ||
              train.line.toLowerCase().contains(lowerQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
        title: const Text('LIVE TRAIN UPDATES'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
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
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'ALL TRAINS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
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
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'SEARCH',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
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
          // Content Area
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildAllTrainsView()
                : _buildSearchView(),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTrainsView() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadTrains,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B6944),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_trains.isEmpty) {
      return const Center(
        child: Text(
          'No trains available',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return Container(
      color: const Color(0xFFF5F5F5),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        itemCount: _trains.length,
        itemBuilder: (context, index) {
          return _buildTrainDetailCard(_trains[index]);
        },
      ),
    );
  }

  Widget _buildSearchView() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      color: const Color(0xFFF5F5F5),
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _filterTrains,
              decoration: InputDecoration(
                hintText: 'Search by train no, name, or station...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _filterTrains('');
                        },
                        child: const Icon(Icons.clear, color: Colors.grey),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          // Results
          if (_filteredTrains.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  _searchController.text.isEmpty
                      ? 'Enter search terms'
                      : 'No trains match your search',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                itemCount: _filteredTrains.length,
                itemBuilder: (context, index) {
                  return _buildTrainDetailCard(_filteredTrains[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  /// Build detailed train information card
  Widget _buildTrainDetailCard(Train train) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with train number and name
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0D1B2A),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Train Number
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5252),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Train #${train.trainNumber}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        train.trainName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Line and Train Type
                Row(
                  children: [
                    Expanded(
                      child: _buildBadge(
                        icon: Icons.route,
                        label: train.line,
                        bgColor: const Color(0xFF4A90E2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildBadge(
                        icon: Icons.speed,
                        label: train.trainType,
                        bgColor: const Color(0xFF50C878),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Detail Fields
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailField(
                  label: 'FROM STATION',
                  value: train.departure,
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 12),
                _buildDetailField(
                  label: 'TO STATION',
                  value: train.destination,
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailField(
                        label: 'DEPARTURE TIME',
                        value: train.departureTime,
                        icon: Icons.schedule,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDetailField(
                        label: 'ARRIVAL TIME',
                        value: train.arrivalTime,
                        icon: Icons.schedule,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Action Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showTrainDetailsDialog(train);
                    },
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text('DETAILS'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B6944),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tracking train #${train.trainNumber}'),
                          backgroundColor: const Color(0xFF8B6944),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.location_searching, size: 18),
                    label: const Text('TRACK'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build detail field widget
  Widget _buildDetailField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF8B6944)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build badge widget
  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: bgColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: bgColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Show detailed train information in dialog
  void _showTrainDetailsDialog(Train train) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D1B2A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Train #${train.trainNumber}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDialogDetailRow('Train Name', train.trainName),
                      const SizedBox(height: 12),
                      _buildDialogDetailRow('Train Line', train.line),
                      const SizedBox(height: 12),
                      _buildDialogDetailRow('Train Type', train.trainType),
                      const SizedBox(height: 12),
                      _buildDialogDetailRow('From Station', train.departure),
                      const SizedBox(height: 12),
                      _buildDialogDetailRow('To Station', train.destination),
                      const SizedBox(height: 12),
                      _buildDialogDetailRow(
                        'Departure Time',
                        train.departureTime,
                      ),
                      const SizedBox(height: 12),
                      _buildDialogDetailRow('Arrival Time', train.arrivalTime),
                      const SizedBox(height: 20),
                      // Close button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B6944),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'CLOSE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build detail row for dialog
  Widget _buildDialogDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
