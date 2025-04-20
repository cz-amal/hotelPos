import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/components/my_category_bar.dart';
import 'package:hotel_pos_app/components/my_location_bar.dart';
import 'package:hotel_pos_app/components/my_nav_bar.dart';
import 'package:hotel_pos_app/components/my_search_bar.dart';
import 'package:hotel_pos_app/components/my_stats_card.dart';
import 'package:hotel_pos_app/pages/order_page.dart';

import '../components/my_app_bar.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<String> items = [
    'today',
    'past week',
    'past month',
    'all time',
  ];
  int _selectedIndex = 1;

  final List<Widget> pages = [const HomePage(), const OrderPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: MyNavBar(
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: AppBar(
            backgroundColor: Colors.orange[500],
          ),
        ),
        body: pages[_selectedIndex]);
  }
}
