import 'package:flutter/material.dart';
import 'screens/home/homescreen.dart';
import 'screens/others/othersscreen.dart';
import 'screens/news/newsscreen.dart';
import 'screens/profile/profilescreen.dart';
import 'screens/time/timescreen.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    OthersScreen(),
    NewsScreen(),
    TimeScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = const [
    'Home',
    'Others',
    'News',
    'Time',
    'Profile',
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
