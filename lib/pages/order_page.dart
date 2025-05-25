import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../providers/order_provider.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  final List<String> filterOptions = [
    'Today',
    'Past Week',
    'Past Month',
    'All Time',
  ];
  String selectedFilter = 'Today';

  @override
  void initState() {
    super.initState();
    selectedFilter = filterOptions[0];
  }

  String formatDate(DateTime date){
    return DateFormat("yyyy-MM-dd").format(date);
  }
  String formatTime(DateTime time){
    return DateFormat("hh:mm a").format(time);
  }


  @override
  Widget build(BuildContext context) {
    final orderList = ref.watch(orderListNotifierProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Your Orders",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterOptions.length,
                  itemBuilder: (context, index) {
                    final option = filterOptions[index];
                    final isSelected = selectedFilter == option;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(option),
                        selectedColor: Colors.blue[700],
                        checkmarkColor: Colors.white,
                        labelStyle: GoogleFonts.varelaRound(
                          color: isSelected ? Colors.white : Colors.grey[300],
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        backgroundColor: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.blue[700]!
                                : Colors.grey[800]!,
                            width: 1,
                          ),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedFilter = option;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: orderList.orderList.length,
                itemBuilder: (context, index) {
                  // Sample status data for visual variety
                  final List<Map<String, dynamic>> statuses = [
                    {'text': 'Completed', 'color': Colors.green},
                    {'text': 'Pending', 'color': Colors.orange},
                    {'text': 'Processing', 'color': Colors.blue},
                    {'text': 'Cancelled', 'color': Colors.red},
                    {'text': 'Refunded', 'color': Colors.purple},
                    {'text': 'On Hold', 'color': Colors.yellow},
                    {'text': 'Shipped', 'color': Colors.teal},
                    {'text': 'Delivered', 'color': Colors.greenAccent},
                    {'text': 'Returned', 'color': Colors.redAccent},
                    {'text': 'Failed', 'color': Colors.grey},
                    {'text': 'Completed', 'color': Colors.green},
                    {'text': 'Pending', 'color': Colors.orange},
                    {'text': 'Processing', 'color': Colors.blue},
                  ];
                  final status = statuses[index % statuses.length];


                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1E1E1E),
                            Color(0xFF252525),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row with Order ID and Date
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.receipt_long,
                                        size: 18,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order #${orderList.orderList[index].orderId.substring(0,8)}",
                                          style: GoogleFonts.varelaRound(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              formatTime(orderList.orderList[index].date),
                                              style: GoogleFonts.varelaRound(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            status['color'].withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        status['text'],
                                        style: GoogleFonts.varelaRound(
                                          color: status['color'],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      formatDate(orderList.orderList[index].date),
                                      style: GoogleFonts.varelaRound(
                                        fontSize: 12,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Color(0xFF2A2A2A)),
                            const SizedBox(height: 12),

                            // Order details
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildInfoTile(
                                  icon: Icons.shopping_bag_outlined,
                                  label: "Items",
                                  value: "${orderList.orderList[index].itemCount}x",
                                  iconColor: Colors.amber,
                                ),
                                _buildInfoTile(
                                  icon: Icons.attach_money,
                                  label: "Total",
                                  value: "₹${orderList.orderList[index].totalPrice}",
                                  iconColor: Colors.green,
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Handle view details
                                    },
                                    icon: const Icon(
                                      Icons.visibility_outlined,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Details",
                                      style: GoogleFonts.varelaRound(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[700],
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoTile({
  required IconData icon,
  required String label,
  required String value,
  Color iconColor = Colors.blue,
  Color? badgeColor,
}) {
  return Column(
    children: [
      Row(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                label,
                style: GoogleFonts.varelaRound(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                value,
                style: GoogleFonts.varelaRound(
                  color: badgeColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
