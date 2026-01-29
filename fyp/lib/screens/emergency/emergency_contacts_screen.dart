import 'package:flutter/material.dart';

/// Emergency Contacts Screen
///
/// SOLID Principles Applied:
/// - Single Responsibility: Displays emergency contact information only
/// - Open/Closed: Extensible for additional emergency contacts without modifying existing code
/// - Liskov Substitution: Uses Material Design widgets consistently
/// - Interface Segregation: Clean separation of UI building concerns
/// - Dependency Inversion: Depends on Material Design abstractions
class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B2A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Emergency Contacts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildEmergencyContactsList(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Builds the header section with title and icon
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF8B6944).withOpacity(0.2),
            ),
            child: const Icon(
              Icons.phone_in_talk,
              color: Color(0xFF8B6944),
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'EMERGENCY CONTACTS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Important Numbers',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFB8A892), fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// Builds the list of emergency contacts
  Widget _buildEmergencyContactsList(BuildContext context) {
    final List<Map<String, String>> emergencyContacts = [
      {'name': 'Sri Lanka Railways Control Room', 'number': '1919'},
      {'name': 'Sri Lanka Railways Inquiry', 'number': '011 242 1281'},
      {'name': 'Colombo Fort Railway Station', 'number': '011 243 4215'},
      {'name': 'Maradana Railway Station', 'number': '011 268 1508'},
      {'name': 'Police Emergency', 'number': '119'},
      {'name': 'Tourist Police', 'number': '1912'},
      {'name': 'Ambulance (Suwa Seriya)', 'number': '1990'},
      {'name': 'Fire & Rescue Service', 'number': '110'},
      {'name': 'National Emergency Hotline', 'number': '118 / 119'},
      {'name': 'Disaster Management Centre', 'number': '117'},
      {'name': 'Sri Lanka Tourism Development Authority', 'number': '1912'},
      {'name': 'Emergency Information Service', 'number': '118'},
      {'name': 'Ministry of Transport', 'number': '011 218 7211'},
      {'name': 'Electricity Emergency (CEB)', 'number': '1987'},
      {'name': 'Water Supply Emergency', 'number': '1939'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C3E50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF8B6944).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...emergencyContacts.map(
            (contact) => _buildEmergencyContactItem(contact),
          ),
        ],
      ),
    );
  }

  /// Builds individual emergency contact item
  Widget _buildEmergencyContactItem(Map<String, String> contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 12),
            child: Text(
              '•',
              style: TextStyle(color: const Color(0xFF8B6944), fontSize: 20),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  contact['number'] ?? '',
                  style: const TextStyle(
                    color: Color(0xFF8B6944),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
