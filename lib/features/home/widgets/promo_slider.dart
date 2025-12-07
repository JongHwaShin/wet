import 'package:flutter/material.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView(
        controller: PageController(viewportFraction: 0.9),
        padEnds: false, // Start from the left if using viewportFraction < 1, but we want padding
        children: [
          _buildBanner(
            color: const Color(0xFFEA1D2C),
            title: '첫 주문 할인',
            subtitle: '5,000원 쿠폰 받기',
            icon: Icons.card_giftcard,
          ),
          _buildBanner(
            color: const Color(0xFF42A5F5),
            title: '무료 배달',
            subtitle: '친구 초대하고 무료배달',
            icon: Icons.delivery_dining,
          ),
          _buildBanner(
            color: const Color(0xFF66BB6A), // Green
            title: '신선한 샐러드',
            subtitle: '다이어트 시작하세요!',
            icon: Icons.eco,
          ),
        ],
      ),
    );
  }

  Widget _buildBanner({
    required Color color,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 4), // Margin between items
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              icon,
              size: 100,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '자세히 보기 >',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
