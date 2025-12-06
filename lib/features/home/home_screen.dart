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

  // 드롭다운 선택값
  String _selectedCity = '서울시';
  String _selectedDistrict = '강남구';
  String _selectedNeighborhood = '역삼동';

  // 주소 데이터 - 전국 17개 광역시/도
  final Map<String, Map<String, List<String>>> _addressData = {
    '서울시': {
      '강남구': ['역삼동', '논현동', '삼성동', '청담동'],
      '서초구': ['서초동', '반포동', '방배동', '양재동'],
      '마포구': ['서교동', '합정동', '연남동', '망원동'],
      '송파구': ['잠실동', '가락동', '문정동', '방이동'],
      '강서구': ['화곡동', '가양동', '염창동', '등촌동'],
    },
    '부산시': {
      '해운대구': ['우동', '중동', '좌동', '송정동'],
      '남구': ['대연동', '문현동', '용호동'],
      '동래구': ['온천동', '사직동', '명륜동'],
      '부산진구': ['부전동', '전포동', '연지동'],
    },
    '대구시': {
      '중구': ['동성동', '삼덕동', '대신동'],
      '수성구': ['범어동', '만촌동', '수성동'],
      '달서구': ['성당동', '두류동', '본리동'],
    },
    '인천시': {
      '남동구': ['구월동', '간석동', '만수동'],
      '연수구': ['송도동', '옥련동', '청학동'],
      '부평구': ['부평동', '산곡동', '십정동'],
    },
    '광주시': {
      '동구': ['충장동', '금남동', '계림동'],
      '서구': ['화정동', '치평동', '상무동'],
      '남구': ['봉선동', '주월동', '월산동'],
    },
    '대전시': {
      '서구': ['둔산동', '탄방동', '월평동'],
      '유성구': ['봉명동', '노은동', '구암동'],
      '중구': ['은행동', '대흥동', '선화동'],
    },
    '울산시': {
      '남구': ['삼산동', '달동', '신정동'],
      '북구': ['화봉동', '연암동', '효문동'],
      '중구': ['성남동', '태화동', '학성동'],
    },
    '세종시': {
      '조치원읍': ['신흥리', '죽림리', '봉산리'],
      '연기면': ['세종리', '나성리', '수산리'],
    },
    '경기도': {
      '수원시': ['팔달구', '영통구', '장안구', '권선구'],
      '성남시': ['분당구', '수정구', '중원구'],
      '고양시': ['일산동구', '일산서구', '덕양구'],
      '용인시': ['수지구', '기흥구', '처인구'],
      '부천시': ['원미구', '소사구', '오정구'],
    },
    '강원도': {
      '춘천시': ['춘천동', '후평동', '석사동'],
      '원주시': ['단계동', '무실동', '태장동'],
      '강릉시': ['포남동', '교동', '옥천동'],
    },
    '충북': {
      '청주시': ['상당구', '서원구', '흥덕구', '청원구'],
      '충주시': ['성내동', '금릉동', '교현동'],
    },
    '충남': {
      '천안시': ['동남구', '서북구'],
      '아산시': ['온천동', '배방읍', '탕정면'],
    },
    '전북': {
      '전주시': ['완산구', '덕진구'],
      '익산시': ['중앙동', '모현동', '남중동'],
    },
    '전남': {
      '목포시': ['상동', '하당동', '연산동'],
      '순천시': ['조례동', '연향동', '왕지동'],
      '여수시': ['여서동', '군자동', '광무동'],
    },
    '경북': {
      '포항시': ['남구', '북구'],
      '구미시': ['원평동', '형곡동', '송정동'],
      '경산시': ['중방동', '사동', '압량읍'],
    },
    '경남': {
      '창원시': ['의창구', '성산구', '마산합포구', '마산회원구', '진해구'],
      '김해시': ['내외동', '부원동', '삼계동'],
      '진주시': ['상대동', '하대동', '초전동'],
    },
    '제주도': {
      '제주시': ['일도동', '이도동', '삼도동', '연동'],
      '서귀포시': ['서귀동', '중문동', '대정읍'],
    },
  };

  void _updateAddress() {
    setState(() {
      _selectedAddress = '$_selectedCity $_selectedDistrict $_selectedNeighborhood';
    });
  }

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
                const SizedBox(height: 16),
                
                // 주소 선택 박스
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            '주소 설정',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // 시/도 선택
                      DropdownButtonFormField<String>(
                        value: _selectedCity,
                        menuMaxHeight: 300, // 스크롤 가능하도록 최대 높이 설정
                        decoration: const InputDecoration(
                          labelText: '시/도',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _addressData.keys.map((city) {
                          return DropdownMenuItem(value: city, child: Text(city));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value!;
                            _selectedDistrict = _addressData[value]!.keys.first;
                            _selectedNeighborhood = _addressData[value]![_selectedDistrict]!.first;
                            _updateAddress();
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      
                      // 구/군 선택
                      DropdownButtonFormField<String>(
                        value: _selectedDistrict,
                        menuMaxHeight: 300, // 스크롤 가능하도록 최대 높이 설정
                        decoration: const InputDecoration(
                          labelText: '구/군',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _addressData[_selectedCity]!.keys.map((district) {
                          return DropdownMenuItem(value: district, child: Text(district));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDistrict = value!;
                            _selectedNeighborhood = _addressData[_selectedCity]![value]!.first;
                            _updateAddress();
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      
                      // 동 선택
                      DropdownButtonFormField<String>(
                        value: _selectedNeighborhood,
                        menuMaxHeight: 300, // 스크롤 가능하도록 최대 높이 설정
                        decoration: const InputDecoration(
                          labelText: '동',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _addressData[_selectedCity]![_selectedDistrict]!.map((neighborhood) {
                          return DropdownMenuItem(value: neighborhood, child: Text(neighborhood));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedNeighborhood = value!;
                            _updateAddress();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
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
