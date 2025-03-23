import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/providers/auth_provider.dart';
import 'package:hci/navigation/app_router.dart';
import 'package:hci/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile image
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primaryLight,
                backgroundImage: authProvider.user?.profileImage != null
                    ? NetworkImage(authProvider.user!.profileImage!)
                    : null,
                child: authProvider.user?.profileImage == null
                    ? const Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.primary,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // User name
            Text(
              authProvider.user?.name ?? 'Rahul Wasti',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            // User email
            Text(
              authProvider.user?.email ?? 'rahulwasti@gmail.com',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 40),
            // Profile options
            _buildProfileOption(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                // Navigate to edit profile
              },
            ),
            _buildProfileOption(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {
                // Navigate to notifications
              },
            ),
            _buildProfileOption(
              icon: Icons.security_outlined,
              title: 'Security',
              onTap: () {
                // Navigate to security
              },
            ),
            _buildProfileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                // Navigate to help
              },
            ),
            _buildProfileOption(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                // Navigate to about
              },
            ),
            const SizedBox(height: 40),
            // Sign out button
            CustomButton(
              text: 'Sign Out',
              onPressed: () async {
                final success = await authProvider.signOut();
                if (success && context.mounted) {
                  Navigator.of(context).pushReplacementNamed(AppRouter.signIn);
                }
              },
              isOutlined: true,
              textColor: AppColors.error,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
      onTap: onTap,
    );
  }
}
