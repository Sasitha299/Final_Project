import 'package:flutter/material.dart';

import '../../api/train.dart';

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
  bool _isLoading = true;
  String? _errorMessage;
  List<Train> _trains = [];

  @override
  void initState() {
    super.initState();
    _loadLineSchedule();
  }

  Future<void> _loadLineSchedule() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await fetchTrainsByLine(widget.lineName);
    if (result['success'] == true && result['data'] is List<Train>) {
      setState(() {
        _trains = result['data'] as List<Train>;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage =
            result['message']?.toString() ?? 'Unable to load schedule';
        _isLoading = false;
      });
    }
  }

  bool _isUpRoute(Train train) {
    final dep = train.departure.toLowerCase();
    final dest = train.destination.toLowerCase();
    if (widget.lineName.toLowerCase().contains('coastal')) {
      return dep.contains('colombo') || dest.contains('matara');
    }
    return dep.contains('colombo');
  }

  List<Train> get _upTrains => _trains.where(_isUpRoute).toList();
  List<Train> get _downTrains =>
      _trains.where((train) => !_isUpRoute(train)).toList();

  @override
  Widget build(BuildContext context) {
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
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
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
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadLineSchedule,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B6944),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final currentTrains = _selectedRouteIndex == 0 ? _upTrains : _downTrains;

    if (currentTrains.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            _selectedRouteIndex == 0
                ? 'No up-route trains available for ${widget.lineName}.'
                : 'No down-route trains available for ${widget.lineName}.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: currentTrains.length,
      itemBuilder: (context, index) {
        return _buildTrainCard(currentTrains[index]);
      },
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

  void _showTrainDetails(Train train) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Train ${train.trainNumber}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Line: ${train.line}',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              if (train.trainType.isNotEmpty)
                _detailRow('Type', train.trainType),
              if (train.departure.isNotEmpty && train.destination.isNotEmpty)
                _detailRow('Route', '${train.departure} → ${train.destination}'),
              if (train.departureTime.isNotEmpty)
                _detailRow('Departure', train.departureTime),
              if (train.arrivalTime.isNotEmpty)
                _detailRow('Arrival', train.arrivalTime),
              if (train.currentStation != null && train.currentStation!.isNotEmpty)
                _detailRow('Current station',
                    '${train.currentStation} ${train.currentStationTime ?? ''}'.trim()),
              if (train.nextStation != null && train.nextStation!.isNotEmpty)
                _detailRow('Next station',
                    '${train.nextStation} ${train.nextStationTime ?? ''}'.trim()),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B6944),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainCard(Train train) {
    return GestureDetector(
      onTap: () => _showTrainDetails(train),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFE0F7FF),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.train, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Train No: ${train.trainNumber}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Line: ${train.line}',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
