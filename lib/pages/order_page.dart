import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/components/my_category_bar.dart';

import '../components/my_foot_tile.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(18),
          backgroundColor: Colors.orange[500],
          shape: CircleBorder()
        ),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          // menu + n items
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Menu",
                    style: GoogleFonts.varelaRound(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text("23 items",
                    style: GoogleFonts.varelaRound(
                        fontSize: 12, fontWeight: FontWeight.bold,
                      color: Colors.brown
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyCategoryBar(title: "All", imageName: "category-all"),
              MyCategoryBar(title: "Non.Veg", imageName: "category-nonveg"),
              MyCategoryBar(title: "Veg", imageName: "category-veg"),
              MyCategoryBar(title: "Drinks", imageName: "category-drinks")
              ]
          ),
          const SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
              MyFootTile(),
            MyFootTile(),
            ],
          ),
          
          
          



          // category bar

          // list of items


        ],
      ),
    );
  }
}
