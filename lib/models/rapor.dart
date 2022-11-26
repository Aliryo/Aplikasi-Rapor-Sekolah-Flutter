class Rapor {
  //identitas
  final String id;
  final String nama;
  final String nisn;
  final String kls;
  final String smstr;
  final String thn;
  //nilai
  final String agama;
  final String pkn;
  final String indonesia;
  final String matek;
  final String ipa;
  final String ips;
  final String sbk;
  final String pjok;
  final String sunda;
  final String karawitan;
  final String inggris;
  //kepribadian
  final String sikap;
  final String kerajinan;
  final String kebersihan;
  final String izin;
  final String sakit;
  final String tanpa;
  final String catatan;

  Rapor({
    required this.id,
    required this.nama,
    required this.nisn,
    required this.kls,
    required this.smstr,
    required this.thn,
    this.agama = '',
    this.pkn = '',
    this.indonesia = '',
    this.matek = '',
    this.ipa = '',
    this.ips = '',
    this.sbk = '',
    this.pjok = '',
    this.sunda = '',
    this.karawitan = '',
    this.inggris = '',
    this.sikap = '',
    this.kerajinan = '',
    this.kebersihan = '',
    this.izin = '',
    this.sakit = '',
    this.tanpa = '',
    this.catatan = '',
  });

  Rapor copyWith({
    //identitas
    String? id,
    String? nama,
    String? nisn,
    String? kls,
    String? smstr,
    String? thn,
    //nilai
    String? agama,
    String? pkn,
    String? indonesia,
    String? matek,
    String? ipa,
    String? ips,
    String? sbk,
    String? pjok,
    String? sunda,
    String? karawitan,
    String? inggris,
    //kepribadian
    String? sikap,
    String? kerajinan,
    String? kebersihan,
    String? izin,
    String? sakit,
    String? tanpa,
    String? catatan,
  }) {
    return Rapor(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      nisn: nisn ?? this.nisn,
      kls: kls ?? this.kls,
      smstr: smstr ?? this.smstr,
      thn: thn ?? this.thn,
      agama: agama ?? this.agama,
      pkn: pkn ?? this.pkn,
      indonesia: indonesia ?? this.indonesia,
      matek: matek ?? this.matek,
      ipa: ipa ?? this.ipa,
      ips: ips ?? this.ips,
      sbk: sbk ?? this.sbk,
      pjok: pjok ?? this.pjok,
      sunda: sunda ?? this.sunda,
      karawitan: karawitan ?? this.karawitan,
      inggris: inggris ?? this.inggris,
      sikap: sikap ?? this.sikap,
      kerajinan: kerajinan ?? this.kerajinan,
      kebersihan: kebersihan ?? this.kebersihan,
      izin: izin ?? this.izin,
      sakit: sakit ?? this.sakit,
      tanpa: tanpa ?? this.tanpa,
      catatan: catatan ?? this.catatan,
    );
  }
}
