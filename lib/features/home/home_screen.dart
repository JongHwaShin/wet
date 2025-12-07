// Flutter의 Material 디자인 위젯들을 사용하기 위한 import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/address_selector.dart';
import 'widgets/category_list.dart';
import 'widgets/promo_slider.dart';
import 'widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedAddress = '서울시 강남구';
  List<dynamic> _restaurants = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchRestaurants(); // 초기 데이터 로드
  }

  void _updateAddress(String newAddress) {
    setState(() {
      _selectedAddress = newAddress;
    });
    // 주소가 바뀌면 자동으로 검색
    _searchRestaurants();
  }

  void _showAddressSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddressSelector(
        onAddressChanged: _updateAddress,
      ),
    );
  }

  Future<void> _searchRestaurants() async {
    setState(() {
      _isLoading = true;
      _restaurants = [];
    });

    try {
      final url = Uri.parse(
          'http://localhost:8080/api/restaurants/search?address=$_selectedAddress'); // Use logic for IP if needed
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _restaurants = data['documents'] ?? [];
        });
      } else {
         // Mock data for UI testing if server fails or returns empty
         // This is just for visualization during development if backend is not ready
      }
    } catch (e) {
      // Ignore errors for now or show snackbar
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8), // Light Grey Background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: GestureDetector(
          onTap: _showAddressSelector,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  '현재 주소',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 4),
                LimitedBox(
                  maxWidth: 200,
                  child: Text(
                    _selectedAddress,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Color(0xFFEA1D2C)),
              ],
            ),
          ),
        ),
        actions: [
            IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Search Bar
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFFEA1D2C)),
                    const SizedBox(width: 12),
                    Text(
                      '어떤 음식이 먹고 싶으세요?',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Categories
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CategoryList(),
            ),
          ),

          // 3. List Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '주변 맛집',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: _searchRestaurants, 
                    child: const Text('새로고침', style: TextStyle(color: Color(0xFFEA1D2C))),
                  )
                ],
              ),
            ),
          ),

          // 4. Restaurant List or Loading or Empty
          _isLoading
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(color: Color(0xFFEA1D2C))),
                )
              : _restaurants.isEmpty
                  ? SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        alignment: Alignment.center,
                        child: const Text('목록이 비어있습니다.\n상단 주소를 변경하거나 새로고침 해보세요.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return RestaurantCard(restaurant: _restaurants[index]);
                        },
                        childCount: _restaurants.length,
                      ),
                    ),

          // 5. Promo Banners (Moved to bottom)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: PromoSlider(),
            ),
          ),
          
          // Bottom Padding
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
