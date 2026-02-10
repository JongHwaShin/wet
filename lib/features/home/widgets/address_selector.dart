import 'package:flutter/material.dart';
import '../data/korea_administrative_divisions.dart';

class AddressSelector extends StatefulWidget {
  final Function(String) onAddressChanged;

  const AddressSelector({super.key, required this.onAddressChanged});

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  String _selectedProvince = '서울시';
  String _selectedDistrict = '강남구';

  @override
  void initState() {
    super.initState();
    // Initialize with first available data if defaults don't exist
    if (!koreaAdministrativeDivisions.containsKey(_selectedProvince)) {
      _selectedProvince = koreaAdministrativeDivisions.keys.first;
    }
    final districts = koreaAdministrativeDivisions[_selectedProvince] ?? [];
    if (!districts.contains(_selectedDistrict)) {
      _selectedDistrict = districts.isNotEmpty ? districts.first : '';
    }
  }

  void _onProvinceChanged(String newValue) {
    setState(() {
      _selectedProvince = newValue;
      final districts = koreaAdministrativeDivisions[newValue] ?? [];
      _selectedDistrict = districts.isNotEmpty ? districts.first : '';
    });
  }

  void _onDistrictChanged(String newValue) {
    setState(() {
      _selectedDistrict = newValue;
    });
  }

  void _confirmSelection() {
    widget.onAddressChanged('$_selectedProvince $_selectedDistrict');
    Navigator.pop(context); // Close the modal
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Title
          const Text(
            '주소를 선택해주세요',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Divider
          const Divider(height: 1, thickness: 1),
          // 2-Pane Selection Area
          Expanded(
            child: Row(
              children: [
                // Left Pane: Provinces (Si/Do)
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[100],
                    child: ListView.builder(
                      itemCount: koreaAdministrativeDivisions.keys.length,
                      itemBuilder: (context, index) {
                        final province =
                            koreaAdministrativeDivisions.keys.elementAt(index);
                        final isSelected = province == _selectedProvince;
                        return InkWell(
                          onTap: () => _onProvinceChanged(province),
                          child: Container(
                            color: isSelected ? Colors.white : Colors.grey[100],
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            child: Text(
                              province,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey[600],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Right Pane: Districts (Si/Gun/Gu)
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount:
                          (koreaAdministrativeDivisions[_selectedProvince] ?? [])
                              .length,
                      itemBuilder: (context, index) {
                        final districts =
                            koreaAdministrativeDivisions[_selectedProvince] ??
                                [];
                        final district = districts[index];
                        final isSelected = district == _selectedDistrict;
                        return InkWell(
                          onTap: () => _onDistrictChanged(district),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  district,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? const Color(0xFFEA1D2C)
                                        : Colors.black87,
                                  ),
                                ),
                                if (isSelected) ...[
                                  const Spacer(),
                                  const Icon(
                                    Icons.check,
                                    color: Color(0xFFEA1D2C),
                                    size: 20,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Button Area
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ]
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: _confirmSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEA1D2C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  '선택 완료',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
