import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/home/homescreen.dart';
import 'screens/others/othersscreen.dart';
import 'screens/news/newsscreen.dart';
import 'screens/profile/profilescreen.dart';
import 'screens/time/timescreen.dart';
import 'widgets/bottom_navigation.dart';
import 'config/theme/app_colors.dart';
import 'routes/app_routes.dart';

/// App Configuration - Main app widget setup
/// Follows Dependency Inversion Principle (DIP) and Open/Closed Principle (OCP)
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      // Named routes for navigation
      onGenerateRoute: _generateRoute,
      home: const SplashScreen(),
    );
  }

  /// Generate routes for named navigation
  static Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainLayout());

      case AppRoutes.others:
        return MaterialPageRoute(builder: (_) => const OthersScreen());

      case AppRoutes.news:
        return MaterialPageRoute(builder: (_) => const NewsScreen());

      case AppRoutes.time:
        return MaterialPageRoute(builder: (_) => const TimeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route ${settings.name} not found')),
          ),
        );
    }
  }
}

/// Main Layout - Bottom navigation with multiple screens
/// Follows Single Responsibility Principle (SRP)
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    TimeScreen(),
    NewsScreen(),
    OthersScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = const [
    'Home',
    'Time',
    'News',
    'Others',
    'Profile',
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.white,
        elevation: 0,
        actions: [
          // Info button
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: () => _showInfoDialog(),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline),
                    SizedBox(width: 8),
                    Text('Info'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('App Info'),
        content: const Text(
          'This is a demo app with UI only - no authentication required.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    // Just navigate back to home (no actual logout needed)
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }
}
