import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/screens/pages/addUser_pages/add_auth_form.dart';

class AddAuthScreen extends StatefulWidget {
  const AddAuthScreen({Key? key}) : super(key: key);

  @override
  State<AddAuthScreen> createState() => _AddAuthScreenState();
}

class _AddAuthScreenState extends State<AddAuthScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  void submitAuthForm({
    required String email,
    required String username,
    required String status,
    required String password,
    required String level,
  }) async {
    try {
      UserCredential userCredential;
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        await _firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': username,
          'email': email,
          'status': status,
          'password': password,
          'level': level,
        });
      }
    } on FirebaseAuthException {
      var message =
          'Email atau Password Salah\nMohon Periksa Kembali Data Anda';
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Tambah Akun',
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
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AddAuthForm(
              submitAuthFormFn: submitAuthForm,
            )),
      ),
    );
  }
}
