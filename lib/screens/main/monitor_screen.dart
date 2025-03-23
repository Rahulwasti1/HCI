import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';

class MonitorScreen extends StatelessWidget {
  const MonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Energy Monitor',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bolt,
              size: 80,
              color: AppColors.primary.withOpacity(0.7),
            ),
            const SizedBox(height: 24),
            const Text(
              'Energy Monitoring',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Monitor your energy usage in real-time and get insights to optimize consumption.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
