import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetNilai extends StatelessWidget {
  final String title;
  final String valueText;
  final Color valueColor;
  const WidgetNilai({
    Key? key,
    required this.title,
    required this.valueText,
    required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/images/icon_check.png'),
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            valueText,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
