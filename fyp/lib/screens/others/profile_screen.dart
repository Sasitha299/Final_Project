import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

/// Profile Screen - User profile management
/// Follows:
/// - Single Responsibility Principle (SRP): Handles only profile display
/// - Open/Closed Principle (OCP): Can be extended without modification
/// - Dependency Inversion Principle (DIP): Depends on abstractions
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data - In real app, this would come from a service/repository
  final Map<String, String> _userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+1 (555) 123-4567',
    'memberSince': 'January 2024',
    'accountType': 'Premium Member',
  };

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A2F42),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.close : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () => setState(() => _isEditing = !_isEditing),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/train_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A2F42).withOpacity(0.7),
                  Color(0xFF0D1B2A).withOpacity(0.8),
                  Color(0xFF000000).withOpacity(0.85),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: isMobile ? 20 : 30),
                // Profile Avatar
                _buildProfileAvatar(isMobile),
                SizedBox(height: 20),
                // User Name
                Text(
                  _userData['name'] ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8),
                // Account Type Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF8B6944),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _userData['accountType'] ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 30 : 40),
                // Profile Info Cards
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                  child: Column(
                    children: [
                      _buildInfoCard(
                        'Email',
                        _userData['email'] ?? '',
                        Icons.email_outlined,
                        isMobile,
                      ),
                      SizedBox(height: 16),
                      _buildInfoCard(
                        'Phone',
                        _userData['phone'] ?? '',
                        Icons.phone_outlined,
                        isMobile,
                      ),
                      SizedBox(height: 16),
                      _buildInfoCard(
                        'Member Since',
                        _userData['memberSince'] ?? '',
                        Icons.calendar_today_outlined,
                        isMobile,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 40 : 50),
                // Action Buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                  child: Column(
                    children: [
                      _buildActionButton(
                        'Update Profile',
                        Icons.person_add,
                        Color(0xFF8B6944),
                        () => _showEditDialog(context, isMobile),
                        isMobile,
                      ),
                      SizedBox(height: 12),
                      _buildActionButton(
                        'Change Password',
                        Icons.lock_outline,
                        Colors.orange.shade600,
                        () => _showPasswordChangeDialog(context, isMobile),
                        isMobile,
                      ),
                      SizedBox(height: 12),
                      _buildActionButton(
                        'Logout',
                        Icons.logout,
                        Colors.red.shade600,
                        () => _handleLogout(context),
                        isMobile,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 30 : 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(bool isMobile) {
    return Container(
      width: isMobile ? 100 : 120,
      height: isMobile ? 100 : 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFF8B6944), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Color(0xFF8B6944),
        child: Icon(
          Icons.person,
          size: isMobile ? 50 : 60,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String label,
    String value,
    IconData icon,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF8B6944).withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
    bool isMobile,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, bool isMobile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A2F42),
        title: Text(
          'Update Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Full Name', _userData['name'] ?? ''),
            SizedBox(height: 12),
            _buildTextField('Email', _userData['email'] ?? ''),
            SizedBox(height: 12),
            _buildTextField('Phone', _userData['phone'] ?? ''),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Save', style: TextStyle(color: Color(0xFF8B6944))),
          ),
        ],
      ),
    );
  }

  void _showPasswordChangeDialog(BuildContext context, bool isMobile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A2F42),
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Current Password', ''),
            SizedBox(height: 12),
            _buildTextField('New Password', ''),
            SizedBox(height: 12),
            _buildTextField('Confirm Password', ''),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password changed successfully!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Update', style: TextStyle(color: Color(0xFF8B6944))),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF8B6944)),
        ),
      ),
      style: TextStyle(color: Colors.white),
      controller: TextEditingController(text: initialValue),
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A2F42),
        title: Text(
          'Logout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
