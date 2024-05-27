import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/controller/order_controller.dart';
import 'package:sneaker_store/models/objects.dart';

class OrderPrvider extends ChangeNotifier {
// ----- a list to store the all orders list
  List<OrderModel> _allOrders = [];

  // ----- getter for porduct list

  List<OrderModel> get allOrders => _allOrders;

  // ----- loading state

  bool _isLoading = false;

  // ----- get loading state

  bool get isLoading => _isLoading;

  // -----setter for loading state

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // ---- Order Saving to firestore db

  Future<void> saveOrderData(OrderModel model) async {
    try {
      //--start the loader
      setLoading(true);

      //--- start uploading order data

      OrderController().saveOrderData(model);

      //--stop the loader
      setLoading(false);
    } catch (e) {
      //--stop the loader
      setLoading(false);
      Logger().e(e);
    }
  }

  //---- fetch all orders from firestore db

  Future<void> fetchOrders(String uid) async {
    try {
      //--start the loader
      setLoading(true);

      //---- start fetching data

      _allOrders = await OrderController().getOrders(uid);

      //--stop the loader
      setLoading(false);
    } catch (e) {
      //--stop the loader
      setLoading(false);
      Logger().e(e);
    }
  }
}
