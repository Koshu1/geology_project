import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _textNoteController = TextEditingController();

  @override
  void dispose() {
    _textNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textNoteController,
              decoration: const InputDecoration(
                labelText: "Text Note",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String textNote = _textNoteController.text;
                print("Saved text note: $textNote"); // For now, it just prints the note.
              },
              child: const Text("Save Text Note"),
            ),
          ],
        ),
      ),
    );
  }
}
