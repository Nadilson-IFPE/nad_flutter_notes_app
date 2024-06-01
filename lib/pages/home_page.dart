import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            if (listaDeNotas.isEmpty) {
              return const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ainda não foi registrada nota alguma... Aguardando!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue[100],
                      child: ListTile(
                        title: Text(
                          'Notas registradas: ${listaDeNotas.length}'
                              .toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
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
                    ),
                  ),
                ],
              );
            }
          } else {
            return const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Verificando se há notas registradas... Aguarde!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
