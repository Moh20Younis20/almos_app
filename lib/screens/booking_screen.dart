import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedBarber = 0;
  int selectedDate = 0;
  int selectedSlot = 2;

  final List<String> dates = ['8', '9', '10', '11', '12'];
  final List<String> days = ['أحد', 'إثن', 'ثلاث', 'أرب', 'خمس'];
  final List<String> slots = [
    '9:00 ص',
    '10:00 ص',
    '10:30 ص',
    '11:00 ص',
    '12:00 م',
    '2:00 م',
    '3:00 م',
    '4:30 م',
    '5:00 م'
  ];
  final List<bool> availability = [
    false,
    true,
    true,
    false,
    true,
    true,
    true,
    true,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), AppColors.background],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: const Color(0xFF1A1A2E),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primary, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('حجز موعد جديد', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              centerTitle: true,
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text('1. اختر حلاقك المفضل', style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildBarberSelectCard(0, 'أبو خالد', '👨🏻‍💼', 'خبير قصات كلاسيكية'),
                        _buildBarberSelectCard(1, 'محمد علي', '🧔🏻', 'خبير تشكيل لحية'),
                        _buildBarberSelectCard(2, 'ياسين', '👨🏽‍🎨', 'خبير صبغة وتسريح'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
                    child: Text('2. اختر التاريخ المناسب', style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: dates.length,
                      itemBuilder: (context, index) => _buildDateChip(index),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
                    child: Text('3. اختر الوقت المتاح', style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: slots.length,
                      itemBuilder: (context, index) => _buildSlot(index),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('السعر التقريبي', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    Text('8.00 د.أ', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/payment'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text('تأكيد الحجز', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarberSelectCard(int index, String name, String emoji, String sub) {
    bool isSelected = selectedBarber == index;
    return GestureDetector(
      onTap: () => setState(() => selectedBarber = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.05), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            Text(sub, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildBarberItem(int index, String name, String spec, String rate, String bookings) {
    bool isSelected = selectedBarber == index;
    return GestureDetector(
      onTap: () => setState(() => selectedBarber = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Text('👨', style: TextStyle(fontSize: 24))),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(spec, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  Text('⭐ $rate · $bookings حجز', style: const TextStyle(color: AppColors.primary, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateChip(int index) {
    bool isSelected = selectedDate == index;
    return GestureDetector(
      onTap: () => setState(() => selectedDate = index),
      child: Container(
        width: 60,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(dates[index], style: TextStyle(color: isSelected ? AppColors.primary : Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(days[index], style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildSlot(int index) {
    bool isAvailable = availability[index];
    bool isSelected = selectedSlot == index;
    return Opacity(
      opacity: isAvailable ? 1.0 : 0.3,
      child: GestureDetector(
        onTap: isAvailable ? () => setState(() => selectedSlot = index) : null,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.15) : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : (isAvailable ? AppColors.primary.withOpacity(0.2) : Colors.transparent),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              slots[index],
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
extension on Widget {
  Widget withOpacity(double opacity) => Opacity(opacity: opacity, child: this);
}
// Correction for BoxDecoration opacity which doesn't exist, using Opacity widget instead
// Updated the BoxDecoration call in Slot UI above
