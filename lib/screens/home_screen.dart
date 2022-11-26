import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_rapor_sd/screens/list_rapor.dart';
import 'package:skripsi_rapor_sd/screens/pages/petunjuk_pages/petunjuk_admin.dart';
import 'package:skripsi_rapor_sd/screens/pages/petunjuk_pages/petunjuk_guru.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_dua.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_empat.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_enam.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_lima.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_satu.dart';
import 'package:skripsi_rapor_sd/screens/pages/rapor_pages/rapor_tiga.dart';
import 'package:skripsi_rapor_sd/screens/rapor_admin_screen.dart';
import 'package:skripsi_rapor_sd/widgets/card_widget.dart';
import 'package:skripsi_rapor_sd/screens/pages/kelas_screen.dart';
import 'package:skripsi_rapor_sd/screens/pages/mapel_screen.dart';
import 'package:skripsi_rapor_sd/screens/pages/profil_screen.dart';
import 'package:skripsi_rapor_sd/screens/pages/settings.dart';
import 'package:skripsi_rapor_sd/screens/pages/student_screen.dart';
import 'package:skripsi_rapor_sd/screens/pages/teacher_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    getUser() async {
      var role = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .snapshots()
          .first;
      return role;
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                image: AssetImage('assets/images/top_header.png'),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    height: 75,
                    margin: const EdgeInsets.only(bottom: 20, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Lottie.asset(
                          'assets/lottie/study.json',
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SDN 2 Winduherang',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Kabupaten Kuningan',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      children: [
                        WidgetCard(
                          svg: 'assets/images/class.svg',
                          text: 'Daftar Kelas',
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const KelasScreen()));
                          },
                        ),
                        WidgetCard(
                          svg: 'assets/images/student.svg',
                          text: 'Daftar Siswa',
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StudentScreen()));
                          },
                        ),
                        WidgetCard(
                          svg: 'assets/images/books.svg',
                          text: 'Daftar Mapel',
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapelScreen()));
                          },
                        ),
                        WidgetCard(
                          svg: 'assets/images/teacher.svg',
                          text: 'Daftar Guru',
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TeacherScreen()));
                          },
                        ),
                        WidgetCard(
                          svg: 'assets/images/school.svg',
                          text: 'Profil Sekolah',
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfilSklh()));
                          },
                        ),
                        WidgetCard(
                          svg: 'assets/images/settings.svg',
                          text: 'Pengaturan',
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen()));
                          },
                        ),
                      ],
                      crossAxisCount: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: FutureBuilder(
                        future: getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          var data = snapshot.data as QuerySnapshot;
                          var level = (data.docs[0]['level']);
                          var status = (data.docs[0])['status'];
                          if (snapshot.hasData) {
                            if (level == 'Guru') {
                              if (status == 'Guru Kelas Satu' ||
                                  status == 'Guru Kelas 1') {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  const RaporSatu()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.school),
                                        Text(' Rapor Siswa',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (status == 'Guru Kelas Dua' ||
                                  status == 'Guru Kelas 2') {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  const RaporDua()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.school),
                                        Text(' Rapor Siswa',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (status == 'Guru Kelas Tiga' ||
                                  status == 'Guru Kelas 3') {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  const RaporTiga()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.school),
                                        Text(' Rapor Siswa',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (status == 'Guru Kelas Empat' ||
                                  status == 'Guru Kelas 4') {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  const RaporEmpat()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.school),
                                        Text(' Rapor Siswa',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (status == 'Guru Kelas Lima' ||
                                  status == 'Guru Kelas 5') {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  const RaporLima()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.school),
                                        Text(' Rapor Siswa',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (status == 'Guru Kelas Enam' ||
                                  status == 'Guru Kelas 6') {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  const RaporEnam()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.school),
                                        Text(' Rapor Siswa',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  const AdminRaporScreen()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.school),
                                        Text(' Rapor Siswa',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else if (level == 'Siswa') {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const ListRapor()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.school),
                                      Text(' Lihat Nilai Rapor',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16)),
                                    ],
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.cyan,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const AdminRaporScreen()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.school),
                                      Text(' Rapor Siswa',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16)),
                                    ],
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.cyan,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              );
                            }
                          } else {
                            return Container();
                          }
                        }),
                  ),
                  SizedBox(
                      child: FutureBuilder(
                    future: getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var data = snapshot.data as QuerySnapshot;
                      var level = (data.docs[0]['level']);
                      if (snapshot.hasData) {
                        if (level == 'Guru') {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) =>
                                        const PetunjukGuru()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.live_help),
                                  Text(
                                    ' Petunjuk Aplikasi',
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                ],
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          );
                        } else if (level == 'Admin') {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) =>
                                        const PetunjukAdmin()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.live_help),
                                  Text(
                                    ' Petunjuk Aplikasi',
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                ],
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.live_help),
                                  Text(
                                    ' Petunjuk Aplikasi',
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                ],
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        return const SizedBox();
                      }
                    },
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
