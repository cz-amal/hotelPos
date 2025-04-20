import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  const MyNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 40),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.grey[100]),
      child: GNav(
          onTabChange: onTabChange,
          selectedIndex: selectedIndex,
          padding: EdgeInsets.all(12),
          backgroundColor: Colors.grey[100]!,
          activeColor: Colors.orange,
          tabs: [
            GButton(icon: Icons.home),
            GButton(icon: Icons.shopping_cart),
            GButton(icon: Icons.inventory),
            GButton(icon: Icons.show_chart)
          ]),
    );
  }
}
