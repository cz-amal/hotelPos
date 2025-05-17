import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/components/cart_item_bar.dart';
import 'package:hotel_pos_app/pages/payment_page.dart';
import 'package:hotel_pos_app/providers/cart_provider.dart';
import 'package:logger/logger.dart';

class SummaryPage extends ConsumerStatefulWidget {
  final String cartId;
  const SummaryPage({super.key, required this.cartId});

  @override
  ConsumerState<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends ConsumerState<SummaryPage> {
  bool _showDetails = false;
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(cartListNotifierProvider);
    final items = cartList.cartList
        .firstWhere((item) => item.cartId == widget.cartId)
        .items;
    final totalMrp = ref
        .read(cartListNotifierProvider.notifier)
        .getTotalPriceOfCart(widget.cartId);

    logger.i("length of itemList is ${items.length}");
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Your Cart",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  logger.i(int.parse(items[index].id));
                  return CartItemBar(
                    index: index,
                    cartId: widget.cartId,
                  );
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: _showDetails ? 300 : 80,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (totalMrp * 1.035).toStringAsFixed(2),
                                style: GoogleFonts.varelaRound(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showDetails = !_showDetails;
                                    });
                                  },
                                  child: Text(
                                      _showDetails
                                          ? "hide details"
                                          : "show details",
                                      style: GoogleFonts.varelaRound(
                                          color: Colors.blueAccent,
                                          fontSize: 12)))
                            ],
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentPage(
                                            price: (totalMrp * 1.035)
                                                .toStringAsFixed(2),
                                            cartId: widget.cartId,
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            child: Text(
                              "checkout",
                              style:
                                  GoogleFonts.varelaRound(color: Colors.white),
                            ))
                      ],
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      child: _showDetails
                          ? Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.receipt_outlined,
                                          color: Colors.greenAccent,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Price Details",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  _buildPriceRow(
                                      "Total MRP", totalMrp.toString()),
                                  const SizedBox(height: 12),
                                  _buildPriceRow("CGST (2%)",
                                      (totalMrp * 0.02).toStringAsFixed(2)),
                                  const SizedBox(height: 12),
                                  _buildPriceRow("SGST (1.5%)",
                                      (totalMrp * 0.015).toStringAsFixed(2)),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 0.5,
                                    ),
                                  ),
                                  _buildPriceRow(
                                    "Order Total",
                                    (totalMrp * 1.035).toStringAsFixed(2),
                                    isTotal: true,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: isTotal ? 16 : 14,
          fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          color: isTotal ? Colors.white : Colors.grey[300],
        ),
      ),
      Text(
        amount,
        style: GoogleFonts.poppins(
          fontSize: isTotal ? 18 : 14,
          fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          color: isTotal ? Colors.greenAccent : Colors.white,
        ),
      ),
    ],
  );
}
