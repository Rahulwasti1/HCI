import 'package:flutter/material.dart';
import 'package:hci/screens/auth/forgot_password_screen.dart';
import 'package:hci/screens/auth/new_password_screen.dart';
import 'package:hci/screens/auth/sign_in_screen.dart';
import 'package:hci/screens/auth/sign_up_screen.dart';
import 'package:hci/screens/main/main_screen.dart';
import 'package:hci/screens/profile/complete_profile_screen.dart';

class AppRouter {
  // Route names
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String newPassword = '/new-password';
  static const String completeProfile = '/complete-profile';
  static const String main = '/main';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case completeProfile:
        return MaterialPageRoute(builder: (_) => const CompleteProfileScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        // If the route is not found, return the sign in screen
        return MaterialPageRoute(builder: (_) => const SignInScreen());
    }
  }
}
