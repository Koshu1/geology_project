import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';


class DataCollectionScreen extends StatefulWidget {
  const DataCollectionScreen({super.key});

  @override
  _DataCollectionScreenState createState() => _DataCollectionScreenState();
}

class _DataCollectionScreenState extends State<DataCollectionScreen> {
  final TextEditingController _strikeController = TextEditingController();
  final TextEditingController _dipController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();
  final List<Map<String, String>> _collectedData = [];
  
  Future<void> _exportData() async {
  final Directory directory = await getExternalStorageDirectory() ?? await getTemporaryDirectory();

  // Save as Text
  final File textFile = File('${directory.path}/geological_data.txt');
  String dataText = _collectedData.map((data) => "Strike: ${data['strike']}, Dip: ${data['dip']}, Direction: ${data['direction']}").join("\n");
  await textFile.writeAsString(dataText);
  print("Text file saved at ${textFile.path}");

  // Save as Excel
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];
  for (var data in _collectedData) {
    sheetObject.appendRow([data['strike'], data['dip'], data['direction']]);
  }
  final excelFile = File('${directory.path}/geological_data.xlsx')
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);
  print("Excel file saved at ${excelFile.path}");
}
  void _saveData() {
    String strike = _strikeController.text;
    String dip = _dipController.text;
    String direction = _directionController.text;

    setState(() {
      _collectedData.add({
        'strike': strike,
        'dip': dip,
        'direction': direction,
      });
    });

    print("Data saved: Strike=$strike, Dip=$dip, Direction=$direction");
    
  }
  
  

  @override
  void dispose() {
    _strikeController.dispose();
    _dipController.dispose();
    _directionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Collection")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _strikeController,
              decoration: const InputDecoration(
                labelText: "Strike",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dipController,
              decoration: const InputDecoration(
                labelText: "Dip",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _directionController,
              decoration: const InputDecoration(
                labelText: "Direction",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String strike = _strikeController.text;
                String dip = _dipController.text;
                String direction = _directionController.text;
                print("Strike: $strike, Dip: $dip, Direction: $direction"); // Placeholder for saving data
              },
              child: const Text("Save Data"),
            ),
            Expanded(
  child: ListView.builder(
    itemCount: _collectedData.length,
    itemBuilder: (context, index) {
      final data = _collectedData[index];
      return ListTile(
        title: Text("Strike: ${data['strike']}, Dip: ${data['dip']}, Direction: ${data['direction']}"),
      );
    },
  ),
),
           ElevatedButton(
  onPressed: _exportData,
  child: const Text("Export Data"),
),

          ],
        ),
      ),
    );
  }
  
}
