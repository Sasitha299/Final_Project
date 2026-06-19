import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Live Train Updates Screen - Enhanced
/// Pulls live detection data from:
///   https://iot-1-iota.vercel.app/api/detections
///
/// Displays: Train Number, Train Name, Line, Train Type, Direction,
///           Kollupitiya scheduled/actual + deviation,
///           Next Station + time, Day & Date, Notes.
class LiveTrainUpdatesScreen extends StatefulWidget {
  const LiveTrainUpdatesScreen({super.key});

  @override
  State<LiveTrainUpdatesScreen> createState() => _LiveTrainUpdatesScreenState();
}

/// ---------------------------------------------------------------------------
/// Model that maps the /api/detections response.
/// ---------------------------------------------------------------------------
class TrainDetection {
  final String id;
  final String date;
  final String day;
  final String trainNumber;
  final String? originalTrainNumber;
  final String trainName;
  final String direction;
  final String line;
  final String nextStation;
  final String trainType;
  final String scheduledKollupitiya;
  final String actualKollupitiya;
  final int minutesDeviationKollupitiya;
  final String nextStationTime;
  final String actualNextStationTime;
  final int minutesDeviationNextStation;
  final String notes;
  final String createdAt;

  TrainDetection({
    required this.id,
    required this.date,
    required this.day,
    required this.trainNumber,
    required this.originalTrainNumber,
    required this.trainName,
    required this.direction,
    required this.line,
    required this.nextStation,
    required this.trainType,
    required this.scheduledKollupitiya,
    required this.actualKollupitiya,
    required this.minutesDeviationKollupitiya,
    required this.nextStationTime,
    required this.actualNextStationTime,
    required this.minutesDeviationNextStation,
    required this.notes,
    required this.createdAt,
  });

  factory TrainDetection.fromJson(Map<String, dynamic> json) {
    String s(dynamic v) => (v ?? '').toString();
    int i(dynamic v) =>
        v is int ? v : int.tryParse((v ?? '0').toString()) ?? 0;

    return TrainDetection(
      id: s(json['_id']),
      date: s(json['date']),
      day: s(json['day']),
      trainNumber: s(json['trainNumber']),
      originalTrainNumber: json['originalTrainNumber']?.toString(),
      trainName: s(json['trainName']),
      direction: s(json['direction']),
      line: s(json['line']),
      nextStation: s(json['nextStation']),
      trainType: s(json['trainType']),
      scheduledKollupitiya: s(json['scheduledKollupitiya']),
      actualKollupitiya: s(json['actualKollupitiya']),
      minutesDeviationKollupitiya: i(json['minutesDeviationKollupitiya']),
      nextStationTime: s(json['nextStationTime']),
      actualNextStationTime: s(json['actualNextStationTime']),
      minutesDeviationNextStation: i(json['minutesDeviationNextStation']),
      notes: s(json['notes']),
      createdAt: s(json['createdAt']),
    );
  }
}

class _LiveTrainUpdatesScreenState extends State<LiveTrainUpdatesScreen> {
  static const String _apiUrl = 'https://iot-1-iota.vercel.app/api/detections';

  int _selectedTabIndex = 0;
  late TextEditingController _searchController;

