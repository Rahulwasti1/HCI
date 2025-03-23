import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/navigation/app_router.dart';
import 'package:hci/widgets/custom_button.dart';
import 'package:hci/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;
  bool _agreedToTerms = false;
  String? _termsError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    // Validate input
    setState(() {
      _nameError = _nameController.text.isEmpty ? 'Name is required' : null;
      _emailError = _emailController.text.isEmpty ? 'Email is required' : null;
      _passwordError =
          _passwordController.text.isEmpty ? 'Password is required' : null;
      _termsError =
          !_agreedToTerms ? 'You must agree to the terms and conditions' : null;
    });

    if (_nameError != null ||
        _emailError != null ||
        _passwordError != null ||
        _termsError != null) {
      return;
    }

    // For demo, directly navigate to main screen
    Navigator.of(context).pushReplacementNamed(AppRouter.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Fill your information below or register with your social account.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 40),
              // Name field
              CustomTextField(
                label: 'Name',
                controller: _nameController,
                hint: 'Enter your name',
                example: 'Ex. John Doe',
                errorText: _nameError,
              ),
              const SizedBox(height: 24),
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
              const SizedBox(height: 24),
              // Terms and conditions
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value ?? false;
                        if (_agreedToTerms) {
                          _termsError = null;
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RichText(
                            text: TextSpan(
                              text: 'Agree with ',
                              style: const TextStyle(
                                color: AppColors.text,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms & condition',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Show terms and conditions
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_termsError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _termsError!,
                              style: const TextStyle(
                                color: AppColors.error,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Sign Up button
              CustomButton(
                text: 'Sign Up',
                onPressed: _signUp,
                isLoading: _isLoading,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
              ),
              const Spacer(),
              // Already have an account
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: AppColors.textLight,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRouter.signIn);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
