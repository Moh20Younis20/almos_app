import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'امسح رمز QR',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'امسح رمز حلاقك للانضمام',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 40),
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 3),
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 180,
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.primary,
                            Colors.transparent
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Decorative corners
                  Positioned(
                    top: -3,
                    right: -3,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppColors.primary, width: 3),
                          right: BorderSide(color: AppColors.primary, width: 3),
                        ),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -3,
                    left: -3,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.primary, width: 3),
                          left: BorderSide(color: AppColors.primary, width: 3),
                        ),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'أو',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              child: const Text('تجربة التطبيق'),
            ),
          ],
        ),
      ),
    );
  }
}
