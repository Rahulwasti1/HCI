import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/navigation/app_router.dart';
import 'package:hci/widgets/custom_button.dart';
import 'package:hci/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    // Validate input
    setState(() {
      _emailError = _emailController.text.isEmpty ? 'Email is required' : null;
    });

    if (_emailError != null) {
      return;
    }

    // For demo, directly navigate to new password screen
    Navigator.of(context).pushNamed(AppRouter.newPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter your email address to receive a verification code.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Send Reset Link',
                onPressed: _resetPassword,
                isLoading: _isLoading,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
