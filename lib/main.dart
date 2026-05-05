// Al-Moos Barber App - Initial Deployment Trigger
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/qr_scanner_screen.dart';
import 'screens/home_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/payment_screen.dart';

void main() {
  runApp(const AlMoosApp());
}

class AlMoosApp extends StatelessWidget {
  const AlMoosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الموس',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      locale: const Locale('ar', 'JO'),
      supportedLocales: const [
        Locale('ar', 'JO'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/qr': (context) => const QRScannerScreen(),
        '/home': (context) => const HomeScreen(),
        '/book': (context) => const BookingScreen(),
        '/payment': (context) => const PaymentScreen(),
      },
    );
  }
}
