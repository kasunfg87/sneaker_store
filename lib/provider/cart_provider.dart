import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';

class CartProvider extends ChangeNotifier {
  int _counter = 1;

  int get counter => _counter;

  void increaseCounter() {
    _counter++;

    notifyListeners();
  }

  void decreaseCounter() {
    if (_counter != 1) {
      _counter--;
    }

    notifyListeners();
  }

  void clearCounter() {
    _counter = 1;
  }

  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => _cartItems;

  void addToCart(ProductModel productModel, BuildContext context, String size) {
    // ignore: unrelated_type_equality_checks
    if (_cartItems.any((element) => element.id == productModel.productId)) {
      increaseCartItemQty(productModel);

      calculateSubTotal(productModel);

      AlertHelper.showSanckBar(
          context, 'Increased product amount!', AnimatedSnackBarType.success);
    } else {
      _cartItems.add(CartItemModel(
          id: productModel.productId,
          amount: _counter,
          subTotal: _counter * double.parse(productModel.price.toString()),
          productModel: productModel,
          size: size));

      AlertHelper.showSanckBar(
          context, 'Added to the cart', AnimatedSnackBarType.success);
    }

    Logger().w(_cartItems.length);

    clearCounter();

    notifyListeners();
  }

  // -----calculate subtotal

  void calculateSubTotal(ProductModel model) {
    // -----calculate cart item subtotal with apdated amount
    _cartItems
        .singleWhere((element) => element.id == model.productId)
        .subTotal = _cartItems
            .singleWhere((element) => element.id == model.productId)
            .amount *
        model.price;
    notifyListeners();
  }

  void increaseCartItemQty(ProductModel model) {
    int productId = model.productId;

    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].id == productId) {
        _cartItems[i].amount++;
        calculateSubTotal(model);
        break; // exit the loop after updating the item
      }
    }

    Logger().d(cartItems.where((element) => element.id == productId).toList());

    notifyListeners();
  }

  void decreaseCartItemQty(ProductModel model, BuildContext context) {
    int productId = model.productId;

    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].id == productId) {
        if (_cartItems[i].amount == 1) {
          removeCartItem(productId, context);
        } else {
          _cartItems[i].amount--;
          calculateSubTotal(model);
        }
        break; // exit the loop after processing the item
      }
    }

    notifyListeners();
  }

  void removeCartItem(int id, BuildContext context) {
    _cartItems.removeWhere((element) => element.id == id);

    AlertHelper.showSanckBar(
        context, 'Removed from the cart', AnimatedSnackBarType.error);

    notifyListeners();
  }

  double get getCartTotal {
    double temp = 0;

    for (var item in _cartItems) {
      temp += item.subTotal;
    }

    return temp;
  }

  int get getCartTotalItemCount {
    int temp = 0;

    for (var item in _cartItems) {
      temp += item.amount;
    }

    return temp;
  }

  void clearCart() {
    _cartItems.clear();

    notifyListeners();
  }
}
