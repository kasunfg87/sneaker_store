import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/controller/order_controller.dart';
import 'package:sneaker_store/models/objects.dart';

class OrderPrvider extends ChangeNotifier {
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

  Future<void> saveOrderData(CartItemModel cartItemModel, double cartTotal,
      double discount, double grandTotal, int orderId) async {
    try {
      //--start the loader
      setLoading(true);

      //--- start uploading order data

      OrderController().saveOrderData(
        OrderModel(
          orderId: orderId,
          cartTotal: cartTotal,
          discount: discount,
          grandTotal: grandTotal,
          cartItemModel: cartItemModel,
        ),
      );
      //--stop the loader
      setLoading(true);
    } catch (e) {
      //--stop the loader
      setLoading(true);
      Logger().e(e);
    }
  }
}
