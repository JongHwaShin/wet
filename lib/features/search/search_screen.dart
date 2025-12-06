// Flutter의 Material 디자인 위젯들을 사용하기 위한 import
import 'package:flutter/material.dart';
// 레스토랑 상세 화면을 import
import '../details/restaurant_detail_screen.dart';

// SearchScreen: 레스토랑 검색 화면
// StatefulWidget: 검색어와 필터링된 결과가 변하므로 상태가 필요함
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

// _SearchScreenState: SearchScreen의 상태를 관리하는 클래스
class _SearchScreenState extends State<SearchScreen> {
  // _searchController: 검색창의 텍스트를 관리하는 컨트롤러
  final TextEditingController _searchController = TextEditingController();
  
  // _allRestaurants: 전체 레스토랑 목록 (실제 앱에서는 서버에서 가져옴)
  final List<Map<String, dynamic>> _allRestaurants = [
    {
      'name': 'Spicy Ramen House', // 레스토랑 이름
      'category': 'Japanese', // 카테고리
      'rating': 4.5, // 평점
      'image': '🍜', // 이모지 아이콘
    },
    {
      'name': 'Burger King',
      'category': 'Fast Food',
      'rating': 4.2,
      'image': '🍔',
    },
    {
      'name': 'Pizza Hut',
      'category': 'Italian',
      'rating': 4.0,
      'image': '🍕',
    },
    {
      'name': 'Sushi Master',
      'category': 'Japanese',
      'rating': 4.8,
      'image': '🍣',
    },
    {
      'name': 'Green Salad',
      'category': 'Healthy',
      'rating': 4.6,
      'image': '🥗',
    },
  ];

  // _filteredRestaurants: 검색어로 필터링된 레스토랑 목록
  List<Map<String, dynamic>> _filteredRestaurants = [];

  // initState: 위젯이 처음 생성될 때 한 번만 실행되는 함수
  @override
  void initState() {
    super.initState();
    // 처음에는 모든 레스토랑을 표시
    _filteredRestaurants = _allRestaurants;
  }

  // _filterSearchResults: 검색어에 따라 레스토랑 목록을 필터링하는 함수
  void _filterSearchResults(String query) {
    setState(() {
      // where: 조건에 맞는 항목만 필터링
      _filteredRestaurants = _allRestaurants
          .where((item) =>
              // 레스토랑 이름이나 카테고리에 검색어가 포함되어 있는지 확인
              // toLowerCase(): 대소문자 구분 없이 검색
              item['name'].toLowerCase().contains(query.toLowerCase()) ||
              item['category'].toLowerCase().contains(query.toLowerCase()))
          .toList(); // 결과를 리스트로 변환
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'), // 앱바 제목
      ),
      body: Column(
        children: [
          // 검색창 영역
          Padding(
            padding: const EdgeInsets.all(16.0), // 여백 16픽셀
            child: TextField(
              controller: _searchController, // 텍스트 컨트롤러 연결
              onChanged: _filterSearchResults, // 텍스트가 변경될 때마다 필터링 함수 실행
              decoration: InputDecoration(
                labelText: 'Search restaurants...', // 힌트 텍스트
                prefixIcon: const Icon(Icons.search), // 왼쪽에 검색 아이콘
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // 둥근 테두리
                ),
                filled: true, // 배경색 채우기
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest, // 배경색
              ),
            ),
          ),
          // Expanded: 남은 공간을 모두 차지
          Expanded(
            // ListView.builder: 리스트를 효율적으로 표시 (스크롤 가능)
            child: ListView.builder(
              itemCount: _filteredRestaurants.length, // 표시할 항목 개수
              itemBuilder: (context, index) {
                // 각 인덱스에 해당하는 레스토랑 정보
                final restaurant = _filteredRestaurants[index];
                // ListTile: 리스트 항목을 표시하는 위젯
                return ListTile(
                  // leading: 왼쪽에 표시되는 위젯
                  leading: Text(
                    restaurant['image'], // 이모지 아이콘
                    style: const TextStyle(fontSize: 32),
                  ),
                  title: Text(restaurant['name']), // 레스토랑 이름
                  subtitle: Text(restaurant['category']), // 카테고리
                  // trailing: 오른쪽에 표시되는 위젯
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min, // 필요한 만큼만 공간 차지
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16), // 별 아이콘
                      Text(restaurant['rating'].toString()), // 평점
                    ],
                  ),
                  // onTap: 항목을 클릭했을 때 실행되는 함수
                  onTap: () {
                    // Navigator.push: 새로운 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // RestaurantDetailScreen으로 이동하면서 레스토랑 정보 전달
                        builder: (context) =>
                            RestaurantDetailScreen(restaurant: restaurant),
                      ),
                    );
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
