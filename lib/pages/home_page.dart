import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/components/location_bar.dart';
import 'package:hotel_pos_app/components/search_bar.dart';
import 'package:hotel_pos_app/components/stats_card.dart';

import '../components/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = [
    'today',
    'past week',
    'past month',
    'all time',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyAppBar(),
          MyLocationBar(),
          Stack(children: [
            Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.black
              ),
            ),
            MySearchBar()
          ]),
          const SizedBox(
            height: 10,
          ),
          MyStatsCard(),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Orders",
                    style: GoogleFonts.varelaRound(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
                Text("view all",
                    style: GoogleFonts.varelaRound(
                        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header Row - Order ID and Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.receipt_long, size: 18, color: Colors.black54),
                              SizedBox(width: 6),
                              Text(
                                "#12345678",
                                style: GoogleFonts.varelaRound(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                "23 Apr 2025",
                                style: GoogleFonts.varelaRound(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      /// Divider for clarity
                      Divider(height: 1, color: Colors.grey[300]),

                      SizedBox(height: 12),

                      /// Details Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoTile(
                            icon: Icons.shopping_bag_outlined,
                            label: "Items",
                            value: "4x",
                          ),
                          _buildInfoTile(
                            icon: Icons.attach_money,
                            label: "Total",
                            value: "₹120",
                          ),
                          _buildInfoTile(
                            icon: Icons.pending_actions,
                            label: "Status",
                            value: "Pending",
                            badgeColor: Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildInfoTile({
  required IconData icon,
  required String label,
  required String value,
  Color? badgeColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        spacing: 2,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              label,
              style: GoogleFonts.varelaRound(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      badgeColor == null
          ? Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                value,
                style: GoogleFonts.varelaRound(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: GoogleFonts.varelaRound(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: badgeColor,
                ),
              ),
            ),
    ],
  );
}
