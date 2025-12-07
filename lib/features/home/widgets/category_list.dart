import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'name': '전체', 'icon': Icons.grid_view_rounded, 'color': Color(0xFFEA1D2C)}, // Primary Red
    {'name': '한식', 'icon': Icons.rice_bowl, 'color': Color(0xFFFFA726)}, // Orange
    {'name': '분식', 'icon': Icons.ramen_dining, 'color': Color(0xFFEF5350)}, // Red
    {'name': '치킨', 'icon': Icons.dinner_dining, 'color': Color(0xFFFF7043)}, // Deep Orange
    {'name': '피자', 'icon': Icons.local_pizza, 'color': Color(0xFFFFCA28)}, // Amber
    {'name': '중식', 'icon': Icons.soup_kitchen, 'color': Color(0xFF8D6E63)}, // Brown
    {'name': '일식', 'icon': Icons.bento, 'color': Color(0xFF42A5F5)}, // Blue
    {'name': '카페', 'icon': Icons.coffee, 'color': Color(0xFF8D6E63)}, // Brown
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: (categories[index]['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  categories[index]['icon'] as IconData,
                  color: categories[index]['color'] as Color,
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                categories[index]['name'] as String,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
