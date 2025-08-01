import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/pages/summary_page.dart';
import 'package:hotel_pos_app/providers/cart_provider.dart';

class CartSummaryBanner extends ConsumerStatefulWidget {
  final bool showSummary;
  final String cartId;

  const CartSummaryBanner(
      {super.key, required this.showSummary, required this.cartId});

  @override
  ConsumerState<CartSummaryBanner> createState() => _CartSummaryBannerState();
}

class _CartSummaryBannerState extends ConsumerState<CartSummaryBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _offsetAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.showSummary) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(CartSummaryBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showSummary) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(cartListNotifierProvider);
    return SlideTransition(
      position: _offsetAnimation,
      child: Stack(
        children: [
          Positioned(
            left: 10,
            right: 10,
            top: 10,
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[900],
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${ref.read(cartListNotifierProvider.notifier).getTotalItemInCart(widget.cartId)} items",
                                style: GoogleFonts.poppins(
                                    fontSize: 10, color: Colors.white)),
                            Text(
                                "₹ ${ref.read(cartListNotifierProvider.notifier).getTotalPriceOfCart(widget.cartId)}",
                                style: GoogleFonts.poppins(
                                    color: Colors.green))
                          ],
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SummaryPage(
                                            cartId: widget.cartId,
                                          )));
                            },
                            child: Text("Go to Cart",
                                style: GoogleFonts.poppins(
                                    color: Colors.white))),
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
