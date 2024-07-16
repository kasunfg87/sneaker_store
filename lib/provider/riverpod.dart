import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sneaker_store/controller/product_controller.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/provider/favourite_provider.dart';
import 'package:sneaker_store/provider/order_provider.dart';
import 'package:sneaker_store/provider/payment_provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/provider/user_provider.dart';

final cartRiverPod = ChangeNotifierProvider((ref) => CartProvider());
final favouriteRiverPod = ChangeNotifierProvider((ref) => FavouriteProvider());
final orderRiverPod = ChangeNotifierProvider((ref) => OrderProvider());
final productRiverPod = ChangeNotifierProvider((ref) => ProductProvider());
final userRiverPod = ChangeNotifierProvider((ref) => UserProvider());
final paymentRiverPod = ChangeNotifierProvider((ref) => PaymentProvider());

final favouriteProductStreamProvider =
    StreamProvider.family<QuerySnapshot, int>((ref, productId) {
  return ProductController().getFavouriteProductStream(productId);
});

final zoomDrawerControllerProvider = Provider<ZoomDrawerController>((ref) {
  return ZoomDrawerController();
});
