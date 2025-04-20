import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFootTile extends StatefulWidget {
  const MyFootTile({super.key});

  @override
  State<MyFootTile> createState() => _MyFootTileState();
}

class _MyFootTileState extends State<MyFootTile> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orangeAccent,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Center(
            child: Image.asset(
              "lib/assets/images/category-all.png",
              height:100,
              width: 150,
            ),
          ),
          const SizedBox(height: 10),

          // Title + Category
          Text(
            "Chinese Noodles",
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.local_fire_department, color: Colors.redAccent, size: 16),
              const SizedBox(width: 4),
              Text(
                "Non-Veg",
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: Colors.brown,
                ),
              ),
            ],
          ),

          const SizedBox(height: 2),

          // Price + Quantity buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹120",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.remove_circle, size: 22,color: Colors.brown,),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text(
                    quantity.toString(),
                    style: GoogleFonts.roboto(fontSize: 14),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add_circle, size: 22,color: Colors.brown,),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),

          // Expand button
          // IconButton(
          //   icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 24),
          //   splashRadius: 20,
          //   onPressed: () {
          //     // Navigate to more details
          //   },
          // ),
        ],
      ),
    );
  }
}
