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
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "lib/assets/images/user_icon.png",
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "John Doe",
                    style: GoogleFonts.varelaRound(
                      fontSize: 16,
                      color: Colors.orange[500],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Admin",
                    style: GoogleFonts.varelaRound(
                      fontSize: 14,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
