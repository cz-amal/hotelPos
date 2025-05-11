import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStatsCard extends StatefulWidget {
  const MyStatsCard({super.key});

  @override
  State<MyStatsCard> createState() => _MyStatsCardState();
}

class _MyStatsCardState extends State<MyStatsCard> {
  final List<String> items = [
    'Today',
    'Last Week',
    'Last Month',
    'All Time',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.black,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              /// Header row with calendar + dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: Colors.orangeAccent, size: 16),
                      const SizedBox(width: 6),
                      Text("23 Sept 2024",
                          style: GoogleFonts.varelaRound(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: false,
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.varelaRound(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedValue ?? items[0],
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: 32,
                        width: 130,
                      ),
                      menuItemStyleData: const MenuItemStyleData(height: 32),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[850],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              color: Colors.blueAccent, size: 18),
                          const SizedBox(width: 6),
                          Text("Orders",
                              style: GoogleFonts.varelaRound(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text("3,445",
                          style: GoogleFonts.varelaRound(
                              color: Colors.grey[300],
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money,
                              color: Colors.green, size: 18),
                          const SizedBox(width: 6),
                          Text("Sales",
                              style: GoogleFonts.varelaRound(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text("34,576",
                          style: GoogleFonts.varelaRound(
                              color: Colors.grey[300],
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
