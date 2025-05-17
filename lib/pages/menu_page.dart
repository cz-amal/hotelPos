import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hotel_pos_app/components/cart_summary.dart';
import 'package:hotel_pos_app/components/chip_choice.dart';
import 'package:hotel_pos_app/components/custom_tab_bar.dart';
import 'package:hotel_pos_app/pages/summary_page.dart';
import 'package:hotel_pos_app/providers/cart_provider.dart';
import 'package:hotel_pos_app/providers/product_provider.dart';
import 'package:hotel_pos_app/providers/tab_provider.dart';

import '../components/menu_bar.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<MenuPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<MenuPage>
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
            "Your Menu",
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          bottom: CustomTabBar(
            controller: _tabController,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            ref.read(cartListNotifierProvider.notifier).addCart();
            ref.read(tabNotifierProvider.notifier).addTab();
            print(cartList.toString());
          },
          backgroundColor: Colors.orange[500],
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: List.generate(cartList.cartList.length, (tabIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const ChipChoice(),
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
                          cartId: cartList.cartList[tabIndex].cartId,
                          product: products[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  showSummary
                      ? Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SummaryPage(
                                            cartId: cartList
                                                .cartList[tabIndex].cartId,
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 15),
                              textStyle: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                            child: const Text("Go to cart"),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 15,
                  )
                ],
              );
            })));
  }
}
