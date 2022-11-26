import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_rapor_sd/screens/home_screen.dart';

class RaporSuccessInput extends StatefulWidget {
  const RaporSuccessInput({Key? key}) : super(key: key);

  @override
  State<RaporSuccessInput> createState() => _RaporSuccessInputState();
}

class _RaporSuccessInputState extends State<RaporSuccessInput> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 400,
              margin: const EdgeInsets.only(bottom: 20),
              child: Lottie.asset('assets/lottie/successful.json'),
            ),
            Center(
              child: Text(
                'Berhasil 😍',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
