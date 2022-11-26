import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Daftar Siswa',
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
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .orderBy('kelas')
                    .orderBy('username')
                    .where('level', isEqualTo: 'Siswa')
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> siswaSnapshot) {
                  if (siswaSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (siswaSnapshot.hasError) {
                    return Center(
                      child: Text(siswaSnapshot.error.toString()),
                    );
                  }

                  if (siswaSnapshot.data != null) {
                    final documents = siswaSnapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () {},
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage('assets/images/murid.png'),
                                ),
                              ),
                            ),
                            title: Text(documents[index]['username'],
                                style: GoogleFonts.poppins()),
                            subtitle: documents[index]['kelas'] == null
                                ? null
                                : Text(documents[index]['kelas'],
                                    style: GoogleFonts.poppins()),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Tidak Ada Data'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
