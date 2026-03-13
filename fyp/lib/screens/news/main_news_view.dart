import 'package:flutter/material.dart';

import '../../api/news.dart';

class MainNewsView extends StatefulWidget {
  const MainNewsView({super.key});

  @override
  State<MainNewsView> createState() => _MainNewsViewState();
}

class _MainNewsViewState extends State<MainNewsView> {
  bool _isLoading = true;
  String? _errorMessage;
  List<LocalNews> _items = [];

  @override
  void initState() {
    super.initState();
    _loadLocalNews();
  }

  Future<void> _loadLocalNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await fetchLocalNews();
    if (result['success'] == true && result['data'] is List<LocalNews>) {
      setState(() {
        _items = result['data'] as List<LocalNews>;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = result['message']?.toString() ?? 'Failed to load local news';
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
                onPressed: _loadLocalNews,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_items.isEmpty) {
      return const Center(
        child: Text(
          'No local news available.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        final createdAt = item.createdAt.isNotEmpty
            ? _formatDate(item.createdAt)
            : 'Unknown date';
        return Column(
          children: [
            _buildNewsCard(
              title: 'Local News',
              description: item.description,
              date: createdAt,
              icon: Icons.announcement,
            ),
            if (index != _items.length - 1) const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  String _formatDate(String raw) {
    try {
      final parsed = DateTime.parse(raw).toLocal();
      return '${parsed.day.toString().padLeft(2, '0')} ${_monthName(parsed.month)} ${parsed.year}';
    } catch (_) {
      return raw;
    }
  }

  String _monthName(int month) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[(month - 1).clamp(0, 11)];
  }

  Widget _buildNewsCard({
    required String title,
    required String description,
    required String date,
    required IconData icon,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.grey[600], size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        date,
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
