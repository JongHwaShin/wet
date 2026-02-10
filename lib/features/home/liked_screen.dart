import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widgets/restaurant_card.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  List<dynamic> _likedRestaurants = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLikedRestaurants();
  }

  Future<void> _fetchLikedRestaurants() async {
    // Assuming hardcoded user ID 1
    final url = Uri.parse('http://localhost:8080/api/restaurants/likes?userId=1');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _likedRestaurants = data;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load likes');
      }
    } catch (e) {
      print('Error fetching likes: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('찜한 맛집', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _likedRestaurants.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _fetchLikedRestaurants,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: _likedRestaurants.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return RestaurantCard(
                        restaurant: _likedRestaurants[index],
                        isLiked: true, // Always true in this screen
                        onLikeChanged: (isLiked) {
                          // If unliked, refresh the list
                          _fetchLikedRestaurants();
                        },
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            '아직 찜한 맛집이 없어요.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            '마음에 드는 맛집을 찜해보세요!',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
