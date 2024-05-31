import 'package:flutter/material.dart';
import 'package:nad_flutter_notes_app/dialogs/note_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NoteDialog.openNoteDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
