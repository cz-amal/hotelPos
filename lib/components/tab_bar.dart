import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/providers/tab_provider.dart';

class CustomTabBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {

  const CustomTabBar({
    super.key,
    required this.controller
  });
  final TabController controller;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  ConsumerState<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends ConsumerState<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    final tabState = ref.watch(tabNotifierProvider);
    return TabBar(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      dividerColor: Colors.grey[800],
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorColor: Colors.deepPurple,
      labelPadding: EdgeInsets.zero,
      controller: widget.controller,
      tabs: List.generate(tabState.tabNames.length, (index) {
        return Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 10),
              Text(
                tabState.tabNames[index],
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                    ref.read(tabNotifierProvider.notifier).removeTab(index);
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.highlight_remove_outlined,
                    size: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      }),
    );
  }
}
