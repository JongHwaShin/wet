import 'package:flutter/material.dart';

class AddressSelector extends StatefulWidget {
  final Function(String) onAddressChanged;

  const AddressSelector({super.key, required this.onAddressChanged});

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  String _selectedAddress = '서울시 강남구 역삼동';

  @override
  void initState() {
    super.initState();
    widget.onAddressChanged(_selectedAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '📍 주소 설정',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '현재 주소: $_selectedAddress',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            '(임시: 드롭다운 추후 추가 예정)',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
