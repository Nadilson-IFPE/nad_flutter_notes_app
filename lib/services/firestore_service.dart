import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notas =
      FirebaseFirestore.instance.collection('notas');

  Future<void> addNota(String nota) {
    return notas.add({'nota': nota, 'timestamp': Timestamp.now()});
  }

  Stream<QuerySnapshot> listNotas() {
    return notas.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> updateNota(String notaId, String newContent) {
    return notas.doc(notaId).update({
      'nota': newContent,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNota(String notaId) {
    return notas.doc(notaId).delete();
  }
}
