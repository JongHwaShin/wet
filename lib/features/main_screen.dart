// Flutter의 Material 디자인 위젯들을 사용하기 위한 import
import 'package:flutter/material.dart';

// 각 화면들을 import
import 'home/home_screen.dart';
import 'home/liked_screen.dart';
import 'home/my_screen.dart';

// MainScreen: 하단 네비게이션 바가 있는 메인 화면
// StatefulWidget: 상태가 변할 수 있는 위젯 (현재 선택된 탭이 변경됨)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// _MainScreenState: MainScreen의 상태를 관리하는 클래스
class _MainScreenState extends State<MainScreen> {
  // _currentIndex: 현재 선택된 탭의 인덱스 (0: Home, 1: Liked, 2: My)
  int _currentIndex = 0;

  // _pages: 각 탭에 표시될 화면들의 리스트
  final List<Widget> _pages = [
    const HomeScreen(), // 0번 인덱스: 홈 화면
    const LikedScreen(), // 1번 인덱스: 찜(Liked) 화면
    const MyScreen(), // 2번 인덱스: 마이 페이지
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold: 기본 화면 구조를 제공하는 위젯 (앱바, 바디, 하단바 등)
    return Scaffold(
      // body: 현재 선택된 인덱스에 해당하는 화면을 표시
      body: _pages[_currentIndex],
      // bottomNavigationBar: 하단 네비게이션 바
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex, // 현재 선택된 탭
        // onDestinationSelected: 탭을 클릭했을 때 실행되는 함수
        onDestinationSelected: (index) {
          // setState: 상태를 변경하고 화면을 다시 그림
          setState(() {
            _currentIndex = index; // 선택된 탭의 인덱스를 업데이트
          });
        },
        // destinations: 네비게이션 바의 각 탭 정의
        destinations: const [
          // 첫 번째 탭: Home
          NavigationDestination(
            icon: Icon(Icons.home_outlined), // 선택되지 않았을 때 아이콘
            selectedIcon: Icon(Icons.home), // 선택되었을 때 아이콘 (채워진 형태)
            label: 'Home', // 탭 라벨
          ),
          // 두 번째 탭: Liked
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: '찜',
          ),
          // 세 번째 탭: My
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'My',
          ),
        ],
      ),
    );
  }
}
