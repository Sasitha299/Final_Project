import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
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
        ? 24.0
        : isTablet
        ? 48.0
        : 64.0;
    final topSpacing = isMobile ? 40.0 : 60.0;
    final logoSize = isMobile ? 80.0 : 100.0;
    final logoInnerSize = logoSize * 0.8;
    final logoIconSize = logoSize * 0.5;
    final titleFontSize = isMobile
        ? 32.0
        : isTablet
        ? 40.0
        : 48.0;
    final subtitleFontSize = isMobile ? 14.0 : 16.0;
    final labelFontSize = isMobile ? 11.0 : 12.0;
    final textFieldPadding = isMobile ? 12.0 : 16.0;
    final buttonFontSize = isMobile ? 16.0 : 18.0;
    final buttonPadding = isMobile ? 12.0 : 16.0;
    final spaceBetweenFields = isMobile ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
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
                              color: AppColors.white,
                              width: 3,
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
                                    color: AppColors.white,
                                    width: 2,
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
                        SizedBox(height: logoSize * 0.2),
                        Text(
                          'RailPulse',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: isMobile ? 24.0 : 28.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 50.0 : 80.0),
                  // Login Title
                  Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue.',
                    style: TextStyle(
                      color: AppColors.white70,
                      fontSize: subtitleFontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 30.0 : 40.0),
                  // Email Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EMAIL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: labelFontSize,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _emailController,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: isMobile ? 14.0 : 16.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: textFieldPadding,
                            ),
                            hintStyle: const TextStyle(
                              color: AppColors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spaceBetweenFields),
                  // Password Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PASSWORD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: labelFontSize,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: isMobile ? 14.0 : 16.0,
                          ),
                          decoration: InputDecoration(
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
                                color: AppColors.white70,
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
                    ],
                  ),
                  SizedBox(height: isMobile ? 30.0 : 40.0),
                  // Login Button
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: buttonPadding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: buttonFontSize,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 16.0 : 20.0),
                  // Signup Button
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.signup);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: buttonPadding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: buttonFontSize,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 12.0 : 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
