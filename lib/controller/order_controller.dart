import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/models/objects.dart';

class OrderController {
  // Firestore collection reference for orders
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  // Save order data in Firestore
  Future<void> saveOrderData(OrderModel model) {
    return orders
        .doc() // Create a new document with a generated ID
        .set(model.toJson(), SetOptions(merge: true))
        .then((value) => Logger().i("Order data saved"))
        .catchError((error) => Logger().e('Failed to save order data: $error'));
  }

  // Fetch all orders for a specific user
  Future<List<OrderModel>> getOrders(String uid) async {
    try {
      // Query to fetch orders for a specific user
      QuerySnapshot snapshot =
          await orders.where('createdBy', isEqualTo: uid).get();

      // List to store the fetched orders
      List<OrderModel> list = [];

      // Map fetched data to OrderModel and store in the list
      for (var element in snapshot.docs) {
        OrderModel model =
            OrderModel.fromJson(element.data() as Map<String, dynamic>);
        list.add(model);
      }
      // Sort the list by order ID in decending order
      list.sort((b, a) => a.orderId.compareTo(b.orderId));

      Logger().i("Fetched ${list.length} orders");
      return list;
    } catch (e) {
      Logger().e("Failed to fetch orders: $e");
      return [];
    }
  }
}
