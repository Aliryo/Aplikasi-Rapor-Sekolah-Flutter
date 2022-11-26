import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/models/mapel.dart';
import 'package:skripsi_rapor_sd/screens/success_rapor_page.dart';
import 'package:skripsi_rapor_sd/services/mapel_database_service.dart';
import 'package:skripsi_rapor_sd/widgets/button_widget.dart';

class EditMapel extends StatefulWidget {
  const EditMapel({Key? key, required this.mapel}) : super(key: key);
  final Mapel mapel;

  @override
  State<EditMapel> createState() => _EditMapelState();
}

class _EditMapelState extends State<EditMapel> {
  Mapel _mapel = Mapel(
    id: '',
    title: '',
    guru: '',
    image: '',
    content: '',
  );

  final _mapelTitleController = TextEditingController();
  final _mapelGuruController = TextEditingController();
  final _mapelImageController = TextEditingController();
  final _mapelContentController = TextEditingController();

  @override
  void initState() {
    _mapel = widget.mapel;
    _mapelTitleController.text = _mapel.title;
    _mapelGuruController.text = _mapel.guru;
    _mapelImageController.text = _mapel.image;
    _mapelContentController.text = _mapel.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Ubah Mata Pelajaran',
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
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _mapelTitleController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _mapel = _mapel.copyWith(title: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _mapelGuruController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z,.]'))
                  ],
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Guru Mata Pelajaran',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _mapel = _mapel.copyWith(guru: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 3,
                  controller: _mapelImageController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _mapel = _mapel.copyWith(image: value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 7,
                  controller: _mapelContentController,
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Konten Mata Pelajaran',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _mapel = _mapel.copyWith(content: value);
                  },
                ),
              ],
            ),
          ),
          WidgetButton(
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            title: 'Simpan',
            onPressed: () {
              MapelDatabaseService().updateMapel(_mapel);
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
              MapelDatabaseService().deleteMapel(_mapel.id);
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
