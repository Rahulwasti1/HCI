import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/navigation/app_router.dart';
import 'package:hci/providers/auth_provider.dart';
import 'package:hci/providers/energy_provider.dart';
import 'package:hci/providers/chat_provider.dart';
import 'package:hci/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        title: 'WattBot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
