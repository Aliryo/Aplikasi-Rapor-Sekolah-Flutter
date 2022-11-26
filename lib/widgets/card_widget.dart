import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetCard extends StatelessWidget {
  final String svg;
  final String text;
  final Function() ontap;
  const WidgetCard({
    Key? key,
    required this.svg,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: SvgPicture.asset(
              svg,
              height: 130,
            ),
            subtitle: Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            onTap: ontap,
          ),
        ],
      ),
    );
  }
}
