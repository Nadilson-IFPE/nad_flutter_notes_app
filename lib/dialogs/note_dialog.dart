import 'package:flutter/material.dart';
import 'package:nad_flutter_notes_app/services/firestore_service.dart';

class NoteDialog {
  static Future<void> openNoteDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    final FirestoreService firestoreService = FirestoreService();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              firestoreService.addNota(textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
