import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/navigation/app_router.dart';
import 'package:hci/widgets/custom_button.dart';
import 'package:hci/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    // For demo purposes, directly navigate to main screen
    // No validation or authentication for simplicity
    Navigator.of(context).pushReplacementNamed(AppRouter.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Sign In Text
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Welcome back text
              const Text(
                'Hi! Welcome back, you\'ve been missed',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Email field
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
              ),
              const SizedBox(height: 24),
              // Password field
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                hint: 'Enter your password',
                isPassword: true,
                errorText: _passwordError,
              ),
              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouter.forgotPassword);
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Sign In button
              CustomButton(
                text: 'Sign In',
                onPressed: _signIn,
                isLoading: _isLoading,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
              ),
              const Spacer(),
              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: AppColors.textLight,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRouter.signUp);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
