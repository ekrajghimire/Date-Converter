import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

class AdToBsScreen extends StatefulWidget {
  const AdToBsScreen({super.key});

  @override
  State<AdToBsScreen> createState() => _AdToBsScreenState();
}

class _AdToBsScreenState extends State<AdToBsScreen> {
  DateTime? _selectedAdDate;
  NepaliDateTime? _convertedBsDate;

  void _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1944),
      lastDate: DateTime(2090),
    );

    if (picked != null) {
      setState(() {
        _selectedAdDate = picked;
        _convertedBsDate = NepaliDateTime.fromDateTime(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AD to BS")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _pickDate(context),
              child: const Text("Pick AD Date"),
            ),
            const SizedBox(height: 30),
            if (_selectedAdDate != null && _convertedBsDate != null) ...[
              Text("Selected AD Date: ${_selectedAdDate!.toLocal().toString().split(' ')[0]}"),
              const SizedBox(height: 10),
              Text("Converted BS Date: ${NepaliDateFormat.yMMMMd().format(_convertedBsDate!)}"),
            ]
          ],
        ),
      ),
    );
  }
}
