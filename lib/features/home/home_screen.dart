// Flutter의 Material 디자인 위젯들을 사용하기 위한 import
import 'package:flutter/material.dart';

// HomeScreen: 앱의 홈 화면
// StatelessWidget: 상태가 변하지 않는 위젯
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      // SingleChildScrollView: 내용이 화면을 넘어가면 스크롤 가능하게 만듦
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // 전체 여백 16픽셀
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
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
              'What would you like to eat today?',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600], // 회색 텍스트
                  ),
            ),
            const SizedBox(height: 24), // 24픽셀 간격
            // 추천 카드 위젯
            _buildRecommendationCard(context),
            const SizedBox(height: 24),
            // "Popular Categories" 제목
            Text(
              'Popular Categories',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // 카테고리 아이콘들
            _buildCategories(context),
          ],
        ),
      ),
    );
  }

  // _buildRecommendationCard: 오늘의 추천 음식을 보여주는 카드 위젯
  Widget _buildRecommendationCard(BuildContext context) {
    return Container(
      width: double.infinity, // 화면 전체 너비
      padding: const EdgeInsets.all(24), // 내부 여백 24픽셀
      decoration: BoxDecoration(
        // gradient: 그라데이션 배경색 (왼쪽 위에서 오른쪽 아래로)
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary, // 기본 색상
            Theme.of(context).colorScheme.secondary, // 보조 색상
          ],
          begin: Alignment.topLeft, // 시작점: 왼쪽 위
          end: Alignment.bottomRight, // 끝점: 오른쪽 아래
        ),
        borderRadius: BorderRadius.circular(20), // 모서리를 둥글게 (반경 20)
        // boxShadow: 그림자 효과
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3), // 그림자 색상 (투명도 30%)
            blurRadius: 10, // 흐림 정도
            offset: const Offset(0, 5), // 그림자 위치 (아래로 5픽셀)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Today's Pick" 라벨
          const Text(
            'Today\'s Pick',
            style: TextStyle(
              color: Colors.white70, // 반투명 흰색
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          // 추천 음식 이름
          const Text(
            'Spicy Ramen 🍜',
            style: TextStyle(
              color: Colors.white, // 흰색
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // "Find Places" 버튼
          ElevatedButton(
            onPressed: () {}, // 버튼 클릭 시 실행할 함수
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // 버튼 배경색: 흰색
              foregroundColor: Theme.of(context).colorScheme.primary, // 텍스트 색상
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // 둥근 모서리
              ),
            ),
            child: const Text('Find Places'),
          ),
        ],
      ),
    );
  }

  // _buildCategories: 음식 카테고리 아이콘들을 보여주는 위젯
  Widget _buildCategories(BuildContext context) {
    // categories: 각 카테고리의 아이콘과 이름을 담은 리스트
    final categories = [
      {'icon': '🍕', 'name': 'Pizza'},
      {'icon': '🍔', 'name': 'Burger'},
      {'icon': '🍣', 'name': 'Sushi'},
      {'icon': '🥗', 'name': 'Healthy'},
    ];

    // Row: 가로로 위젯들을 배치
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양 끝에 공간을 균등하게 배치
      children: categories.map((cat) {
        // map: 각 카테고리를 위젯으로 변환
        return Column(
          children: [
            // 카테고리 아이콘을 담은 원형 컨테이너
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest, // 배경색
                shape: BoxShape.circle, // 원형
              ),
              child: Text(
                cat['icon']!, // 이모지 아이콘
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 8),
            // 카테고리 이름
            Text(
              cat['name']!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        );
      }).toList(), // map 결과를 리스트로 변환
    );
  }
}
