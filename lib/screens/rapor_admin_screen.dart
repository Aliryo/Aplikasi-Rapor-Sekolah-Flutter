import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_dua.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_empat.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_enam.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_lima.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_satu.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_tiga.dart';
import 'package:skripsi_rapor_sd/screens/statistik.dart';
import 'package:skripsi_rapor_sd/widgets/kelas_widget.dart';

class AdminRaporScreen extends StatelessWidget {
  const AdminRaporScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Daftar Rapor',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                WidgetKelas(
                  text: 'Rapor Kelas 1',
                  img: 'assets/images/rapor.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RaporSatu()));
                  },
                ),
                WidgetKelas(
                  text: 'Rapor Kelas 2',
                  img: 'assets/images/rapor.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RaporDua()));
                  },
                ),
                WidgetKelas(
                  text: 'Rapor Kelas 3',
                  img: 'assets/images/rapor.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RaporTiga()));
                  },
                ),
                WidgetKelas(
                  text: 'Rapor Kelas 4',
                  img: 'assets/images/rapor.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RaporEmpat()));
                  },
                ),
                WidgetKelas(
                  text: 'Rapor Kelas 5',
                  img: 'assets/images/rapor.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RaporLima()));
                  },
                ),
                WidgetKelas(
                  text: 'Rapor Kelas 6',
                  img: 'assets/images/rapor.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RaporEnam()));
                  },
                ),
                WidgetKelas(
                  text: 'Lihat Statistik Rapor',
                  img: 'assets/images/statistik.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Statistik()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