  bool _isLoading = true;
  String? _errorMessage;
  List<TrainDetection> _detections = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadDetections();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDetections() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http
          .get(Uri.parse(_apiUrl))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map &&
            decoded['success'] == true &&
            decoded['data'] is List) {
          final list = (decoded['data'] as List)
              .whereType<Map<String, dynamic>>()
              .map(TrainDetection.fromJson)
              .toList();

          setState(() {
            _detections = list;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Unexpected response from server.';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Server error (${response.statusCode}).';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load live updates.\n$e';
        _isLoading = false;
      });
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------
  bool _isNA(String? v) {
    if (v == null) return true;
    final t = v.trim();
    return t.isEmpty || t.toUpperCase() == 'N/A';
  }

  String _orDash(String? v) => _isNA(v) ? '—' : v!.trim();

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso); // keep UTC clock to match actual times
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return iso;
    }
  }

  String _deviationText(int min) {
    if (min == 0) return 'On time';
    if (min > 0) return '$min min late';
    return '${min.abs()} min early';
  }

  Color _deviationColor(int min) {
    if (min == 0) return const Color(0xFF2E7D32); // green
    if (min > 0) return const Color(0xFFD32F2F); // red
    return const Color(0xFF1565C0); // blue (early)
  }

  Color _directionColor(String dir) {
    final d = dir.toUpperCase();
    if (d == 'UP') return const Color(0xFF2E7D32);
    if (d == 'DOWN') return const Color(0xFFD32F2F);
    return Colors.grey;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
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
                // Back button + refresh
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
                    const Spacer(),
                    GestureDetector(
                      onTap: _isLoading ? null : _loadDetections,
                      child: const Icon(
                        Icons.refresh,
                        color: Color(0xFF8B6944),
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // LIVE TRAIN UPDATES title
                Row(
                  children: [
                    const Text(
                      'LIVE TRAIN UPDATES',
                      style: TextStyle(
                        color: Color(0xFFD32F2F),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (!_isLoading && _errorMessage == null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B6944),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${_detections.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search, color: Colors.white, size: 18),
                              SizedBox(width: 4),
                              Text(
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
                ? _buildMyTrainsView()
                : _buildSearchView(),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
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
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadDetections,
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

  Widget _buildMyTrainsView() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return _buildErrorState();
    }
    if (_detections.isEmpty) {
      return const Center(
        child: Text(
          'No live updates available.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: _loadDetections,
        color: const Color(0xFF8B6944),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemCount: _detections.length,
          itemBuilder: (context, index) {
            return _buildDetectionCard(_detections[index]);
          },
        ),
      ),
    );
  }

  Widget _buildSearchView() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return _buildErrorState();
    }

    final query = _searchController.text.trim().toLowerCase();
    final List<TrainDetection> searchResults = query.isEmpty
        ? []
        : _detections.where((d) {
            final normalized =
                '${d.trainNumber} ${d.trainName} ${d.line} ${d.direction}'
                    .toLowerCase();
            return normalized.contains(query);
          }).toList();

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search train number, name, line...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          if (query.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'Enter train number, name or line to search',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            )
          else if (searchResults.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No trains match your search.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
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

  // ---------------------------------------------------------------------------
  // Cards
  // ---------------------------------------------------------------------------
  Widget _directionBadge(String direction) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _directionColor(direction),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _isNA(direction) ? '—' : direction.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _deviationBadge(int minutes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _deviationColor(minutes),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _deviationText(minutes),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetectionCard(TrainDetection d) {
    return GestureDetector(
      onTap: () => _showDetectionDetails(d),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE0F7FF),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Train number + name + direction
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Train No: ${d.trainNumber}',
                        style: const TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        d.trainName,
                        style: const TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _directionBadge(d.direction),
              ],
            ),
            const SizedBox(height: 10),
            // Line / Type
            Text(
              'Line: ${_orDash(d.line)} • Type: ${_orDash(d.trainType)}',
              style: const TextStyle(color: Color(0xFF424242), fontSize: 12),
            ),
            const SizedBox(height: 8),
            // Kollupitiya detection time + deviation
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Kollupitiya: ${_orDash(d.actualKollupitiya)}',
                    style: const TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _deviationBadge(d.minutesDeviationKollupitiya),
              ],
            ),
            // Next station (only if available)
            if (!_isNA(d.nextStation)) ...[
              const SizedBox(height: 6),
              Text(
                'Next: ${d.nextStation}'
                '${_isNA(d.nextStationTime) ? '' : ' at ${d.nextStationTime}'}',
                style: const TextStyle(
                  color: Color(0xFF424242),
                  fontSize: 12,
                ),
              ),
            ],
            const SizedBox(height: 6),
            // Day / Date
            Text(
              '${_orDash(d.day)} • ${_formatDate(d.date)}',
              style: const TextStyle(color: Color(0xFF616161), fontSize: 11),
            ),
            const SizedBox(height: 10),
            // Action button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF0B8B8),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text(
                  'VIEW DETAILS',
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
      ),
    );
  }

  Widget _buildSearchResultCard(TrainDetection d) {
    return GestureDetector(
      onTap: () => _showDetectionDetails(d),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFB8A892),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Train No: ${d.trainNumber}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        d.trainName,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _directionBadge(d.direction),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Line: ${_orDash(d.line)} • Type: ${_orDash(d.trainType)}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Kollupitiya: ${_orDash(d.actualKollupitiya)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _deviationBadge(d.minutesDeviationKollupitiya),
              ],
            ),
            if (!_isNA(d.nextStation)) ...[
              const SizedBox(height: 6),
              Text(
                'Next: ${d.nextStation}'
                '${_isNA(d.nextStationTime) ? '' : ' at ${d.nextStationTime}'}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
            const SizedBox(height: 6),
            Text(
              '${_orDash(d.day)} • ${_formatDate(d.date)}',
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF8B6944),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'VIEW DETAILS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Details dialog
  // ---------------------------------------------------------------------------
  Widget _detailTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _showDetectionDetails(TrainDetection d) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Train ${d.trainNumber} - ${d.trainName}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // General info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TRAIN INFO',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _detailTile('Line', _orDash(d.line)),
                      const SizedBox(height: 8),
                      _detailTile('Type', _orDash(d.trainType)),
                      const SizedBox(height: 8),
                      _detailTile('Direction', _orDash(d.direction)),
                      if (d.originalTrainNumber != null &&
                          !_isNA(d.originalTrainNumber)) ...[
                        const SizedBox(height: 8),
                        _detailTile(
                          'Original Train No',
                          d.originalTrainNumber!,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Kollupitiya section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'KOLLUPITIYA',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _detailTile(
                              'Scheduled',
                              _orDash(d.scheduledKollupitiya),
                            ),
                          ),
                          Expanded(
                            child: _detailTile(
                              'Actual',
                              _orDash(d.actualKollupitiya),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _deviationBadge(d.minutesDeviationKollupitiya),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Next station section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NEXT STATION',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _detailTile('Station', _orDash(d.nextStation)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _detailTile(
                              'Scheduled',
                              _orDash(d.nextStationTime),
                            ),
                          ),
                          Expanded(
                            child: _detailTile(
                              'Actual',
                              _orDash(d.actualNextStationTime),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _deviationBadge(d.minutesDeviationNextStation),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Detected on
                _detailTile('Detected On', '${_orDash(d.day)} • ${_formatDate(d.date)}'),
                // Notes
                if (!_isNA(d.notes)) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NOTES',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          d.notes,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }
}