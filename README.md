# WET (What to Eat Today) - Frontend

> 🍽️ 오늘 뭐 먹지? 주소 기반 맛집 검색 서비스

Flutter로 개발된 크로스 플랫폼 모바일 애플리케이션입니다. 사용자가 선택한 주소를 기반으로 주변 맛집을 검색할 수 있습니다.

## 📱 주요 기능

- **전국 주소 선택**: 17개 광역시/도, 주요 구/군, 동 단위까지 선택 가능
- **맛집 검색**: 선택한 주소 기반으로 카카오 지도 API를 통해 주변 식당 검색
- **검색 결과 표시**: 식당명, 주소, 카테고리 정보를 리스트로 표시
- **반응형 UI**: iOS 및 Android 모두 지원

## 🛠️ 기술 스택

- **Framework**: Flutter 3.x
- **Language**: Dart
- **HTTP Client**: http 패키지
- **State Management**: StatefulWidget
- **UI Components**: Material Design

## 📦 설치 및 실행

### 사전 요구사항
- Flutter SDK 3.0 이상
- Dart SDK
- iOS Simulator 또는 Android Emulator

### 설치
```bash
# 의존성 설치
flutter pub get

# iOS 시뮬레이터에서 실행
flutter run

# Android 에뮬레이터에서 실행
flutter run
```

## 🔧 환경 설정

### 백엔드 서버 연결
`lib/features/home/home_screen.dart` 파일에서 API URL을 환경에 맞게 수정하세요:

```dart
// iOS 시뮬레이터
final url = Uri.parse('http://localhost:8080/api/restaurants/search?address=$_selectedAddress');

// Android 에뮬레이터
final url = Uri.parse('http://10.0.2.2:8080/api/restaurants/search?address=$_selectedAddress');

// 실제 기기
final url = Uri.parse('http://YOUR_IP:8080/api/restaurants/search?address=$_selectedAddress');
```

## 📂 프로젝트 구조

```
lib/
├── main.dart                          # 앱 진입점
├── features/
│   ├── home/
│   │   ├── home_screen.dart          # 홈 화면 (주소 선택 + 검색)
│   │   └── widgets/
│   │       └── address_selector.dart # 주소 선택 위젯 (사용 안 함)
│   └── main_screen.dart              # 메인 네비게이션
└── ...
```

## 🌏 지원 지역

- **광역시**: 서울, 부산, 대구, 인천, 광주, 대전, 울산, 세종
- **도**: 경기도, 강원도, 충청북도, 충청남도, 전라북도, 전라남도, 경상북도, 경상남도, 제주도

## 🔗 관련 프로젝트

- [WET Backend](https://github.com/JongHwaShin/wet-backend) - Spring Boot 기반 백엔드 서버

## 📝 라이선스

This project is licensed under the MIT License.

## 👨‍💻 개발자

JongHwa Shin
