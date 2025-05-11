import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/providers/cart_provider.dart';

class CartSummaryBanner extends ConsumerStatefulWidget {
  final bool showSummary;
  final String cartId;

  const CartSummaryBanner({super.key, required this.showSummary,required this.cartId});

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

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _offsetAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
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
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[900],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green, blurRadius: 2, spreadRadius: 1)
                    ]),
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
                            Text("${ref.read(cartListNotifierProvider.notifier).getTotalItemInCart(widget.cartId)} items",
                                style: GoogleFonts.varelaRound(
                                    fontSize: 10, color: Colors.white)),
                            Text("₹ ${ref.read(cartListNotifierProvider.notifier).getTotalPriceOfCart(widget.cartId)}",
                                style: GoogleFonts.varelaRound(
                                    color: Colors.green))
                          ],
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                          child: Text("Go to Cart",
                              style:
                                  GoogleFonts.varelaRound(color: Colors.white)),
                        )
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
