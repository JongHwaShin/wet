import 'package:flutter/material.dart';

class AddressSelector extends StatefulWidget {
  final Function(String) onAddressChanged;

  const AddressSelector({super.key, required this.onAddressChanged});

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  // 선택된 주소 데이터
  String? _selectedCity = '서울시';
  String? _selectedDistrict;
  String? _selectedNeighborhood;

  // 예시 데이터: 시/도 -> 구/군 -> 동
  final Map<String, Map<String, List<String>>> _addressData = {
    '서울시': {
      '강남구': ['역삼동', '논현동', '삼성동', '청담동'],
      '서초구': ['서초동', '반포동', '방배동', '양재동'],
      '마포구': ['서교동', '합정동', '연남동', '망원동'],
      '송파구': ['잠실동', '가락동', '문정동', '방이동'],
    },
    '경기도': {
      '성남시': ['분당구', '수정구', '중원구'],
      '수원시': ['팔달구', '영통구', '장안구', '권선구'],
    }
  };

  @override
  void initState() {
    super.initState();
    // 초기값 설정
    _selectedDistrict = _addressData['서울시']!.keys.first;
    _selectedNeighborhood = _addressData['서울시']![_selectedDistrict]!.first;
    _notifyAddressChanged();
  }

  void _notifyAddressChanged() {
    if (_selectedCity != null &&
        _selectedDistrict != null &&
        _selectedNeighborhood != null) {
      widget.onAddressChanged(
          '$_selectedCity $_selectedDistrict $_selectedNeighborhood');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05), // 배경색을 연한 파란색으로 변경하여 구분
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)), // 테두리 추가
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '위치 설정',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // 시/도 선택
              Expanded(
                child: _buildDropdown(
                  value: _selectedCity,
                  items: _addressData.keys.toList(),
                  hint: '시/도',
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                      _selectedDistrict = _addressData[value]!.keys.first;
                      _selectedNeighborhood =
                          _addressData[value]![_selectedDistrict]!.first;
                      _notifyAddressChanged();
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              // 구/군 선택
              Expanded(
                child: _buildDropdown(
                  value: _selectedDistrict,
                  items: _selectedCity != null
                      ? _addressData[_selectedCity]!.keys.toList()
                      : [],
                  hint: '구/군',
                  onChanged: (value) {
                    setState(() {
                      _selectedDistrict = value;
                      _selectedNeighborhood =
                          _addressData[_selectedCity]![value]!.first;
                      _notifyAddressChanged();
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              // 동 선택
              Expanded(
                child: _buildDropdown(
                  value: _selectedNeighborhood,
                  items: (_selectedCity != null && _selectedDistrict != null)
                      ? _addressData[_selectedCity]![_selectedDistrict]!
                      : [],
                  hint: '동',
                  onChanged: (value) {
                    setState(() {
                      _selectedNeighborhood = value;
                      _notifyAddressChanged();
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: const TextStyle(fontSize: 12)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 13,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
