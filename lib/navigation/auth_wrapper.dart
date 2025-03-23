import 'package:flutter/material.dart';
import 'package:hci/navigation/app_router.dart';
import 'package:hci/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkAuthStatus();
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (authProvider.isAuthenticated) {
      return Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        onPopPage: (route, result) => route.didPop(result),
        pages: [
          MaterialPage(
            child: Builder(
              builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacementNamed(AppRouter.main);
                });
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(AppRouter.signIn);
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
