import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipChoice extends StatefulWidget {
  const ChipChoice({super.key});

  @override
  State<ChipChoice> createState() => _ChipChoiceState();
}

class _ChipChoiceState extends State<ChipChoice> {
  int selectedFilterIndex = 1;
  List<String> filters = ['All', "Non.Veg", "Veg", "Drinks"];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final isSelected = index == selectedFilterIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilterIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isSelected
                          ? Colors.grey.shade100
                          : Colors.grey),
                ),
                child: Text(
                  filters[index],
                  style: GoogleFonts.robotoMono(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
