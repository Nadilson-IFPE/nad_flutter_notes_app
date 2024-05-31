import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nad_flutter_notes_app/dialogs/note_dialog.dart';
import 'package:nad_flutter_notes_app/services/firestore_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirestoreService firestoreSvc = FirestoreService();

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
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreSvc.listNotas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List listaDeNotas = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listaDeNotas.length,
              itemBuilder: (context, idx) {
                DocumentSnapshot documentSnapshot = listaDeNotas[idx];
                String notaID = documentSnapshot.id;
                Map<String, dynamic> dados =
                    documentSnapshot.data() as Map<String, dynamic>;
                String textoNota = dados['nota'];
                return ListTile(
                  title: Text(textoNota),
                );
              },
            );
          } else {
            return const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Nenhuma nota cadastrada, ainda...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
