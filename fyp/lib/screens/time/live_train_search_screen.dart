import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/train.dart';

/// Live Train Search Screen
/// Shows search interface for finding live trains by departure/destination stations
class LiveTrainSearchScreen extends StatefulWidget {
  const LiveTrainSearchScreen({super.key});

  @override
  State<LiveTrainSearchScreen> createState() => _LiveTrainSearchScreenState();
}

class _LiveTrainSearchScreenState extends State<LiveTrainSearchScreen> {
  late TextEditingController _departureController;
  late TextEditingController _destinationController;
  late DateTime _selectedDate;

  bool _showResults = false;
  bool _isLoading = true;
  String? _errorMessage;
  List<Train> _allTrains = [];
  List<Train> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _departureController = TextEditingController();
    _destinationController = TextEditingController();
    _selectedDate = DateTime.now();
    _loadTrains();
  }

  Future<void> _loadTrains() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await fetchAllTrains();
    if (result['success'] == true && result['data'] is List<Train>) {
      setState(() {
        _allTrains = result['data'] as List<Train>;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = result['message']?.toString() ?? 'Failed to load trains';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final queryDeparture = _departureController.text.trim().toLowerCase();
    final queryDestination = _destinationController.text.trim().toLowerCase();

    setState(() {
      _showResults = true;
      _searchResults = _allTrains.where((train) {
        final dep = train.departure.toLowerCase();
        final dest = train.destination.toLowerCase();
        return dep.contains(queryDeparture) && dest.contains(queryDestination);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd / MM / yyyy - EEE')
        .format(_selectedDate)
        .toUpperCase();

    // Keep UI reactive; search results are updated on button press.
    // No side effects here.

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFF4A3728),
        child: Column(
          children: [
            // Top curved container with search form
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7A9DC4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(_showResults ? 0 : 40),
                  bottomRight: Radius.circular(_showResults ? 0 : 40),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date picker button
                  GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Departure Station
                  const Text(
                    'DEPARTURE STATION',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSearchField(
                    controller: _departureController,
                    hintText: 'Enter departure station',
                  ),
                  const SizedBox(height: 24),
                  // Destination Station
                  const Text(
                    'DESTINATION STATION',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSearchField(
                    controller: _destinationController,
                    hintText: 'Enter destination station',
                  ),
                  const SizedBox(height: 28),
                  // FIND Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_departureController.text.isEmpty ||
                            _destinationController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter both departure and destination stations',
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        _performSearch();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC499A3),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'FIND',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Search Results
            if (_isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_errorMessage != null)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _loadTrains,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (_showResults)
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: _searchResults.isEmpty
                      ? const Center(
                          child: Text(
                            'No matching trains found.',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return _buildTrainCard(_searchResults[index]);
                          },
                        ),
                ),
              )
            else
              const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
            size: 20,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
    );
  }

  Widget _buildTrainCard(Train train) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300] ?? Colors.grey,
          width: 1,
        ),
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
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Train No:',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    train.trainNumber,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Time
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.orange[700], size: 18),
              const SizedBox(width: 8),
              Text(
                train.departureTime,
                style: TextStyle(
                  color: Colors.orange[700],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Route
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.red[700], size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  train.route,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
