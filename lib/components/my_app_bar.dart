import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.orange[500]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 2,
            children: [
              const SizedBox(
                width: 8,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "lib/assets/images/user_icon.png",
                    height: 40,
                    width: 40,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "John Doe",
                    style: GoogleFonts.varelaRound(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Admin",
                    style: GoogleFonts.varelaRound(
                        fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        size: 30,
                        color: Colors.white,
                      ))),
              const SizedBox(width: 10)
            ],
          )
        ],
      ),
    );
  }
}
