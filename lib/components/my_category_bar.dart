import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCategoryBar extends StatefulWidget {
  final String title;
  final String imageName;
  const MyCategoryBar(
      {super.key, required this.title, required this.imageName});

  @override
  State<MyCategoryBar> createState() => _MyCategoryBarState();
}

class _MyCategoryBarState extends State<MyCategoryBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // image
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                "lib/assets/images/${widget.imageName}.png",
                height: 30,
                width: 30,
              )),
          Text(widget.title,
              style: GoogleFonts.varelaRound(
                  fontSize: 14, fontWeight: FontWeight.bold))
          // title
        ],
      ),
    );
  }
}
