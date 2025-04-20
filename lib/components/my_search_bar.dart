import 'package:flutter/material.dart';
class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left:15,right: 15,top: 8,bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child:TextField(
            cursorColor: Colors.grey[500],
            decoration: InputDecoration(

              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              hintText: "search for dish",
              hintStyle: TextStyle(color: Colors.grey[500]),
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent, // use transparent so container color is visible
            ),
            style: TextStyle(fontSize: 16),
          ),
        )
    );
  }
}
