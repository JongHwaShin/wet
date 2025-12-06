// Flutter의 Material 디자인 위젯들을 사용하기 위한 import
import 'package:flutter/material.dart';
// 앱의 테마(색상, 스타일 등) 설정을 가져옴
import 'core/theme.dart';
// 메인 화면(하단 네비게이션이 있는 화면)을 가져옴
import 'features/main_screen.dart';

// 앱의 시작점 - 이 함수가 가장 먼저 실행됨
void main() {
  // MyApp 위젯을 실행하여 앱을 시작
  runApp(const MyApp());
}

// MyApp: 앱의 최상위 위젯 (앱 전체 설정을 담당)
// StatelessWidget: 상태가 변하지 않는 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // build: 화면에 표시될 위젯을 만드는 메서드
  @override
  Widget build(BuildContext context) {
    // MaterialApp: Material 디자인 기반의 앱을 만드는 최상위 위젯
    return MaterialApp(
      title: 'wet', // 앱 이름 (작업 관리자 등에서 표시됨)
      theme: AppTheme.lightTheme, // 라이트 모드 테마 설정
      darkTheme: AppTheme.darkTheme, // 다크 모드 테마 설정
      themeMode: ThemeMode.system, // 시스템 설정에 따라 자동으로 라이트/다크 모드 전환
      home: const MainScreen(), // 앱이 시작될 때 보여줄 첫 화면
      debugShowCheckedModeBanner: false, // 디버그 배너(우측 상단 DEBUG 표시) 숨김
    );
  }
}
