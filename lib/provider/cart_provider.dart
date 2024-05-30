import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';

class CartProvider extends ChangeNotifier {
  int _counter = 1;

  int get counter => _counter;

  // Increase the counter value
  void increaseCounter() {
    _counter++;
    notifyListeners();
  }

  // Decrease the counter value
  void decreaseCounter() {
    if (_counter != 1) {
      _counter--;
    }
    notifyListeners();
  }

  // Reset the counter to 1
  void clearCounter() {
    _counter = 1;
  }

  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => _cartItems;

  // Add a product to the cart
  void addToCart(ProductModel productModel, BuildContext context, String size) {
    // Check if the product is already in the cart
    if (_cartItems.any((element) => element.id == productModel.productId)) {
      // Increase quantity if the product is already in the cart
      increaseCartItemQty(productModel);
      calculateSubTotal(productModel);
      AlertHelper.showSanckBar(
          context, 'Increased product amount!', AnimatedSnackBarType.success);
    } else {
      // Add new product to the cart
      _cartItems.add(CartItemModel(
        id: productModel.productId,
        amount: _counter,
        subTotal: _counter * double.parse(productModel.price.toString()),
        productModel: productModel,
        size: size,
      ));
      AlertHelper.showSanckBar(
          context, 'Added to the cart', AnimatedSnackBarType.success);
    }

    Logger().w(_cartItems.length);

    // Clear the counter after adding to the cart
    clearCounter();
    notifyListeners();
  }

  // Calculate subtotal for a cart item
  void calculateSubTotal(ProductModel model) {
    var item =
        _cartItems.singleWhere((element) => element.id == model.productId);
    item.subTotal = item.amount * model.price;
    notifyListeners();
  }

  // Increase the quantity of a specific cart item
  void increaseCartItemQty(ProductModel model) {
    int productId = model.productId;

    for (var item in _cartItems) {
      if (item.id == productId) {
        item.amount++;
        calculateSubTotal(model);
        break; // Exit the loop after updating the item
      }
    }

    Logger().d(cartItems.where((element) => element.id == productId).toList());
    notifyListeners();
  }

  // Decrease the quantity of a specific cart item
  void decreaseCartItemQty(ProductModel model, BuildContext context) {
    int productId = model.productId;

    for (var item in _cartItems) {
      if (item.id == productId) {
        if (item.amount == 1) {
          removeCartItem(productId, context);
        } else {
          item.amount--;
          calculateSubTotal(model);
        }
        break; // Exit the loop after processing the item
      }
    }

    notifyListeners();
  }

  // Remove a cart item by its ID
  void removeCartItem(int id, BuildContext context) {
    _cartItems.removeWhere((element) => element.id == id);
    AlertHelper.showSanckBar(
        context, 'Removed from the cart', AnimatedSnackBarType.error);
    notifyListeners();
  }

  // Get the total cost of items in the cart
  double get getCartTotal {
    double total = 0;
    for (var item in _cartItems) {
      total += item.subTotal;
    }
    return total;
  }

  // Get the total count of items in the cart
  int get getCartTotalItemCount {
    int totalCount = 0;
    for (var item in _cartItems) {
      totalCount += item.amount;
    }
    return totalCount;
  }

  // Clear all items in the cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
