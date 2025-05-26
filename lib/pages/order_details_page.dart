import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/providers/order_provider.dart';

class OrderDetailsPage extends ConsumerWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.read(orderListNotifierProvider);
    var currentOrder = order.orderList[0];
    final result = currentOrder.items.map((cartItem) {
      return TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(cartItem.itemId,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(cartItem.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(cartItem.quantity.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(cartItem.price.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        )
      ]);
    }).toList();

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Table(
                  border: TableBorder.all(color: Colors.white),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(60),
                    1: FixedColumnWidth(120),
                    2: FixedColumnWidth(100),
                    3: FixedColumnWidth(120),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: result),
            ]));
  }
}
