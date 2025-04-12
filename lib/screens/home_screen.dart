import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

void main() {
  runApp(
    const MaterialApp(
      home: DateConverterScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class DateConverterScreen extends StatefulWidget {
  const DateConverterScreen({super.key});

  @override
  State<DateConverterScreen> createState() => _DateConverterScreenState();
}

class _DateConverterScreenState extends State<DateConverterScreen> {
  bool isBsToAd = true;

  // For BS to AD
  int _bsYear = NepaliDateTime.now().year;
  int _bsMonth = NepaliDateTime.now().month;
  int _bsDay = NepaliDateTime.now().day;

  // For AD to BS
  int _adYear = DateTime.now().year;
  int _adMonth = DateTime.now().month;
  int _adDay = DateTime.now().day;

  String? _convertedDate;

  final List<Map<String, dynamic>> nepaliMonths = [
    {'name': 'Baishakh', 'value': 1},
    {'name': 'Jestha', 'value': 2},
    {'name': 'Ashar', 'value': 3},
    {'name': 'Shrawan', 'value': 4},
    {'name': 'Bhadra', 'value': 5},
    {'name': 'Ashoj', 'value': 6},
    {'name': 'Kartik', 'value': 7},
    {'name': 'Mangsir', 'value': 8},
    {'name': 'Poush', 'value': 9},
    {'name': 'Magh', 'value': 10},
    {'name': 'Falgun', 'value': 11},
    {'name': 'Chaitra', 'value': 12},
  ];

  final List<Map<String, dynamic>> englishMonths = [
    {'name': 'January', 'value': 1},
    {'name': 'February', 'value': 2},
    {'name': 'March', 'value': 3},
    {'name': 'April', 'value': 4},
    {'name': 'May', 'value': 5},
    {'name': 'June', 'value': 6},
    {'name': 'July', 'value': 7},
    {'name': 'August', 'value': 8},
    {'name': 'September', 'value': 9},
    {'name': 'October', 'value': 10},
    {'name': 'November', 'value': 11},
    {'name': 'December', 'value': 12},
  ];

  List<int> generateYears(int start, int count) =>
      List.generate(count, (i) => start + i);
  final List<int> days = List.generate(32, (i) => i + 1);

  void _convertDate() {
    try {
      if (isBsToAd) {
        final bsDate = NepaliDateTime(_bsYear, _bsMonth, _bsDay);
        final adDate = bsDate.toDateTime();
        setState(() {
          _convertedDate =
              "Converted AD Date: ${adDate.toLocal().toString().split(' ')[0]}";
        });
      } else {
        final adDate = DateTime(_adYear, _adMonth, _adDay);
        final bsDate = NepaliDateTime.fromDateTime(adDate);
        setState(() {
          _convertedDate =
              "Converted BS Date: ${bsDate.year}-${bsDate.month}-${bsDate.day}";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid date selected.")));
    }
  }

  Widget _buildDropdown<T>(
    String label,
    T value,
    List<DropdownMenuItem<T>> items,
    void Function(T?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<T>(value: value, items: items, onChanged: onChanged),
      ],
    );
  }

  Widget _buildDateSelector() {
    if (isBsToAd) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDropdown<int>(
            "Year",
            _bsYear,
            generateYears(2000, 200)
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e.toString())),
                )
                .toList(),
            (val) {
              if (val != null) setState(() => _bsYear = val);
            },
          ),
          _buildDropdown<int>(
            "Month",
            _bsMonth,
            nepaliMonths
                .map(
                  (month) => DropdownMenuItem<int>(
                    value: month['value'],
                    child: Text(month['name']),
                  ),
                )
                .toList(),
            (val) {
              if (val != null) setState(() => _bsMonth = val);
            },
          ),
          _buildDropdown<int>(
            "Day",
            _bsDay,
            days
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e.toString())),
                )
                .toList(),
            (val) {
              if (val != null) setState(() => _bsDay = val);
            },
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDropdown<int>(
            "Year",
            _adYear,
            generateYears(1950, 200)
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e.toString())),
                )
                .toList(),
            (val) {
              if (val != null) setState(() => _adYear = val);
            },
          ),
          _buildDropdown<int>(
            "Month",
            _adMonth,
            englishMonths
                .map(
                  (month) => DropdownMenuItem<int>(
                    value: month['value'],
                    child: Text(month['name']),
                  ),
                )
                .toList(),
            (val) {
              if (val != null) setState(() => _adMonth = val);
            },
          ),
          _buildDropdown<int>(
            "Day",
            _adDay,
            days
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e.toString())),
                )
                .toList(),
            (val) {
              if (val != null) setState(() => _adDay = val);
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Date Converter")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Select Conversion Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: isBsToAd,
                  onChanged: (val) {
                    setState(() {
                      isBsToAd = val!;
                      _convertedDate = null;
                    });
                  },
                ),
                const Text("BS to AD"),
                const SizedBox(width: 20),
                Radio<bool>(
                  value: false,
                  groupValue: isBsToAd,
                  onChanged: (val) {
                    setState(() {
                      isBsToAd = val!;
                      _convertedDate = null;
                    });
                  },
                ),
                const Text("AD to BS"),
              ],
            ),
            const SizedBox(height: 20),
            _buildDateSelector(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convertDate,
              child: const Text("Convert"),
            ),
            const SizedBox(height: 20),
            if (_convertedDate != null)
              Text(
                _convertedDate!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
