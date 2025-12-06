// Flutter의 Material 디자인 위젯들을 사용하기 위한 import
import 'package:flutter/material.dart';

// RestaurantDetailScreen: 레스토랑 상세 정보를 보여주는 화면
// StatelessWidget: 전달받은 레스토랑 정보를 표시만 하므로 상태 변경이 없음
class RestaurantDetailScreen extends StatelessWidget {
  // restaurant: 이전 화면에서 전달받은 레스토랑 정보
  final Map<String, dynamic> restaurant;

  // required: 필수 매개변수 (레스토랑 정보 없이는 화면을 만들 수 없음)
  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CustomScrollView: 복잡한 스크롤 효과를 만들 수 있는 위젯
      body: CustomScrollView(
        // slivers: 스크롤 가능한 영역들의 리스트
        slivers: [
          // SliverAppBar: 스크롤 시 크기가 변하는 앱바
          SliverAppBar(
            expandedHeight: 250.0, // 확장되었을 때 높이
            floating: false, // 스크롤 내릴 때 앱바가 바로 나타나지 않음
            pinned: true, // 스크롤해도 앱바가 상단에 고정됨
            // FlexibleSpaceBar: 확장/축소되는 영역
            flexibleSpace: FlexibleSpaceBar(
              title: Text(restaurant['name']), // 레스토랑 이름
              // background: 확장되었을 때 배경에 표시될 위젯
              background: Container(
                color: Theme.of(context).colorScheme.primaryContainer, // 배경색
                child: Center(
                  // 레스토랑 이모지를 크게 표시
                  child: Text(
                    restaurant['image'],
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter: 일반 위젯을 Sliver로 변환
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // 전체 여백
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                children: [
                  // 카테고리와 평점을 가로로 배치
                  Row(
                    children: [
                      // Chip: 작은 라벨 위젯
                      Chip(
                        label: Text(restaurant['category']), // 카테고리 이름
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      ),
                      const SizedBox(width: 8), // 8픽셀 간격
                      const Icon(Icons.star, color: Colors.amber), // 별 아이콘
                      const SizedBox(width: 4),
                      // 평점 표시
                      Text(
                        restaurant['rating'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // "Description" 제목
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  // 레스토랑 설명 (동적으로 카테고리 이름 포함)
                  Text(
                    'This is a delicious place serving the best ${restaurant['category']} in town. Come and enjoy a wonderful meal with your friends and family!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  // "Menu Highlights" 제목
                  Text(
                    'Menu Highlights',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  // 메뉴 항목들 (이름과 가격)
                  _buildMenuItem(context, 'Signature Dish', '\$12.99'),
                  _buildMenuItem(context, 'Special Drink', '\$4.50'),
                  _buildMenuItem(context, 'Dessert', '\$6.00'),
                  const SizedBox(height: 32),
                  // "Get Directions" 버튼 (화면 전체 너비)
                  SizedBox(
                    width: double.infinity, // 전체 너비
                    child: FilledButton.icon(
                      onPressed: () {}, // 버튼 클릭 시 실행할 함수
                      icon: const Icon(Icons.map), // 지도 아이콘
                      label: const Text('Get Directions'), // 버튼 텍스트
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _buildMenuItem: 메뉴 항목을 표시하는 위젯 (이름과 가격)
  Widget _buildMenuItem(BuildContext context, String name, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // 위아래 여백 4픽셀
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양 끝에 배치
        children: [
          Text(name), // 메뉴 이름 (왼쪽)
          // 가격 (오른쪽, 강조 색상)
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.bold, // 굵은 글씨
              color: Theme.of(context).colorScheme.primary, // 기본 색상
            ),
          ),
        ],
      ),
    );
  }
}
