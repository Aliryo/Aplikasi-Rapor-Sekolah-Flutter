import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/models/rapor.dart';
import 'package:skripsi_rapor_sd/screens/input_rapor.dart';
import 'package:skripsi_rapor_sd/screens/output_rapor.dart';
import 'package:skripsi_rapor_sd/services/database_service.dart';
import 'package:skripsi_rapor_sd/widgets/newrapor/new_raporenam.dart';

class RaporEnam extends StatefulWidget {
  const RaporEnam({Key? key}) : super(key: key);

  @override
  State<RaporEnam> createState() => _RaporEnamState();
}

class _RaporEnamState extends State<RaporEnam> {
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: const Text(
            'Nilai Rapor Kelas 6',
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
          padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
          ),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: DatabaseService().raporEnam,
                    builder: (ctx, AsyncSnapshot<List<Rapor>> raporSnapshot) {
                      if (raporSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (raporSnapshot.hasError) {
                        return Center(
                          child: Text(raporSnapshot.error.toString()),
                        );
                      }

                      if (raporSnapshot.data != null) {
                        final raporList = raporSnapshot.data as List<Rapor>;
                        return ListView.builder(
                            itemCount: raporList.length,
                            itemBuilder: (ctx, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OutputRapor(
                                                  rapor: raporList[index],
                                                )));
                                  },
                                  leading: SizedBox(
                                    child: FutureBuilder(
                                        future: getUser(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          }
                                          var data =
                                              snapshot.data as QuerySnapshot;
                                          var status = (data.docs[0]['status']);
                                          if (snapshot.hasData) {
                                            if (status == 'Guru Kelas Enam' ||
                                                status == 'Guru Kelas 6') {
                                              return IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (builder) =>
                                                          InputRapor(
                                                              rapor: raporList[
                                                                  index]),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                    Icons.add_box_outlined),
                                              );
                                            } else {
                                              return Container(
                                                width: 60,
                                                height: 60,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fitWidth,
                                                    image: AssetImage(
                                                        'assets/images/murid.png'),
                                                  ),
                                                ),
                                              );
                                            }
                                          } else {
                                            return Container();
                                          }
                                        }),
                                  ),
                                  title: Text(raporList[index].nama,
                                      style: GoogleFonts.poppins()),
                                  subtitle: Text(
                                      'Semester: ' +
                                          raporList[index].smstr +
                                          ',  ' +
                                          raporList[index].thn,
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: Text('Tidak Ada Data'),
                        );
                      }
                    }),
              ),
              SizedBox(
                child: FutureBuilder(
                    future: getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: SizedBox());
                      }
                      var data = snapshot.data as QuerySnapshot;
                      var status = (data.docs[0]['status']);
                      if (snapshot.hasData) {
                        if (status == 'Guru Kelas Enam' ||
                            status == 'Guru Kelas 6') {
                          return const NewRaporEnam();
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
