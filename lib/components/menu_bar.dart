import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/models/cart.dart';
import 'package:hotel_pos_app/providers/cart_provider.dart';

import '../models/cart_item.dart';
import '../models/products.dart';

class MyMenuBar extends ConsumerStatefulWidget {
  final Product product;
  final String cartId;
  const MyMenuBar({super.key, required this.product, required this.cartId});

  @override
  ConsumerState<MyMenuBar> createState() => _MyMenuBarState();
}

class _MyMenuBarState extends ConsumerState<MyMenuBar> {
  @override
  Widget build(BuildContext context) {
    final quantity = ref
        .watch(cartListNotifierProvider)
        .cartList
        .firstWhere((cart) => cart.cartId == widget.cartId,
            orElse: () => Cart(cartId: "", items: []))
        .items
        .firstWhere((item) => item.itemId == widget.product.id,
            orElse: () => CartItem(itemId: "", name: "", price: 0, quantity: 0))
        .quantity;

    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF1E1E1E),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "lib/assets/images/burger.jpg",
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.name,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.product.description,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Colors.grey[300],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 14),
                  child: Text(
                    "₹ ${widget.product.price}",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.green[300],
                    ),
                  ),
                ),
                ref
                            .read(cartListNotifierProvider.notifier)
                            .getQuantity(widget.cartId, widget.product.id) <=
                        0
                    ? ElevatedButton(
                        onPressed: () {
                          ref
                              .read(cartListNotifierProvider.notifier)
                              .addItemToCart(
                                  widget.cartId, widget.product.toCartItem());
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.orange),
                          backgroundColor: const Color(0xFF1E1E1E),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(cartListNotifierProvider.notifier)
                                    .decrementCart(
                                        widget.cartId, widget.product.id);
                              },
                              constraints: const BoxConstraints(),
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 12,
                              )),
                          Container(
                            width: 50,
                            height: 30,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Align(
                              child: Text(
                                quantity.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                ref
                                    .read(cartListNotifierProvider.notifier)
                                    .incrementCart(
                                        widget.cartId, widget.product.id);
                              },
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 12,
                              ))
                        ],
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
