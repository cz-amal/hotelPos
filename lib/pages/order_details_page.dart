import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_pos_app/providers/order_provider.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends ConsumerWidget {
  const OrderDetailsPage({super.key});
  String formatDate(DateTime date) {
    return DateFormat("dd-MM-yyy").format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat("hh:mm a").format(time);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.read(orderListNotifierProvider);
    var currentOrder = order.orderList[0];

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text(
          "Order Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.orange.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "#${currentOrder.orderId.substring(0, 5)}",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatDate(currentOrder.date),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formatTime(currentOrder.date),
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Order Items Section
              Text(
                "Order Items",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Items Table
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Table Header
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          _buildHeaderCell("ID", 1),
                          _buildHeaderCell("Item", 2),
                          _buildHeaderCell("Qty", 1),
                          _buildHeaderCell("Price", 1),
                        ],
                      ),
                    ),

                    // Table Content
                    ...currentOrder.items.map((item) => Container(
                          child: Row(
                            children: [
                              _buildContentCell(item.itemId, 1),
                              _buildContentCell(item.name, 2),
                              _buildContentCell(item.quantity.toString(), 1),
                              _buildContentCell("\$${item.price}", 1),
                            ],
                          ),
                        ))
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Text(
                "Price Details",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              // Total Section
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildPriceRow("Total MRP", 20.toString()),
                    const SizedBox(height: 12),
                    _buildPriceRow("CGST (2%)", (20 * 0.02).toStringAsFixed(2)),
                    const SizedBox(height: 12),
                    _buildPriceRow("SGST (1.5%)", (20 * 0.015).toStringAsFixed(2)),
                    const SizedBox(height: 12),
                    _buildPriceRow("PAYMENT", "online"),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    ),
                    _buildPriceRow(
                      "Order Total",
                      (20 * 1.035).toStringAsFixed(2),
                      isTotal: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContentCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 14,
          ),
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
