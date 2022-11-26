import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/models/mapel.dart';
import 'package:skripsi_rapor_sd/screens/pages/edit_mapel.dart';
import 'package:skripsi_rapor_sd/screens/pages/mapel_detail_screen.dart';
import 'package:skripsi_rapor_sd/services/mapel_database_service.dart';
import 'package:skripsi_rapor_sd/widgets/new_mapel.dart';

class MapelScreen extends StatefulWidget {
  const MapelScreen({Key? key}) : super(key: key);

  @override
  State<MapelScreen> createState() => _MapelScreenState();
}

class _MapelScreenState extends State<MapelScreen> {
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
            'Daftar Mata Pelajaran',
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
                    stream: MapelDatabaseService().mapel,
                    builder: (ctx, AsyncSnapshot<List<Mapel>> mapelSnapshot) {
                      if (mapelSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (mapelSnapshot.hasError) {
                        return Center(
                          child: Text(mapelSnapshot.error.toString()),
                        );
                      }

                      if (mapelSnapshot.data != null) {
                        final mapelList = mapelSnapshot.data as List<Mapel>;
                        return ListView.builder(
                            itemCount: mapelList.length,
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
                                            builder: (context) => MapelDetail(
                                                  mapel: mapelList[index],
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
                                          var level = (data.docs[0]['level']);
                                          if (snapshot.hasData) {
                                            if (level == 'Admin') {
                                              return IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (builder) =>
                                                            EditMapel(
                                                                mapel:
                                                                    mapelList[
                                                                        index]),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.settings));
                                            } else {
                                              return Container(
                                                width: 60,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                    filterQuality:
                                                        FilterQuality.low,
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        mapelList[index].image),
                                                  ),
                                                ),
                                              );
                                            }
                                          } else {
                                            return Container();
                                          }
                                        }),
                                  ),
                                  title: Text(mapelList[index].title,
                                      style: GoogleFonts.poppins()),
                                  subtitle: Text(mapelList[index].guru,
                                      style: GoogleFonts.poppins()),
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
                      var level = (data.docs[0]['level']);
                      if (snapshot.hasData) {
                        if (level == 'Admin') {
                          return const NewMapel();
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
