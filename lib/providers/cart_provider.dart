import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/models/cart_item.dart';
import 'package:hotel_pos_app/models/cart_list.dart';

import '../models/cart.dart';

class CartListNotifier extends Notifier<CartList> {
  @override
  CartList build() {
    return CartList(cartList: []);
  }

  int getTotalItemInCart(String cartId) {
    final cart = state.cartList.firstWhere((cart) => cart.cartId == cartId);
    return cart.items.length;
  }

  double getTotalPriceOfCart(String cartId) {
    final cart = state.cartList.firstWhere((cart) => cart.cartId == cartId);
    return cart.items.fold(0.0, (sum, item) => sum + item.totalprice);
  }

  int getQuantity(String cartId, String itemId) {
    final cart = state.cartList.firstWhere((cart) => cart.cartId == cartId);
    final item = cart.items.firstWhere(
      (item) => item.itemId == itemId,
      orElse: () => CartItem(
          itemId: itemId, name: '', price: 0.0, quantity: 0, totalprice: 0.0),
    );
    return item.quantity;
  }

  double getTotalPrice(String cartId, String itemId) {
    final cart = state.cartList.firstWhere((cart) => cart.cartId == cartId);
    final item = cart.items.firstWhere(
      (item) => item.itemId == itemId,
      orElse: () => CartItem(
          itemId: itemId, name: '', price: 0.0, quantity: 0, totalprice: 0.0),
    );
    return item.totalprice;
  }

  void addCart() {
    state = CartList(cartList: [
      ...state.cartList,
      Cart(items: []),
    ]);
  }

  void deleteCart(String cartId) {
    state = CartList(
      cartList: state.cartList.where((cart) => cart.cartId != cartId).toList(),
    );
  }

  void addItemToCart(String cartId, CartItem newItem) {
    CartList newCartList = CartList(
        cartList: state.cartList.map((cart) {
      if (cart.cartId == cartId) {
        final requiredIndex =
            cart.items.indexWhere((item) => item.itemId == newItem.itemId);
        if (requiredIndex != -1) {
          cart.items[requiredIndex].quantity += 1;
        } else {
          cart.items.add(newItem);
        }
      }
      return cart;
    }).toList());
    state = newCartList;
  }

  void deleteItemFromCart(String cartId, String itemId) {
    final updatedCartList = state.cartList.map((cart) {
      if (cart.cartId == cartId) {
        final newItems =
            cart.items.where((item) => item.itemId != itemId).toList();
        return Cart(cartId: cart.cartId, items: newItems);
      }
      return cart;
    }).toList();

    state = CartList(cartList: updatedCartList);
    print(state.toString());
  }

  void incrementCart(String cartId, String itemId) {
    CartList newCartList = CartList(
        cartList: state.cartList.map((cart) {
      if (cart.cartId == cartId) {
        final item = cart.items.firstWhere((item) => item.itemId == itemId);
        item.quantity += 1;
        item.totalprice += item.price;
      }

      return cart;
    }).toList());
    state = newCartList;
  }

  void decrementCart(String cartId, String itemId) {
    final updatedCartList = state.cartList.map((cart) {
      if (cart.cartId == cartId) {
        final updatedItems = cart.items
            .map((item) {
              if (item.itemId == itemId) {
                if (item.quantity <= 1) return null; // Mark for deletion
                return CartItem(
                  itemId: item.itemId,
                  name: item.name,
                  quantity: item.quantity - 1,
                  price: item.price,
                  totalprice: item.totalprice - item.price,
                );
              }
              return item;
            })
            .whereType<CartItem>()
            .toList();

        return Cart(cartId: cart.cartId, items: updatedItems);
      }
      return cart;
    }).toList();

    state = CartList(cartList: updatedCartList);
  }
}

final cartListNotifierProvider =
    NotifierProvider<CartListNotifier, CartList>(() {
  return CartListNotifier();
});
