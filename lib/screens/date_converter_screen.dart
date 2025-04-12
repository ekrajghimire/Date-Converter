import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

class DateConverterScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const DateConverterScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<DateConverterScreen> createState() => _DateConverterScreenState();
}

class _DateConverterScreenState extends State<DateConverterScreen> {
  bool isBsToAd = true;
  NepaliDateTime _selectedBsDate = NepaliDateTime.now();
  DateTime _selectedAdDate = DateTime.now();
  String _convertedDate = '';

  List<String> englishMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  void _pickBsDate() async {
    final bsDate = await showDatePicker(
      context: context,
      initialDate: _selectedBsDate.toDateTime(),
      firstDate: DateTime(1944, 1, 1),
      lastDate: DateTime(2090, 12, 31),
    );
    if (bsDate != null) {
      setState(() {
        _selectedBsDate = NepaliDateTime.fromDateTime(bsDate);
      });
    }
  }

  void _pickAdDate() async {
    final adDate = await showDatePicker(
      context: context,
      initialDate: _selectedAdDate,
      firstDate: DateTime(1944, 1, 1),
      lastDate: DateTime(2090, 12, 31),
    );
    if (adDate != null) {
      setState(() {
        _selectedAdDate = adDate;
      });
    }
  }

  void _convertDate() {
    setState(() {
      if (isBsToAd) {
        final converted = _selectedBsDate.toDateTime();
        _convertedDate =
            "${converted.day} ${englishMonths[converted.month - 1]}, ${converted.year}";
      } else {
        final converted = NepaliDateTime.fromDateTime(_selectedAdDate);
        NepaliDateFormat fullBsFormat = NepaliDateFormat("yyyy MMMM dd");
        _convertedDate = fullBsFormat.format(converted);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Converter"),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ToggleButtons(
              isSelected: [isBsToAd, !isBsToAd],
              onPressed: (index) {
                setState(() {
                  isBsToAd = index == 0;
                  _convertedDate = '';
                });
              },
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: Theme.of(context).colorScheme.primary,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('BS to AD'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('AD to BS'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (isBsToAd)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _pickBsDate,
                    child: const Text("Select BS Date"),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Selected BS: ${NepaliDateFormat('yyyy MMMM dd').format(_selectedBsDate)}",
                  ),
                ],
              )
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _pickAdDate,
                    child: const Text("Select AD Date"),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Selected AD: ${_selectedAdDate.day} ${englishMonths[_selectedAdDate.month - 1]}, ${_selectedAdDate.year}",
                  ),
                ],
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convertDate,
              child: const Text("Convert Date"),
            ),
            const SizedBox(height: 20),
            if (_convertedDate.isNotEmpty)
              Text(
                "Converted Date:\n$_convertedDate",
                textAlign: TextAlign.center,
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
