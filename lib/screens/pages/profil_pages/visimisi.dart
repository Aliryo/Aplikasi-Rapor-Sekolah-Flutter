import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class VisiMisi extends StatelessWidget {
  const VisiMisi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Visi dan Misi',
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
        children: [
          Container(
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
                  'A. Visi',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Unggul dalam prestasi, maju dalam ilmu pengetahuan dan teknologi, serta memiliki pribadi yang berbudaya dan berindaskan Iman dan Taqwa.',
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'B. Misi',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '1. Meningkatkan Profesionalisme pelayanan pendidikan yang dilandasi rasa tanggung jawab dan kekiasan.',
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  '2. Meningkatkan kualitas pembelajaran dengan menciptakan suasana pembelajaran yang aktif, inovatif, kreatif, efektif dan menyenangkan (PAIKEM).',
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  '3. Menanamkan dan memupuk perilaku jujur dan disiplin.',
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  '4. Menciptakan suasana lingkungan sekolah yang nyaman dan kondusif.',
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  '5. Mengoptimalkan pembiasaan dalam memelihara kebersihan lingkungan.',
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  '6. Memberikan pelayanan yang optimal dalam menanamkan dasar - dasar agama.',
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
