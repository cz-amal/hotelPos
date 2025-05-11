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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          cursorColor: Colors.grey[300],
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            hintText: "Search for dish",
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
