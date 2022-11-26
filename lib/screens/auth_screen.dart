import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_rapor_sd/screens/success_page.dart';
import 'package:skripsi_rapor_sd/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  void submitAuthForm(
      {required String email,
      required String username,
      required String password,
      required String nisn,
      required String kelas,
      required String level,
      required String status,
      required bool isLogin}) async {
    try {
      UserCredential userCredential;
      if (isLogin) {
        userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        //login
      } else {
        userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (userCredential.user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'username': username,
            'email': email,
            'password': password,
            'nisn': nisn,
            'kelas': kelas,
            'level': level,
            'status': status,
          });
        }
        //daftar
      }
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SuccessLogin()),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      var message = e.message ?? 'Mohon Periksa Kembali Data Anda';
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 8,
              actionsPadding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              title: Text(
                'Peringatan',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(),
              ),
              content: Text(
                message,
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Kembali',
                      style: GoogleFonts.poppins(),
                    ))
              ],
            );
          });
      // ScaffoldMessenger.of(context).clearSnackBars();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       message,
      //       textAlign: TextAlign.center,
      //       style: GoogleFonts.poppins(),
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Text(
                    'Digitalisasi Sekolah Pengembangan\nAplikasi Mobile',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AuthForm(
                    submitAuthFormFn: submitAuthForm,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
