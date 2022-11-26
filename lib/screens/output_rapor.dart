import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skripsi_rapor_sd/models/rapor.dart';
import 'package:skripsi_rapor_sd/widgets/nilai_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OutputRapor extends StatefulWidget {
  const OutputRapor({Key? key, required this.rapor}) : super(key: key);
  final Rapor rapor;

  @override
  State<OutputRapor> createState() => _OutputRaporState();
}

class _OutputRaporState extends State<OutputRapor> {
  Rapor _rapor = Rapor(
    id: '',
    nama: '',
    nisn: '',
    kls: '',
    smstr: '',
    thn: '',
  );

  @override
  void initState() {
    _rapor = widget.rapor;
    super.initState();
  }

  void getPdf() async {
    var nilai1 = int.parse(_rapor.agama);
    var nilai2 = int.parse(_rapor.pkn);
    var nilai3 = int.parse(_rapor.indonesia);
    var nilai4 = int.parse(_rapor.matek);
    var nilai5 = int.parse(_rapor.ipa);
    var nilai6 = int.parse(_rapor.ips);
    var nilai7 = int.parse(_rapor.sbk);
    var nilai8 = int.parse(_rapor.pjok);
    var nilai9 = int.parse(_rapor.sunda);
    var nilai10 = int.parse(_rapor.inggris);
    var nilai11 = int.parse(_rapor.karawitan);
    var totalNilai = nilai1 +
        nilai2 +
        nilai3 +
        nilai4 +
        nilai5 +
        nilai6 +
        nilai7 +
        nilai8 +
        nilai9 +
        nilai10 +
        nilai11;

    final pdf = pw.Document();

    var dataImage = await rootBundle.load('assets/images/bgpdf.jpg');
    var myImage = dataImage.buffer.asUint8List();

    pdf.addPage(
      pw.MultiPage(
          pageFormat: const PdfPageFormat(595, 842),
          build: (pw.Context context) {
            return [
              pw.Stack(children: [
                pw.Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: pw.Image(
                    pw.MemoryImage(myImage),
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(40),
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.Container(
                            width: 320,
                            child: pw.Text(
                              'Nama Siswa: ' + _rapor.nama,
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: double.infinity,
                            child: pw.Text(
                              'Kelas: ' + _rapor.kls,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        pw.Row(children: [
                          pw.Container(
                            width: 320,
                            child: pw.Text(
                              'Nomor Induk: ' + _rapor.nisn.toString(),
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: double.infinity,
                            child: pw.Text(
                              'Semester: ' + _rapor.smstr,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        pw.Row(children: [
                          pw.Container(
                            width: 320,
                            child: pw.Text(
                              'Nama Sekolah: SDN 2 Winduherang',
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: double.infinity,
                            child: pw.Text(
                              'Tahun Ajaran: ' + _rapor.thn,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        pw.Text(
                          'Alamat Sekolah: Kel. Winduherang',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 30),
                        pw.Center(
                          child: pw.Column(children: [
                            pw.Container(
                              child: pw.Table(
                                  columnWidths: {
                                    0: const pw.IntrinsicColumnWidth(),
                                    1: const pw.IntrinsicColumnWidth(),
                                    2: const pw.IntrinsicColumnWidth(),
                                    3: const pw.IntrinsicColumnWidth(),
                                  },
                                  defaultVerticalAlignment:
                                      pw.TableCellVerticalAlignment.middle,
                                  border: pw.TableBorder.all(
                                    color: PdfColors.black,
                                    style: pw.BorderStyle.solid,
                                    width: 2,
                                  ),
                                  children: [
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          'No.',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text(
                                          'Mata Pelajaran',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text(
                                          'Nilai',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text(
                                          'KKM',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ])
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '1.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Pendidikan Agama'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.agama),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '2.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                '  Pendidikan Kewarnegaraan'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.pkn),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '3.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Bahasa Indonesia'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.indonesia),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '4.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Matematika'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.matek),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '5.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Ilmu Pengetahuan Alam'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.ipa),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '6.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                '  Ilmu Pengetahuan Sosial'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.ips),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '7.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                '  Seni Budaya dan Keterampilan'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.sbk),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '8.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                '  Pendidikan Jasmani Olahraga dan Kesehatan'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.pjok),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '9.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                '  Muatan Lokal:\n  Bahasa dan Sastra Sunda'),
                                            pw.Text('  Bahasa Inggris'),
                                            pw.Text('  Karawitan')
                                          ]),
                                      pw.Column(children: [
                                        pw.Text('\n' + _rapor.sunda),
                                        pw.Text(_rapor.inggris),
                                        pw.Text(_rapor.karawitan),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text('\n75'),
                                        pw.Text('75'),
                                        pw.Text('75'),
                                      ]),
                                    ]),
                                  ]),
                            ),
                          ]),
                        ),
                        pw.SizedBox(height: 30),
                        pw.Text(
                          'Jumlah Nilai Prestasi Hasil Belajar: ' +
                              totalNilai.toString(),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Center(
                          child: pw.Column(children: [
                            pw.Container(
                              child: pw.Table(
                                  columnWidths: {
                                    0: const pw.IntrinsicColumnWidth(),
                                    1: const pw.IntrinsicColumnWidth(),
                                    2: const pw.IntrinsicColumnWidth(),
                                    3: const pw.IntrinsicColumnWidth(),
                                    4: const pw.IntrinsicColumnWidth(),
                                  },
                                  defaultVerticalAlignment:
                                      pw.TableCellVerticalAlignment.middle,
                                  border: pw.TableBorder.all(
                                    color: PdfColors.black,
                                    style: pw.BorderStyle.solid,
                                    width: 2,
                                  ),
                                  children: [
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          'No.',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text(
                                          'Kepribadian',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text(
                                          'Nilai',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text(
                                          'Ketidakhadiran',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      pw.Column(children: [
                                        pw.Text(
                                          'Hari',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ])
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '1.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Sikap'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.sikap),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Izin'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.izin),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '2.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Kerajinan'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.kerajinan),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Sakit'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.sakit),
                                      ]),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.Text(
                                          '3.',
                                        ),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                '  Kebersihan dan Kerapian'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.kebersihan),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('  Tanpa Keterangan'),
                                          ]),
                                      pw.Column(children: [
                                        pw.Text(_rapor.tanpa),
                                      ]),
                                    ]),
                                  ]),
                            ),
                          ]),
                        ),
                        pw.SizedBox(height: 30),
                        pw.Center(
                          child: pw.Column(children: [
                            pw.Container(
                              child: pw.Table(
                                  border: pw.TableBorder.all(
                                    color: PdfColors.black,
                                    style: pw.BorderStyle.solid,
                                    width: 2,
                                  ),
                                  children: [
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.SizedBox(height: 8),
                                        pw.Text(
                                          'CATATAN',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        pw.SizedBox(height: 18),
                                        pw.Text(
                                          _rapor.catatan,
                                          maxLines: 3,
                                        ),
                                        pw.SizedBox(height: 8),
                                      ]),
                                    ]),
                                  ]),
                            ),
                          ]),
                        ),
                        pw.SizedBox(height: 40),
                        pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            'Winduherang,______________',
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 30),
                        pw.Container(
                            margin:
                                const pw.EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            child: pw.Row(children: [
                              pw.Column(children: [
                                pw.Text(
                                  'Orang Tua / Wali',
                                  style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 70),
                                pw.Text(
                                    '(......................................)'),
                              ]),
                              pw.Spacer(),
                              pw.Column(children: [
                                pw.Text(
                                  'Guru Kelas',
                                  style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 70),
                                pw.Text(
                                    '(......................................)'),
                              ]),
                            ])),
                      ]),
                ),
              ])
            ];
          }),
    );

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File(
        '${dir.path}/Rapor ${_rapor.nama} ${_rapor.kls} Smt${_rapor.smstr}.pdf');

    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    var nilai1 = int.parse(_rapor.agama);
    var nilai2 = int.parse(_rapor.pkn);
    var nilai3 = int.parse(_rapor.indonesia);
    var nilai4 = int.parse(_rapor.matek);
    var nilai5 = int.parse(_rapor.ipa);
    var nilai6 = int.parse(_rapor.ips);
    var nilai7 = int.parse(_rapor.sbk);
    var nilai8 = int.parse(_rapor.pjok);
    var nilai9 = int.parse(_rapor.sunda);
    var nilai10 = int.parse(_rapor.inggris);
    var nilai11 = int.parse(_rapor.karawitan);
    var totalNilai = nilai1 +
        nilai2 +
        nilai3 +
        nilai4 +
        nilai5 +
        nilai6 +
        nilai7 +
        nilai8 +
        nilai9 +
        nilai10 +
        nilai11;

    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Hasil Nilai Rapor',
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
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage('assets/images/murid.png'),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelas: ' + _rapor.kls,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Semester: ' + _rapor.smstr,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Tahun: ' + _rapor.thn,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _rapor.nama,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'NISN: ' + _rapor.nisn.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
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
                  'Nilai Rapor Siswa',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                WidgetNilai(
                  title: 'Pendidikan Agama',
                  valueText: _rapor.agama,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Pendididkan Kewarnegaraan',
                  valueText: _rapor.pkn,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Bahasa Indonesia',
                  valueText: _rapor.indonesia,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Matematika',
                  valueText: _rapor.matek,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Ilmu Pengetahuan Alam',
                  valueText: _rapor.ipa,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Ilmu Pengetahuan Sosial',
                  valueText: _rapor.ips,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Seni Budaya dan Keterampilan',
                  valueText: _rapor.sbk,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Pendidikan Jasmani, Olahraga dan Kesehatan',
                  valueText: _rapor.pjok,
                  valueColor: Colors.black,
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
                  'Muatan Lokal',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                WidgetNilai(
                  title: 'Bahasa dan Sastra Sunda',
                  valueText: _rapor.sunda,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Bahasa Inggris',
                  valueText: _rapor.inggris,
                  valueColor: Colors.black,
                ),
                WidgetNilai(
                  title: 'Karawitan',
                  valueText: _rapor.karawitan,
                  valueColor: Colors.black,
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
                WidgetNilai(
                  title: 'Sikap',
                  valueText: '"' + _rapor.sikap + '"',
                  valueColor: const Color(0xff0EC3AE),
                ),
                WidgetNilai(
                  title: 'Kerajinan',
                  valueText: '"' + _rapor.kerajinan + '"',
                  valueColor: const Color(0xff0EC3AE),
                ),
                WidgetNilai(
                  title: 'Kebersihan dan Kerapihan',
                  valueText: '"' + _rapor.kebersihan + '"',
                  valueColor: const Color(0xff0EC3AE),
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
                  'Ketidakhadiran',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                WidgetNilai(
                  title: 'Izin',
                  valueText: _rapor.izin,
                  valueColor: const Color(0xffEB70A5),
                ),
                WidgetNilai(
                  title: 'Sakit',
                  valueText: _rapor.sakit,
                  valueColor: const Color(0xffEB70A5),
                ),
                WidgetNilai(
                  title: 'Tanpa Keterangan',
                  valueText: _rapor.tanpa,
                  valueColor: const Color(0xffEB70A5),
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
                  height: 15,
                ),
                Text(
                  '"' +
                      _rapor.catatan +
                      '"' +
                      '\n\nTotal Nilai:  ' +
                      totalNilai.toString(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getPdf(),
        child: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
