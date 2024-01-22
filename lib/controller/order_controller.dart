import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/models/objects.dart';

class OrderController {
  //--- Creates ther orders Collection reference in firestore
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  //--- Order Creation Function

  Future<void> saveOrderData(OrderModel model) {
    return orders
        .doc()
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("Order data saved"))
        .catchError((error) => Logger().e('Failed to save Order data'));
  }
}
