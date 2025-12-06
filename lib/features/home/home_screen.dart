// Flutter의 Material 디자인 위젯들을 사용하기 위한 import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/address_selector.dart';

// HomeScreen: 앱의 홈 화면
// StatefulWidget: 주소 선택 및 검색 결과에 따라 상태가 변함
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 선택된 주소
  String _selectedAddress = '서울시 강남구 역삼동';
  // 검색된 식당 목록
  List<dynamic> _restaurants = [];
  // 로딩 상태
  bool _isLoading = false;

  // 백엔드 API 호출하여 식당 검색
  Future<void> _searchRestaurants() async {
    setState(() {
      _isLoading = true;
      _restaurants = [];
    });

    try {
      // 백엔드 API URL
      // Android 에뮬레이터: 10.0.2.2
      // iOS 시뮬레이터: localhost
      // 실제 기기: 컴퓨터의 IP 주소
      final url = Uri.parse(
          'http://localhost:8080/api/restaurants/search?address=$_selectedAddress');
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _restaurants = data['documents'] ?? [];
        });
      } else {
        // 에러 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load restaurants: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // 네트워크 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: 기본 화면 구조 (앱바 + 바디)
    return Scaffold(
      // appBar: 상단 앱 바
      appBar: AppBar(
        title: const Text('TWE'), // 앱 이름 표시
        actions: [
          // actions: 앱바 우측에 표시되는 버튼들
          IconButton(
            icon: const Icon(Icons.notifications_outlined), // 알림 아이콘
            onPressed: () {}, // 클릭 시 실행할 함수 (현재는 비어있음)
          ),
        ],
      ),
      // body: 화면의 메인 콘텐츠
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 인사말 텍스트
                Text(
                  'Hello, Hungry User! 👋',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold, // 굵은 글씨
                      ),
                ),
                const SizedBox(height: 8), // 8픽셀 간격
                // 부제목 텍스트
                Text(
                  'Find restaurants near you',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600], // 회색 텍스트
                      ),
                ),
                const SizedBox(height: 24), // 24픽셀 간격
                
                // 주소 선택 위젯
                AddressSelector(
                  onAddressChanged: (address) {
                    setState(() {
                      _selectedAddress = address;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // 검색 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _searchRestaurants,
                    icon: const Icon(Icons.search),
                    label: const Text('주변 식당 찾기'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 검색 결과 리스트
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _restaurants.isEmpty
                    ? const Center(child: Text('검색 버튼을 눌러 주변 식당을 찾아보세요!'))
                    : ListView.builder(
                        itemCount: _restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = _restaurants[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.restaurant),
                            ),
                            title: Text(restaurant['place_name'] ?? 'Unknown'),
                            subtitle: Text(restaurant['road_address_name'] ?? ''),
                            trailing: Text(
                                restaurant['category_name']?.split('>').last.trim() ??
                                    ''),
                            onTap: () {
                              // 상세 화면으로 이동하거나 지도 열기 등의 동작 구현 가능
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
