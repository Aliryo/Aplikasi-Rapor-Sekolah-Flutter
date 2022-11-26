import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skripsi_rapor_sd/models/mapel.dart';

class MapelDatabaseService {
  String _uid = '';

  MapelDatabaseService() {
    if (FirebaseAuth.instance.currentUser != null) {
      _uid = FirebaseAuth.instance.currentUser!.uid;
    }
  }

  final _mapelReference = FirebaseFirestore.instance.collection('mapel');

  List<Mapel> _mapelListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Mapel(
        id: doc.id,
        title: data['title'] ?? '',
        guru: data['guru'] ?? '',
        image: data['image'] ?? '',
        content: data['content'] ?? '',
      );
    }).toList();
  }

  Stream<List<Mapel>> get mapel {
    return _mapelReference
        .orderBy('title')
        .snapshots()
        .map(_mapelListFromSnapshot);
  }

  Future addNewMapel(String title) {
    return _mapelReference.add({
      'title': title,
      'guru': 'Guru ' + title,
      'image': '',
      'content': '',
      'uid': _uid,
    });
  }

  Future updateMapel(Mapel mapel) {
    return _mapelReference.doc(mapel.id).update({
      'title': mapel.title,
      'guru': mapel.guru,
      'image': mapel.image,
      'content': mapel.content,
    });
  }

  Future deleteMapel(String docId) {
    return _mapelReference.doc(docId).delete();
  }
}
