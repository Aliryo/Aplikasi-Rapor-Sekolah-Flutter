import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skripsi_rapor_sd/models/rapor.dart';

class DatabaseService {
  String _uid = '';

  DatabaseService() {
    if (FirebaseAuth.instance.currentUser != null) {
      _uid = FirebaseAuth.instance.currentUser!.uid;
    }
  }

  final _raporReference = FirebaseFirestore.instance.collection('rapor');

  List<Rapor> _raporListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Rapor(
        id: doc.id,
        nama: data['nama'] ?? '',
        nisn: data['nisn'] ?? '',
        kls: data['kls'] ?? '1 (Satu)',
        smstr: data['smstr'] ?? '1 (Satu)',
        thn: data['thn'] ?? '2022 / 2023',
        agama: data['agama'] ?? '0',
        pkn: data['pkn'] ?? '0',
        indonesia: data['indonesia'] ?? '0',
        matek: data['matek'] ?? '0',
        ipa: data['ipa'] ?? '0',
        ips: data['ips'] ?? '0',
        sbk: data['sbk'] ?? '0',
        pjok: data['pjok'] ?? '0',
        sunda: data['sunda'] ?? '0',
        karawitan: data['karawitan'] ?? '0',
        inggris: data['inggris'] ?? '0',
        sikap: data['sikap'] ?? 'Baik',
        kerajinan: data['kerajinan'] ?? 'Baik',
        kebersihan: data['kebersihan'] ?? 'Baik',
        izin: data['izin'] ?? '0',
        sakit: data['sakit'] ?? '0',
        tanpa: data['tanpa'] ?? '0',
        catatan: data['catatan'] ?? '',
      );
    }).toList();
  }

  Future<List<Rapor>> rapor() async {
    var usr = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    var data = usr.data() as Map<String, dynamic>;

    return _raporReference
        .where('nama', isEqualTo: data['username'])
        .orderBy('kls')
        .orderBy('smstr')
        .get()
        .then(_raporListFromSnapshot);
  }

  Stream<List<Rapor>> get raporSatu {
    return _raporReference
        .orderBy('thn', descending: true)
        .orderBy('nama')
        .orderBy('smstr')
        .where('kls', isEqualTo: '1 (Satu)')
        .snapshots()
        .map(_raporListFromSnapshot);
  }

  Stream<List<Rapor>> get raporDua {
    return _raporReference
        .orderBy('thn', descending: true)
        .orderBy('nama')
        .orderBy('smstr')
        .where('kls', isEqualTo: '2 (Dua)')
        .snapshots()
        .map(_raporListFromSnapshot);
  }

  Stream<List<Rapor>> get raporTiga {
    return _raporReference
        .orderBy('thn', descending: true)
        .orderBy('nama')
        .orderBy('smstr')
        .where('kls', isEqualTo: '3 (Tiga)')
        .snapshots()
        .map(_raporListFromSnapshot);
  }

  Stream<List<Rapor>> get raporEmpat {
    return _raporReference
        .orderBy('thn', descending: true)
        .orderBy('nama')
        .orderBy('smstr')
        .where('kls', isEqualTo: '4 (Empat)')
        .snapshots()
        .map(_raporListFromSnapshot);
  }

  Stream<List<Rapor>> get raporLima {
    return _raporReference
        .orderBy('thn', descending: true)
        .orderBy('nama')
        .orderBy('smstr')
        .where('kls', isEqualTo: '5 (Lima)')
        .snapshots()
        .map(_raporListFromSnapshot);
  }

  Stream<List<Rapor>> get raporEnam {
    return _raporReference
        .orderBy('thn', descending: true)
        .orderBy('nama')
        .orderBy('smstr')
        .where('kls', isEqualTo: '6 (Enam)')
        .snapshots()
        .map(_raporListFromSnapshot);
  }

  Future addNewRapor(String nama) {
    return _raporReference.add({
      'nama': nama,
      'kls': '1 (Satu)',
      'thn': '2022 / 2023',
      'smstr': '1 (Satu)',
      'uid': _uid,
    });
  }

  Future addNewRaporDua(String nama) {
    return _raporReference.add({
      'nama': nama,
      'kls': '2 (Dua)',
      'thn': '2022 / 2023',
      'smstr': '1 (Satu)',
      'uid': _uid,
    });
  }

  Future addNewRaporTiga(String nama) {
    return _raporReference.add({
      'nama': nama,
      'kls': '3 (Tiga)',
      'thn': '2022 / 2023',
      'smstr': '1 (Satu)',
      'uid': _uid,
    });
  }

  Future addNewRaporEmpat(String nama) {
    return _raporReference.add({
      'nama': nama,
      'kls': '4 (Empat)',
      'thn': '2022 / 2023',
      'smstr': '1 (Satu)',
      'uid': _uid,
    });
  }

  Future addNewRaporLima(String nama) {
    return _raporReference.add({
      'nama': nama,
      'kls': '5 (Lima)',
      'thn': '2022 / 2023',
      'smstr': '1 (Satu)',
      'uid': _uid,
    });
  }

  Future addNewRaporEnam(String nama) {
    return _raporReference.add({
      'nama': nama,
      'kls': '6 (Enam)',
      'thn': '2022 / 2023',
      'smstr': '1 (Satu)',
      'uid': _uid,
    });
  }

  Future updateRapor(Rapor rapor) {
    return _raporReference.doc(rapor.id).update({
      'nama': rapor.nama,
      'nisn': rapor.nisn,
      'kls': rapor.kls,
      'smstr': rapor.smstr,
      'thn': rapor.thn,
      'agama': rapor.agama,
      'pkn': rapor.pkn,
      'indonesia': rapor.indonesia,
      'matek': rapor.matek,
      'ipa': rapor.ipa,
      'ips': rapor.ips,
      'sbk': rapor.sbk,
      'pjok': rapor.pjok,
      'sunda': rapor.sunda,
      'karawitan': rapor.karawitan,
      'inggris': rapor.inggris,
      'sikap': rapor.sikap,
      'kerajinan': rapor.kerajinan,
      'kebersihan': rapor.kebersihan,
      'izin': rapor.izin,
      'sakit': rapor.sakit,
      'tanpa': rapor.tanpa,
      'catatan': rapor.catatan,
    });
  }

  Future deleteRapor(String docId) {
    return _raporReference.doc(docId).delete();
  }
}
