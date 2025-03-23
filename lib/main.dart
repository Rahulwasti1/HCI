import 'package:flutter/material.dart';
import 'package:hci/constants/theme.dart';
import 'package:hci/navigation/app_router.dart';
import 'package:hci/providers/auth_provider.dart';
import 'package:hci/providers/chat_provider.dart';
import 'package:hci/providers/energy_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EnergyProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'Energy Monitor',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.signIn,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
