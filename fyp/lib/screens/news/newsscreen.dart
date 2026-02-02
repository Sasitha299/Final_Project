import 'package:flutter/material.dart';
import 'main_news_view.dart';
import 'live_train_alerts_view.dart';
import 'reserve_seats_view.dart';
import 'ticket_prices_view.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> categories = [
    'Main News',
    'Live Train Alerts',
    'Reserve Seats',
    'Ticket Prices',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Category Navigation
          Container(
            color: Colors.grey[200],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  categories.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _selectedCategoryIndex = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedCategoryIndex == index
                                ? const Color.fromARGB(255, 132, 88, 88)
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _selectedCategoryIndex == index
                              ? Colors.grey[700]
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Content Area
          Expanded(child: _buildCategoryContent()),
        ],
      ),
    );
  }

  Widget _buildCategoryContent() {
    switch (_selectedCategoryIndex) {
      case 0:
        return const MainNewsView();
      case 1:
        return const LiveTrainAlertsView();
      case 2:
        return const ReserveSeatsView();
      case 3:
        return const TicketPricesView();
      default:
        return const Center(child: Text('No content'));
    }
  }
}
