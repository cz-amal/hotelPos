import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/providers/cart_provider.dart';
import 'package:hotel_pos_app/providers/tab_provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CustomTabBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomTabBar({super.key, required this.controller});
  final TabController controller;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  ConsumerState<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends ConsumerState<CustomTabBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        selectedIndex = widget.controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabState = ref.watch(tabNotifierProvider);
    return tabState.tabNames.isNotEmpty
        ? TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            dividerColor: Colors.black, // Removed the explicit divider
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorColor: Colors.black,
            labelPadding: EdgeInsets.zero,
            controller: widget.controller,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            tabs: List.generate(tabState.tabNames.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.orangeAccent
                        : Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      Text(
                        tabState.tabNames[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              text: 'Do you want to delete this cart?',
                              confirmBtnText: 'Yes',
                              cancelBtnText: 'No',
                              confirmBtnColor: Colors.green,
                              onCancelBtnTap: () {
                                Navigator.pop(context);
                              },
                              onConfirmBtnTap: () {
                                ref
                                    .read(cartListNotifierProvider.notifier)
                                    .deleteCart(tabState.cartIds[index]);
                                Navigator.pop(context);
                              });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        : Container();
  }
}
