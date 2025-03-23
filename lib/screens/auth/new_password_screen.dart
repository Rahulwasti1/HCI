import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/navigation/app_router.dart';
import 'package:hci/widgets/custom_button.dart';
import 'package:hci/widgets/custom_text_field.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _passwordError;
  String? _confirmPasswordError;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _createNewPassword() {
    // Validate input
    setState(() {
      _passwordError =
          _passwordController.text.isEmpty ? 'Password is required' : null;
      _confirmPasswordError = _confirmPasswordController.text.isEmpty
          ? 'Please confirm your password'
          : _confirmPasswordController.text != _passwordController.text
              ? 'Passwords do not match'
              : null;
    });

    if (_passwordError != null || _confirmPasswordError != null) {
      return;
    }

    // Show success message and navigate to sign in
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password has been reset successfully!'),
        backgroundColor: AppColors.success,
      ),
    );

    // Navigate to sign in
    Navigator.of(context).pushReplacementNamed(AppRouter.signIn);
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'New Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your new password must be different from previously used passwords.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 40),
              // Password field
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                hint: 'Enter new password',
                isPassword: true,
                errorText: _passwordError,
              ),
              const SizedBox(height: 24),
              // Confirm Password field
              CustomTextField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                hint: 'Confirm new password',
                isPassword: true,
                errorText: _confirmPasswordError,
              ),
              const SizedBox(height: 40),
              // Create button
              CustomButton(
                text: 'Create New Password',
                onPressed: _createNewPassword,
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
