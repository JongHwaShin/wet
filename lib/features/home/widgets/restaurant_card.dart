import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../details/restaurant_detail_screen.dart';

class RestaurantCard extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final bool isLiked;
  final Function(bool)? onLikeChanged;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.isLiked = false,
    this.onLikeChanged,
  });

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.restaurant['isLiked'] ?? widget.isLiked;
  }

  @override
  void didUpdateWidget(covariant RestaurantCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLiked != widget.isLiked) {
      _isLiked = widget.isLiked;
    }
    // Also check if restaurant data updated (e.g. from search result)
    if (widget.restaurant['isLiked'] != null && 
        widget.restaurant['isLiked'] != _isLiked) {
       _isLiked = widget.restaurant['isLiked'];
    }
  }

  Future<void> _toggleLike() async {
    final newState = !_isLiked;
    setState(() {
      _isLiked = newState;
    });

    try {
      final url = Uri.parse('http://localhost:8080/api/restaurants/like');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': 1, // Hardcoded user ID
          'restaurant': widget.restaurant,
        }),
      );

      if (response.statusCode == 200) {
        if (widget.onLikeChanged != null) {
          widget.onLikeChanged!(newState);
        }
      } else {
        // Revert on failure
        setState(() {
          _isLiked = !newState;
        });
        print('Failed to toggle like: ${response.statusCode}');
      }
    } catch (e) {
      // Revert on error
      setState(() {
        _isLiked = !newState;
      });
      print('Error toggling like: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailScreen(restaurant: widget.restaurant),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image logic: placeholder or color
            Container(
              height: 140,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Placeholder gradient instead of image
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: const Center(
                      child: Icon(Icons.store, size: 40, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: _toggleLike,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: _isLiked ? const Color(0xFFEA1D2C) : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurant['name'] ?? '가게 이름 없음',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.restaurant['category']?.split('>').last.trim() ?? '카테고리 없음',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
