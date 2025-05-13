import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/models/cart.dart';
import 'package:hotel_pos_app/models/cart_item.dart';

import '../providers/cart_provider.dart';

class QuantityButton extends ConsumerStatefulWidget {
  final String cartId;
  final String itemId;
  const QuantityButton({super.key, required this.cartId, required this.itemId});

  @override
  ConsumerState<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends ConsumerState<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    final quantity = ref
        .watch(cartListNotifierProvider)
        .cartList
        .firstWhere((cart) => cart.cartId == widget.cartId,
            orElse: () => Cart(cartId: "", items: []))
        .items
        .firstWhere((item) => item.id == widget.itemId,
            orElse: () => CartItem(id: "", name: "", price: 0, quantity: 0))
        .quantity;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              ref
                  .read(cartListNotifierProvider.notifier)
                  .decrementCart(widget.cartId, widget.itemId);
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Align(
            child: Text(
              quantity.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ),
        IconButton(
            constraints: const BoxConstraints(),
            onPressed: () {
              ref
                  .read(cartListNotifierProvider.notifier)
                  .incrementCart(widget.cartId, widget.itemId);
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
    );
  }
}
