import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/models/rapor.dart';
import 'package:skripsi_rapor_sd/screens/output_rapor.dart';
import 'package:skripsi_rapor_sd/services/database_service.dart';

class ListRapor extends StatefulWidget {
  const ListRapor({Key? key}) : super(key: key);

  @override
  State<ListRapor> createState() => _ListRaporState();
}

class _ListRaporState extends State<ListRapor> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: const Text(
            'Daftar Nilai Rapor',
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
                child: FutureBuilder(
                  future: DatabaseService().rapor(),
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
                                leading: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image:
                                          AssetImage('assets/images/murid.png'),
                                    ),
                                  ),
                                ),
                                title: Text(raporList[index].nama,
                                    style: GoogleFonts.poppins()),
                                subtitle: Text(
                                    'Kls: ' +
                                        raporList[index].kls +
                                        '| Smstr: ' +
                                        raporList[index].smstr,
                                    style: GoogleFonts.poppins(fontSize: 13)),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Text(
                          'Tidak Ada Data',
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
