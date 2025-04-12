import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

class BsToAdScreen extends StatefulWidget {
  const BsToAdScreen({super.key});

  @override
  State<BsToAdScreen> createState() => _BsToAdScreenState();
}

class _BsToAdScreenState extends State<BsToAdScreen> {
  // int _selectedYear = 2080;
  // int _selectedMonth = 1;
  // int _selectedDay = 1;

  late int _selectedYear;
  late int _selectedMonth;
  late int _selectedDay;

  DateTime? _convertedAdDate;

  List<int> years = List.generate(200, (index) => 1950 + index);
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> days = List.generate(32, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    final now = NepaliDateTime.now();
    _selectedYear = now.year;
    _selectedMonth = now.month;
    _selectedDay = now.day;
  }

  void _convertToAd() {
    try {
      final bsDate = NepaliDateTime(
        _selectedYear,
        _selectedMonth,
        _selectedDay,
      );
      final adDate = bsDate.toDateTime();

      setState(() {
        _convertedAdDate = adDate;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid BS date selected.")),
      );
    }
  }

  Widget _buildDropdown(
    String label,
    int value,
    List<int> items,
    void Function(int?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<int>(
          value: value,
          items:
              items
                  .map(
                    (e) =>
                        DropdownMenuItem(value: e, child: Text(e.toString())),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BS to AD")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Select BS Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDropdown("Year", _selectedYear, years, (val) {
                  if (val != null) setState(() => _selectedYear = val);
                }),
                _buildDropdown("Month", _selectedMonth, months, (val) {
                  if (val != null) setState(() => _selectedMonth = val);
                }),
                _buildDropdown("Day", _selectedDay, days, (val) {
                  if (val != null) setState(() => _selectedDay = val);
                }),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convertToAd,
              child: const Text("Convert to AD"),
            ),
            const SizedBox(height: 20),
            if (_convertedAdDate != null)
              Text(
                "Converted AD Date: ${_convertedAdDate!.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
