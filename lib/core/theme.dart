// Flutter의 Material 디자인 위젯들을 사용하기 위한 import
import 'package:flutter/material.dart';

// AppTheme: 앱 전체의 색상과 스타일을 정의하는 클래스
class AppTheme {
  // lightTheme: 라이트 모드(밝은 테마) 설정
  static final lightTheme = ThemeData(
    useMaterial3: true, // Material Design 3 사용 (최신 디자인 가이드라인)
    // colorScheme: 앱의 색상 팔레트 설정
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF6B6B), // 기본 색상: 선명한 코랄/레드 (식욕을 자극하는 색)
      brightness: Brightness.light, // 밝은 테마
    ),
    scaffoldBackgroundColor: Colors.white, // 화면 배경색: 흰색
    // appBarTheme: 상단 앱바의 스타일 설정
    appBarTheme: const AppBarTheme(
      centerTitle: true, // 제목을 가운데 정렬
      elevation: 0, // 그림자 없음 (평평한 디자인)
      backgroundColor: Colors.white, // 앱바 배경색: 흰색
      foregroundColor: Colors.black, // 앱바 텍스트/아이콘 색상: 검정
    ),
  );

  // darkTheme: 다크 모드(어두운 테마) 설정
  static final darkTheme = ThemeData(
    useMaterial3: true, // Material Design 3 사용
    // colorScheme: 다크 모드 색상 팔레트
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF6B6B), // 기본 색상: 라이트 모드와 동일
      brightness: Brightness.dark, // 어두운 테마
    ),
    scaffoldBackgroundColor: const Color(0xFF121212), // 화면 배경색: 진한 회색 (눈의 피로 감소)
    // appBarTheme: 다크 모드 앱바 스타일
    appBarTheme: const AppBarTheme(
      centerTitle: true, // 제목을 가운데 정렬
      elevation: 0, // 그림자 없음
      backgroundColor: Color(0xFF121212), // 앱바 배경색: 배경과 동일한 진한 회색
      foregroundColor: Colors.white, // 앱바 텍스트/아이콘 색상: 흰색
    ),
  );
}
