import 'package:flutter/material.dart';

import '../../api/news.dart';

class LiveTrainAlertsView extends StatefulWidget {
  const LiveTrainAlertsView({super.key});

  @override
  State<LiveTrainAlertsView> createState() => _LiveTrainAlertsViewState();
}

class _LiveTrainAlertsViewState extends State<LiveTrainAlertsView> {
  bool _isLoading = true;
  String? _errorMessage;
  List<TrainAlert> _alerts = [];

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  Future<void> _loadAlerts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await fetchTrainAlerts();
    if (result['success'] == true && result['data'] is List<TrainAlert>) {
      setState(() {
        _alerts = result['data'] as List<TrainAlert>;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage =
            result['message']?.toString() ?? 'Failed to load alerts';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loadAlerts,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_alerts.isEmpty) {
      return const Center(
        child: Text(
          'No train alerts at the moment.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _alerts.length,
      itemBuilder: (context, index) {
        final alert = _alerts[index];
        return Column(
          children: [
            _buildAlertCard(
              trainNumber: alert.trainNumber,
              departure: alert.departure,
              destination: alert.destination,
              realTime: alert.time,
              routeDirection: _getRouteDirection(alert),
              description: alert.news,
              severity: _getSeverityLabel(alert.news),
              severityColor: _getSeverityColor(alert.news),
            ),
            if (index != _alerts.length - 1) const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  String _getRouteDirection(TrainAlert alert) {
    final dep = alert.departure.toLowerCase();
    final dest = alert.destination.toLowerCase();
    if (dep.contains('colombo') || dest.contains('matara')) {
      return 'Up';
    }
    if (dest.contains('colombo') || dep.contains('matara')) {
      return 'Down';
    }
    return 'Up / Down';
  }

  String _getSeverityLabel(String news) {
    final lower = news.toLowerCase();
    if (lower.contains('delay') || lower.contains('delayed')) {
      return 'High';
    }
    if (lower.contains('minor') || lower.contains('update')) {
      return 'Medium';
    }
    return 'Info';
  }

  Color _getSeverityColor(String news) {
    final label = _getSeverityLabel(news);
    switch (label) {
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.amber;
      default:
        return Colors.green;
    }
  }

  Widget _buildAlertCard({
    required String trainNumber,
    required String departure,
    required String destination,
    required String realTime,
    required String routeDirection,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Real Time: $realTime',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Train No: $trainNumber',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
            const SizedBox(height: 12),
            Text(
              'Destination: $destination',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'Route: $routeDirection',
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              'From $departure to $destination',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(fontSize: 11, color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
            Text(
              'Alert Time: $realTime',
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
