import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLocationBar extends StatefulWidget {
  const MyLocationBar({super.key});

  @override
  State<MyLocationBar> createState() => _MyLocationBarState();
}

class _MyLocationBarState extends State<MyLocationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: Colors.orange[500],
      ),
      child: Row(
        spacing: 4,
        children: [
          const SizedBox(
            width: 23,
          ),
          Icon(
            Icons.pin_drop,
            color: Colors.white,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text("Desi Cuppa Cafe, Thrissur",
                style: GoogleFonts.varelaRound(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
