import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/models/rapor.dart';
import 'package:skripsi_rapor_sd/screens/success_rapor_page.dart';
import 'package:skripsi_rapor_sd/services/database_service.dart';
import '../widgets/button_widget.dart';

class InputRapor extends StatefulWidget {
  const InputRapor({Key? key, required this.rapor}) : super(key: key);
  final Rapor rapor;

  @override
  State<InputRapor> createState() => _InputRaporState();
}

class _InputRaporState extends State<InputRapor> {
  Rapor _rapor = Rapor(
    id: '',
    nama: '',
    nisn: '',
    kls: '',
    smstr: '',
    thn: '',
  );
  final _raporNamaController = TextEditingController();
  final _raporNisController = TextEditingController();
  final _raporThnController = TextEditingController();
  String? smstr = '';
  final _nilaiAgamaController = TextEditingController();
  final _nilaiPknController = TextEditingController();
  final _nilaiIndoController = TextEditingController();
  final _nilaiMatekController = TextEditingController();
  final _nilaiIpaController = TextEditingController();
  final _nilaiIpsController = TextEditingController();
  final _nilaiSbkController = TextEditingController();
  final _nilaiPjokController = TextEditingController();
  final _nilaiSundaController = TextEditingController();
  final _nilaiInggrisController = TextEditingController();
  final _nilaiKarawitanController = TextEditingController();
  final _nilaiSikapController = TextEditingController();
  final _nilaiKerajinanController = TextEditingController();
  final _nilaiKebersihanController = TextEditingController();
  final _jumlahIzinController = TextEditingController();
  final _jumlahSakitController = TextEditingController();
  final _jumlahTanpaController = TextEditingController();
  final _catatanController = TextEditingController();

  @override
  void initState() {
    _rapor = widget.rapor;
    _raporNamaController.text = _rapor.nama;
    _raporNisController.text = _rapor.nisn;
    _raporThnController.text = _rapor.thn;
    smstr = _rapor.smstr;
    _nilaiAgamaController.text = _rapor.agama;
    _nilaiPknController.text = _rapor.pkn;
    _nilaiIndoController.text = _rapor.indonesia;
    _nilaiMatekController.text = _rapor.matek;
    _nilaiIpaController.text = _rapor.ipa;
    _nilaiIpsController.text = _rapor.ips;
    _nilaiSbkController.text = _rapor.sbk;
    _nilaiPjokController.text = _rapor.pjok;
    _nilaiSundaController.text = _rapor.sunda;
    _nilaiInggrisController.text = _rapor.inggris;
    _nilaiKarawitanController.text = _rapor.karawitan;
    _nilaiSikapController.text = _rapor.sikap;
    _nilaiKerajinanController.text = _rapor.kerajinan;
    _nilaiKebersihanController.text = _rapor.kebersihan;
    _jumlahIzinController.text = _rapor.izin;
    _jumlahSakitController.text = _rapor.sakit;
    _jumlahTanpaController.text = _rapor.tanpa;
    _catatanController.text = _rapor.catatan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Form Isi Nilai Rapor',
          style: TextStyle(fontFamily: 'Montserrat Medium'),
        ),
        gradient: const LinearGradient(
            colors: [Colors.green, Colors.cyan, Colors.blue]),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Container(
              width: 300,
              height: 100,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.high,
                  image: AssetImage('assets/images/toprapor.png'),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Biodata Siswa',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _raporThnController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9 /]'))
                  ],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Tahun Ajaran',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(thn: value);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _raporNamaController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                  ],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(nama: value);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  maxLength: 10,
                  controller: _raporNisController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Nomor Induk Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(nisn: value);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Semester:',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: 10,
                        child: Radio(
                          value: '1 (Satu)',
                          groupValue: smstr,
                          activeColor: Colors.blueAccent,
                          onChanged: (value) {
                            setState(() {
                              smstr = value as String?;
                              _rapor = _rapor.copyWith(smstr: value);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '1 (Satu)',
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                        width: 10,
                        child: Radio(
                          value: '2 (Dua)',
                          groupValue: smstr,
                          activeColor: Colors.blueAccent,
                          onChanged: (value) {
                            setState(() {
                              smstr = value as String?;
                              _rapor = _rapor.copyWith(smstr: value);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '2 (Dua)',
                        style: GoogleFonts.poppins(),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mata Pelajaran',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiAgamaController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Pendidikan Agama',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(agama: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiPknController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Pendidikan Kewarnegaraan',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(pkn: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiIndoController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Bahasa Indonesia',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(indonesia: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiMatekController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Matematika',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(matek: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiIpaController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Ilmu Pengetahuan Alam',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(ipa: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiIpsController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Ilmu Pengetahuan Sosial',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(ips: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiSbkController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Seni Budaya dan Keterampilan',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(sbk: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiPjokController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Pendidikan Jasmani, Olahraga dan Kesehatan',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(pjok: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Muatan Lokal',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiSundaController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Bahasa dan Sastra Sunda',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(sunda: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiInggrisController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Bahasa Inggris',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(inggris: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _nilaiKarawitanController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Karawitan',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(karawitan: value);
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kepribadian',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _nilaiSikapController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                  ],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Sikap',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(sikap: value);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _nilaiKerajinanController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                  ],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Kerajinan',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(kerajinan: value);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _nilaiKebersihanController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                  ],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Kebersihan dan Kerapihan',
                    hintText: 'Masukkan Nilai Siswa',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(kebersihan: value);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Ketidakhadiran',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _jumlahIzinController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Izin',
                    hintText: 'Masukkan Jumlah',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(izin: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _jumlahSakitController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Sakit',
                    hintText: 'Masukkan Jumlah',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(sakit: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _jumlahTanpaController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Tanpa Keterangan',
                    hintText: 'Masukkan Jumlah',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(tanpa: value);
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catatan',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _catatanController,
                  decoration: const InputDecoration(
                    hintText: 'Catatan Untuk Siswa',
                  ),
                  maxLines: 4,
                  style: GoogleFonts.poppins(),
                  onChanged: (value) {
                    _rapor = _rapor.copyWith(catatan: value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          WidgetButton(
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            title: 'Simpan',
            onPressed: () {
              DatabaseService().updateRapor(_rapor);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RaporSuccessInput()),
                  (route) => false);
            },
          ),
          WidgetButton(
            color: Colors.redAccent,
            margin: const EdgeInsets.only(top: 15, bottom: 10),
            title: 'Hapus',
            onPressed: () {
              DatabaseService().deleteRapor(_rapor.id);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RaporSuccessInput()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
