import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/screens/pages/kelas_pages/kelas1.dart';
import 'package:skripsi_rapor_sd/screens/pages/kelas_pages/kelas3.dart';
import 'package:skripsi_rapor_sd/screens/pages/kelas_pages/kelas4.dart';
import 'package:skripsi_rapor_sd/screens/pages/kelas_pages/kelas5.dart';
import 'package:skripsi_rapor_sd/screens/pages/kelas_pages/kelas6.dart';
import 'package:skripsi_rapor_sd/widgets/kelas_widget.dart';

import 'kelas_pages/kelas2.dart';

class KelasScreen extends StatefulWidget {
  const KelasScreen({Key? key}) : super(key: key);

  @override
  State<KelasScreen> createState() => _KelasScreenState();
}

class _KelasScreenState extends State<KelasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Daftar Kelas',
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
                  text: 'Kelas 1',
                  img: 'assets/images/classroom.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelasSatu()));
                  },
                ),
                WidgetKelas(
                  text: 'Kelas 2',
                  img: 'assets/images/classroom.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelasDua()));
                  },
                ),
                WidgetKelas(
                  text: 'Kelas 3',
                  img: 'assets/images/classroom.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelasTiga()));
                  },
                ),
                WidgetKelas(
                  text: 'Kelas 4',
                  img: 'assets/images/classroom.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelasMpat()));
                  },
                ),
                WidgetKelas(
                  text: 'Kelas 5',
                  img: 'assets/images/classroom.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelasLima()));
                  },
                ),
                WidgetKelas(
                  text: 'Kelas 6',
                  img: 'assets/images/classroom.png',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelasNam()));
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
