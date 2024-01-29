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

  //--- Fetch all Orders

  Future<List<OrderModel>> getOrders(String uid) async {
    try {
      // ----- Query for fetching all the orders list
      QuerySnapshot snapshot = await orders.where(uid).get();

      // ----- List to store the orders
      List<OrderModel> list = [];

      // ----- Mapping fetched data to OrderModel and storing them in the orders list

      for (var element in snapshot.docs) {
        // ----- Mapping to a single OrderModel

        OrderModel model =
            OrderModel.fromJson(element.data() as Map<String, dynamic>);

        // ----- Adding to the list

        list.add(model);
      }

      // ----- Return the orders list
      Logger().i(list.length);
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
