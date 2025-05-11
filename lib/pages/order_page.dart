import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hotel_pos_app/components/cart_summary.dart';
import 'package:hotel_pos_app/components/chip_choice.dart';
import 'package:hotel_pos_app/components/tab_bar.dart';
import 'package:hotel_pos_app/providers/cart_provider.dart';
import 'package:hotel_pos_app/providers/product_provider.dart';
import 'package:hotel_pos_app/providers/tab_provider.dart';

import '../components/menu_bar.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage>
    with TickerProviderStateMixin {
  bool showSummary = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final tabState = ref.read(tabNotifierProvider);
    _tabController =
        TabController(length: tabState.tabNames.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    final tabState = ref.watch(tabNotifierProvider);
    final cartList = ref.watch(cartListNotifierProvider);
    final currentIndex = _tabController.index;

    // Only update the controller if the length has changed
    if (_tabController.length != cartList.cartList.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: cartList.cartList.length,
        vsync: this,
        initialIndex: currentIndex.clamp(0, cartList.cartList.length - 1),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black87,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          title: Text(
            "menu",
            style: TextStyle(color: Colors.white),
          ),
          bottom: CustomTabBar(
            controller: _tabController,
          )),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          ref.read(cartListNotifierProvider.notifier).addCart();
          ref.read(tabNotifierProvider.notifier).addTab();
          print(cartList.toString());
        },
        backgroundColor: Colors.orange[500],
        child: const Icon(Icons.add),
      ),
      body: TabBarView(
          controller: _tabController,
          children: List.generate(cartList.cartList.length, (tabIndex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filters
                const SizedBox(
                  height: 10,
                ),
                ChipChoice(),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    // Changed back to GridView.builder
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // Added gridDelegate
                      crossAxisCount: 2, // 2 columns
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      return MyMenuBar(
                        cartId: cartList.cartList[tabIndex].cartId ,
                        product: products[index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                showSummary
                    ? SizedBox(
                        height: 80,
                        width: 340,
                        child: CartSummaryBanner(showSummary: showSummary,cartId: cartList.cartList[tabIndex].cartId,))
                    : Container(),
              ],
            );
          })),
    );
  }
}
