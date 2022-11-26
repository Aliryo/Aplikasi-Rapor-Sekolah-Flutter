import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ProfilSD extends StatelessWidget {
  const ProfilSD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'SDN 2 Winduherang',
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
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identitas Sekolah',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text('NPSN:  20213103',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('Nama Sekolah:  SD Negeri 2 Winduherang',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('Alamat:  Jln. Ramajaksa No. 299',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('Desa:  Winduherang',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('Kode Pos:  45552',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('Email:  sdnegeri2winduherang@gmail.com',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('Website:  sdn2winduherang.blogspot.com',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('SK Izin Operasional:  INPRES No.4/1982 & No.07',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('Tanggal SK:  16/5/1983',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('Akreditasi:  B',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 6,
            ),
            Text('No SK Akreditasi:  02.00/110/BAP-SM/SK/X/2015',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }
}
