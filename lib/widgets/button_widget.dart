import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color color;
  final Function() onPressed;
  final EdgeInsets margin;
  const WidgetButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    this.height = 55,
    this.color = Colors.lightBlue,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
