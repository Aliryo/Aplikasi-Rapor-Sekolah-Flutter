// ignore_for_file: unused_local_variable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
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

    final _formKey = GlobalKey<FormState>();
    var _firebase = FirebaseFirestore.instance;
    var _editUsername = TextEditingController();
    var _editStatus = TextEditingController();

    String _username = '';
    String _status = '';

    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Daftar Guru',
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
                    .where('level', isEqualTo: 'Guru')
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> guruSnapshot) {
                  if (guruSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (guruSnapshot.hasError) {
                    return Center(
                      child: Text(guruSnapshot.error.toString()),
                    );
                  }

                  if (guruSnapshot.data != null) {
                    final documents = guruSnapshot.data!.docs;
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
                                _editStatus.text =
                                    documents[index]['status'].toString();
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
                                                  'Data Guru',
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
                                                    labelText: 'Nama Guru',
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
                                                    labelText:
                                                        'Status / Jabatan',
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
                                                  controller: _editStatus,
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                              ],
                                            ),
                                          ),
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
                                              _editStatus.text =
                                                  documents[index]['status']
                                                      .toString();
                                              showModalBottomSheet(
                                                  shape: const RoundedRectangleBorder(
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
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  'Ubah Data Guru',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: Colors
                                                                        .lightBlue,
                                                                    fontSize:
                                                                        18,
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
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            '[a-z A-Z,.]'))
                                                                  ],
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty ||
                                                                        value.length <
                                                                            4) {
                                                                      return 'Nama Lengkap Minimal 4 Karakter';
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved:
                                                                      (value) {
                                                                    _username =
                                                                        value ??
                                                                            '';
                                                                  },
                                                                  maxLines: 2,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Nama Guru',
                                                                    border:
                                                                        OutlineInputBorder(
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
                                                                              color: Colors.lightBlue),
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
                                                                        'Status / Jabatan',
                                                                    border:
                                                                        OutlineInputBorder(
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
                                                                              color: Colors.lightBlue),
                                                                    ),
                                                                  ),
                                                                  controller:
                                                                      _editStatus,
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Masukkan Status / Jabatan';
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved:
                                                                      (value) {
                                                                    _status =
                                                                        value ??
                                                                            '';
                                                                  },
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
                                                                            .collection('users')
                                                                            .doc(documents[index].id)
                                                                            .delete();
                                                                        Navigator.pop(
                                                                            context);
                                                                        var message =
                                                                            'Data Berhasil Dihapus';
                                                                        ScaffoldMessenger.of(context)
                                                                            .clearSnackBars();
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              message,
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.poppins(),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        ' Hapus ',
                                                                        style: GoogleFonts
                                                                            .poppins(),
                                                                      ),
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.redAccent,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 30,
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (_formKey.currentState !=
                                                                            null) {
                                                                          if (_formKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                            _formKey.currentState!.save();
                                                                            _firebase.collection('users').doc(documents[index].id).update({
                                                                              'username': _editUsername.text,
                                                                              'status': _editStatus.text,
                                                                            });
                                                                            Navigator.pop(context);
                                                                            var message =
                                                                                'Data Berhasil Diubah';
                                                                            ScaffoldMessenger.of(context).clearSnackBars();
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  message,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: GoogleFonts.poppins(),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        ' Simpan ',
                                                                        style: GoogleFonts
                                                                            .poppins(),
                                                                      ),
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.lightBlue,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 60,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: AssetImage(
                                                      'assets/images/guru.png'),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            width: 50,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fitWidth,
                                                image: AssetImage(
                                                    'assets/images/guru.png'),
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
                              subtitle: documents[index]['status'] == null
                                  ? null
                                  : Text(documents[index]['status'],
                                      style: GoogleFonts.poppins()),
                            ));
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
