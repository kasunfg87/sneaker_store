import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/controller/order_controller.dart';
import 'package:sneaker_store/models/objects.dart';

class OrderProvider extends ChangeNotifier {
  // List to store all orders
  List<OrderModel> _allOrders = [];

  // Getter for the orders list
  List<OrderModel> get allOrders => _allOrders;

  // Loading state
  bool _isLoading = false;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Setter for loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // Save order data to Firestore
  Future<void> saveOrderData(OrderModel model) async {
    try {
      // Start the loader
      setLoading(true);

      // Start uploading order data
      await OrderController().saveOrderData(model);

      // Stop the loader
      setLoading(false);
    } catch (e) {
      // Stop the loader and log the error
      setLoading(false);
      Logger().e(e);
    }
  }

  // Fetch all orders from Firestore
  Future<void> fetchOrders(String uid) async {
    try {
      // Start the loader
      setLoading(true);

      // Start fetching data
      _allOrders = await OrderController().getOrders(uid);

      // Stop the loader
      setLoading(false);
    } catch (e) {
      // Stop the loader and log the error
      setLoading(false);
      Logger().e(e);
    }
  }
}
