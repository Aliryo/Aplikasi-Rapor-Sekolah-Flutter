import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_rapor_sd/services/database_service.dart';

class NewRapor extends StatefulWidget {
  const NewRapor({Key? key}) : super(key: key);

  @override
  State<NewRapor> createState() => _NewRaporState();
}

class _NewRaporState extends State<NewRapor> {
  String _raporNama = '';
  final _raporNamaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _raporNamaController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
              ],
              decoration: InputDecoration(
                hintText: 'Tambah Nama Rapor',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
              style: GoogleFonts.poppins(),
              onChanged: (value) {
                setState(() {
                  _raporNama = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: _raporNama.isEmpty
                ? null
                : () {
                    DatabaseService().addNewRapor(_raporNama);
                    _raporNamaController.text = '';
                  },
            child: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
