import 'package:flutter/material.dart';
import 'package:hotel_pos_app/components/nav_bar.dart';
import 'package:hotel_pos_app/pages/menu_page.dart';

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
  int _selectedIndex = 2;

  final List<Widget> pages = [const HomePage(), const MenuPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: MyNavBar(
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: AppBar(
            backgroundColor: Colors.black,
          ),
        ),
        body: pages[_selectedIndex]);
  }
}
