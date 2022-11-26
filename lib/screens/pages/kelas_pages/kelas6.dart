import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class KelasNam extends StatefulWidget {
  const KelasNam({Key? key}) : super(key: key);

  @override
  State<KelasNam> createState() => _KelasNamState();
}

class _KelasNamState extends State<KelasNam> {
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

    var _firebase = FirebaseFirestore.instance;
    var _editUsername = TextEditingController();
    var _editNisn = TextEditingController();
    var _editKls = TextEditingController();

    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Kelas 6',
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
                    .orderBy('username')
                    .where('kelas', isEqualTo: 'Kelas 6')
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
                            onTap: () {
                              _editUsername.text =
                                  documents[index]['username'].toString();
                              _editNisn.text =
                                  documents[index]['nisn'].toString();
                              _editKls.text =
                                  documents[index]['kelas'].toString();
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Data Siswa',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.lightBlue,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                TextFormField(
                                                  controller: _editUsername,
                                                  maxLines: 2,
                                                  decoration: InputDecoration(
                                                    labelText: 'Nama Siswa',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .lightBlue),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'NISN',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .lightBlue),
                                                    ),
                                                  ),
                                                  controller: _editNisn,
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Kelas',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .lightBlue),
                                                    ),
                                                  ),
                                                  controller: _editKls,
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                              ],
                                            )),
                                      ),
                                    );
                                  });
                            },
                            leading: SizedBox(
                              child: FutureBuilder(
                                  future: getUser(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    var data = snapshot.data as QuerySnapshot;
                                    var level = (data.docs[0]['level']);
                                    if (snapshot.hasData) {
                                      if (level == 'Admin') {
                                        return InkWell(
                                          onTap: () {
                                            _editUsername.text =
                                                documents[index]['username']
                                                    .toString();
                                            _editNisn.text = documents[index]
                                                    ['nisn']
                                                .toString();
                                            _editKls.text = documents[index]
                                                    ['kelas']
                                                .toString();
                                            showModalBottomSheet(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        20))),
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return SingleChildScrollView(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'Ubah Data Siswa',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .lightBlue,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  _editUsername,
                                                              maxLines: 2,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Nama Siswa',
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.lightBlue),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            TextFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'NISN',
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.lightBlue),
                                                                ),
                                                              ),
                                                              controller:
                                                                  _editNisn,
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            TextFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Kelas',
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.lightBlue),
                                                                ),
                                                              ),
                                                              controller:
                                                                  _editKls,
                                                            ),
                                                            const SizedBox(
                                                              height: 40,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    _firebase
                                                                        .collection(
                                                                            'users')
                                                                        .doc(documents[index]
                                                                            .id)
                                                                        .delete();
                                                                    Navigator.pop(
                                                                        context);
                                                                    var message =
                                                                        'Data Berhasil Dihapus';
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .clearSnackBars();
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          message,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.poppins(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    ' Hapus ',
                                                                    style: GoogleFonts
                                                                        .poppins(),
                                                                  ),
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .redAccent,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 30,
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    _firebase
                                                                        .collection(
                                                                            'users')
                                                                        .doc(documents[index]
                                                                            .id)
                                                                        .update({
                                                                      'username':
                                                                          _editUsername
                                                                              .text,
                                                                      'nisn': _editNisn
                                                                          .text,
                                                                      'kelas':
                                                                          _editKls
                                                                              .text,
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                    var message =
                                                                        'Data Berhasil Diubah';
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .clearSnackBars();
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          message,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.poppins(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    ' Simpan ',
                                                                    style: GoogleFonts
                                                                        .poppins(),
                                                                  ),
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .lightBlue,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fitWidth,
                                                image: AssetImage(
                                                    'assets/images/murid.png'),
                                              ),
                                            ),
                                          ),
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
                            title: Text(documents[index]['username'],
                                style: GoogleFonts.poppins()),
                            subtitle: documents[index]['nisn'] == null
                                ? null
                                : Text(documents[index]['nisn'],
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
