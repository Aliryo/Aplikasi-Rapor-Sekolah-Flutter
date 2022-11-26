import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_rapor_sd/services/mapel_database_service.dart';

class NewMapel extends StatefulWidget {
  const NewMapel({Key? key}) : super(key: key);

  @override
  State<NewMapel> createState() => _NewMapelState();
}

class _NewMapelState extends State<NewMapel> {
  String _mapelTitle = '';
  final _mapelTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _mapelTitleController,
              decoration: InputDecoration(
                hintText: 'Tambah Mapel Baru',
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
                  _mapelTitle = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: _mapelTitle.isEmpty
                ? null
                : () {
                    MapelDatabaseService().addNewMapel(_mapelTitle);
                    _mapelTitleController.text = '';
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
