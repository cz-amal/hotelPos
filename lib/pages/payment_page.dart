import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/models/cart_list.dart';
import 'package:hotel_pos_app/models/order.dart';
import 'package:hotel_pos_app/providers/cart_provider.dart';
import 'package:hotel_pos_app/providers/order_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../models/cart.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final String price;
  final String cartId;
  const PaymentPage({super.key, required this.price, required this.cartId});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(cartListNotifierProvider);
    final orderList = ref.watch(orderListNotifierProvider);
    final items = cartList.cartList
        .firstWhere((item) => item.cartId == widget.cartId)
        .items;
    final totalMrp = ref
        .read(cartListNotifierProvider.notifier)
        .getTotalPriceOfCart(widget.cartId);
    return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Payment",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          centerTitle: true,
        ),
        body: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "order id: #92892",
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            "lib/assets/images/qr-code.png",
            color: Colors.white,
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "upi id: c.z@super.yes",
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.price,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            "22 August 2025 | 10:20 am",
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            indent: 40,
            endIndent: 40,
            color: Colors.white10,
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  spacing: 16, // Reduced spacing for items within the column
                  children: [
                    Card(
                      color: Colors.black, // Darker background for the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Method",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            ToggleSwitch(
                              customTextStyles: [
                                GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ],
                              minWidth: 120.0,
                              initialLabelIndex: 1,
                              cornerRadius: 20.0,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey[800],
                              inactiveFgColor: Colors.white,
                              totalSwitches: 2,
                              labels: const ['Cash', 'Online'],
                              icons: const [
                                Icons.attach_money,
                                Icons.book_online
                              ],
                              activeBgColors: const [
                                [Colors.teal], // More prominent active color
                                [Colors.teal]
                              ],
                              onToggle: (index) {
                                print('Payment method switched to: $index');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            ToggleSwitch(
                              customTextStyles: [
                                GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ],
                              minWidth: 120.0,
                              initialLabelIndex: 1,
                              cornerRadius: 20.0,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey[800],
                              inactiveFgColor: Colors.white,
                              totalSwitches: 2,
                              labels: const ['Pending', 'Complete'],
                              icons: const [Icons.timer, Icons.done],
                              activeBgColors: const [
                                [Colors.teal], // Different active color
                                [Colors.teal]
                              ],
                              onToggle: (index) {
                                print('Payment status switched to: $index');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              ElevatedButton(
                onPressed: () {
                  // get current cart
                  List<Cart> cartList =
                      ref.read(cartListNotifierProvider).cartList;
                  Order newOrder = Order(
                      cartId: widget.cartId,
                      itemCount: items.length.toString(),
                      totalPrice: (totalMrp * 1.035).toStringAsFixed(2),
                      date: DateTime.now());
                  // add order to the orderList
                  ref
                      .read(orderListNotifierProvider.notifier)
                      .addOrder(newOrder);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: const Text("Complete Order"),
              )
            ],
          ),
        ]));
  }
}
