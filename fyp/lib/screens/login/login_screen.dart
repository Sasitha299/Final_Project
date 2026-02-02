import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(
    text: 'hello@reallygreatsite.com',
  );
  final _passwordController = TextEditingController(text: '******');
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    // Responsive values
    final horizontalPadding = isMobile
        ? 32.0
        : isTablet
        ? 48.0
        : 64.0;
    final topSpacing = isMobile ? 60.0 : 80.0;
    final logoSize = isMobile ? 70.0 : 90.0;
    final logoInnerSize = logoSize * 0.75;
    final logoIconSize = logoSize * 0.45;
    final titleFontSize = isMobile
        ? 36.0
        : isTablet
        ? 44.0
        : 52.0;
    final subtitleFontSize = isMobile ? 14.0 : 16.0;
    final labelFontSize = isMobile ? 13.0 : 14.0;
    final textFieldPadding = isMobile ? 14.0 : 18.0;
    final buttonFontSize = isMobile ? 16.0 : 18.0;
    final buttonPadding = isMobile ? 14.0 : 18.0;
    final spaceBetweenFields = isMobile ? 20.0 : 24.0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/train_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Gradient overlay for better text readability
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.25),
                Colors.black.withOpacity(0.35),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      screenHeight -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: topSpacing),
                      // Logo
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: logoSize,
                              height: logoSize,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.5,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: logoInnerSize,
                                    height: logoInnerSize,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Icon(
                                    Icons.train,
                                    color: Colors.white,
                                    size: logoIconSize,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'RailPulse',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 20.0 : 24.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      // Welcome text
                      Text(
                        'welcome to Railpulse',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: isMobile ? 13.0 : 15.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 60.0 : 80.0),
                      // Login Title
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'sign in to continue.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 40.0 : 50.0),
                      // Email Field
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF8B6944).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color(0xFF8B6944).withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _emailController,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 14.0 : 16.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: isMobile ? 14.0 : 16.0,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: textFieldPadding,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: spaceBetweenFields),
                      // Password Field
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF8B6944).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color(0xFF8B6944).withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 14.0 : 16.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: isMobile ? 14.0 : 16.0,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: textFieldPadding,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white.withOpacity(0.7),
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 32.0 : 40.0),
                      // Login Button
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF8B6944),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color(0xFF8B6944),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.home,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                              vertical: buttonPadding,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 20.0 : 24.0),
                      // Forgot Password
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 13.0 : 14.0,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 8.0 : 12.0),
                      // Sign Up
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 13.0 : 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.signup);
                              },
                              child: Text(
                                '>>',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 13.0 : 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isMobile ? 20.0 : 30.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
