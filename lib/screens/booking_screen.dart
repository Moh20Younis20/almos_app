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
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('احجز موعد', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text('اختر حلاقك', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ),
                _buildBarberItem(0, 'أبو خالد', 'قص + تشكيل لحية', '4.9', '120'),
                _buildBarberItem(1, 'محمد علي', 'قص + صبغة', '4.7', '85'),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Text('اختر التاريخ', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: dates.length,
                    itemBuilder: (context, index) => _buildDateChip(index),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Text('المواعيد المتاحة', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: slots.length,
                    itemBuilder: (context, index) => _buildSlot(index),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/payment'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text('تأكيد الموعد — اذهب للدفع →'),
            ),
          ),
        ],
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
