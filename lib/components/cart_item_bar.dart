import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/components/quantity_button.dart';
import 'package:logger/logger.dart';

import '../models/cart_item.dart';
import '../models/products.dart';
import '../providers/cart_provider.dart';

class CartItemBar extends ConsumerStatefulWidget {
  final int index;
  final String cartId;
  const CartItemBar({super.key, required this.index, required this.cartId});

  @override
  ConsumerState<CartItemBar> createState() => _CartItemBarState();
}

class _CartItemBarState extends ConsumerState<CartItemBar> {
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(cartListNotifierProvider);
    List<CartItem> items = cartList.cartList
        .firstWhere((item) => item.cartId == widget.cartId)
        .items;
    logger.i(items);
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E1E1E),
            Color(0xFF232323),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: -5,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "product-${items[widget.index].id}",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "lib/assets/images/burger.jpg",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          items[widget.index].name,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "nice",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "₹${items[widget.index].totalprice}",
                          style: GoogleFonts.poppins(
                            color: Colors.greenAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          QuantityButton(
                            itemId: items[widget.index].id,
                            cartId: widget.cartId,
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(cartListNotifierProvider.notifier)
                                  .deleteItemFromCart(
                                      widget.cartId, items[widget.index].id);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFF5252).withOpacity(0.9),
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
