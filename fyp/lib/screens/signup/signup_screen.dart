import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

/// Signup Screen - User registration page
/// Follows Single Responsibility Principle (SRP) - only handles signup UI
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    // Validate inputs
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    // Navigate to home after signup
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    // Responsive values
    final horizontalPadding = isMobile
        ? 24.0
        : isTablet
        ? 48.0
        : 64.0;
    final topSpacing = isMobile ? 30.0 : 40.0;
    final logoSize = isMobile ? 80.0 : 100.0;
    final logoInnerSize = logoSize * 0.8;
    final logoIconSize = logoSize * 0.5;
    final titleFontSize = isMobile
        ? 24.0
        : isTablet
        ? 28.0
        : 32.0;
    final labelFontSize = isMobile ? 11.0 : 12.0;
    final textFieldFontSize = isMobile ? 14.0 : 16.0;
    final textFieldPadding = isMobile ? 12.0 : 16.0;
    final buttonFontSize = isMobile ? 16.0 : 18.0;
    final buttonPadding = isMobile ? 12.0 : 16.0;
    final spaceBetweenFields = isMobile ? 16.0 : 20.0;
    final maxWidth = isTablet
        ? 600.0
        : isMobile
        ? double.infinity
        : 700.0;

    return Scaffold(
      backgroundColor: const Color(0xFF8B5A3C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
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
                              border: Border.all(color: Colors.white, width: 3),
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
                            'Create Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 30.0 : 40.0),
                    // Full Name Field
                    _buildTextField(
                      label: 'FULL NAME',
                      controller: _nameController,
                      hintText: 'Enter your full name',
                      labelFontSize: labelFontSize,
                      textFieldFontSize: textFieldFontSize,
                      textFieldPadding: textFieldPadding,
                    ),
                    SizedBox(height: spaceBetweenFields),
                    // Email Field
                    _buildTextField(
                      label: 'EMAIL',
                      controller: _emailController,
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      labelFontSize: labelFontSize,
                      textFieldFontSize: textFieldFontSize,
                      textFieldPadding: textFieldPadding,
                    ),
                    SizedBox(height: spaceBetweenFields),
                    // Password Field
                    _buildPasswordField(
                      label: 'PASSWORD',
                      controller: _passwordController,
                      isVisible: _isPasswordVisible,
                      onVisibilityToggle: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      hintText: 'Enter password',
                      labelFontSize: labelFontSize,
                      textFieldFontSize: textFieldFontSize,
                      textFieldPadding: textFieldPadding,
                    ),
                    SizedBox(height: spaceBetweenFields),
                    // Confirm Password Field
                    _buildPasswordField(
                      label: 'CONFIRM PASSWORD',
                      controller: _confirmPasswordController,
                      isVisible: _isConfirmPasswordVisible,
                      onVisibilityToggle: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                      hintText: 'Confirm password',
                      labelFontSize: labelFontSize,
                      textFieldFontSize: textFieldFontSize,
                      textFieldPadding: textFieldPadding,
                    ),
                    SizedBox(height: isMobile ? 30.0 : 40.0),
                    // Signup Button
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ElevatedButton(
                        onPressed: _handleSignup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            vertical: buttonPadding,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: buttonFontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 16.0 : 20.0),
                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isMobile ? 13.0 : 14.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 13.0 : 14.0,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 20.0 : 30.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    required double labelFontSize,
    required double textFieldFontSize,
    required double textFieldPadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            color: const Color(0xFFB89178),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(color: Colors.white, fontSize: textFieldFontSize),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: textFieldPadding,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white70),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
    required String hintText,
    required double labelFontSize,
    required double textFieldFontSize,
    required double textFieldPadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            color: const Color(0xFFB89178),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            controller: controller,
            obscureText: !isVisible,
            style: TextStyle(color: Colors.white, fontSize: textFieldFontSize),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: textFieldPadding,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white70),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: onVisibilityToggle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
