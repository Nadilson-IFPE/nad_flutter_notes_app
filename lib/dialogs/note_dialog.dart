import 'package:flutter/material.dart';

class NoteDialog {
  static Future<void> openNoteDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
