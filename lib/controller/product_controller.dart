// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/utilities/firebase_helper.dart';
import '../models/objects.dart';
import 'file_upload_controller.dart';

class ProductController {
  // Firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Firestore collections
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference favourite =
      FirebaseFirestore.instance.collection('favourite');
  final CollectionReference shoesizes =
      FirebaseFirestore.instance.collection('shoesizes');

  // Upload product data to Firestore
  Future<void> saveProductData(ProductModel model) async {
    return products
        .doc()
        .set(model.toJson(), SetOptions(merge: true))
        .then((value) => Logger().i("Product data saved"))
        .catchError(
            (error) => Logger().e("Failed to save product data: $error"));
  }

  // Fetch all products from Firestore
  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot snapshot = await products.get();
      List<ProductModel> list = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  // Fetch all shoe sizes and colors from Firestore
  Future<List<SizeModel>> getSizeAndColor() async {
    try {
      QuerySnapshot snapshot = await shoesizes.get();
      List<SizeModel> list = snapshot.docs.map((doc) {
        return SizeModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  // Upload product image to Firebase Storage and return the image URL
  Future<String> uploadProductImage(File image) async {
    try {
      UploadTask? task =
          FileUploadController.uploadFile(image, "productImages");
      final snapshot = await task!.whenComplete(() {});
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  // Stream to get favourite product for a specific product
  Stream<QuerySnapshot> getFavouriteProductStream(int productId) {
    return favourite
        .where('uid', isEqualTo: FirebaseHelper.auth.currentUser!.uid)
        .where("productId", isEqualTo: productId)
        .snapshots();
  }

  // Stream to get all favourite products for the current user
  Stream<QuerySnapshot> getFavouriteProductWithUID() {
    return favourite
        .where('uid', isEqualTo: FirebaseHelper.auth.currentUser!.uid)
        .snapshots();
  }

  // Stream to get a specific product by product ID
  Stream<QuerySnapshot> getProductWithID(int productId) {
    return products.where('productId', isEqualTo: productId).snapshots();
  }

  // Add a product to the favourites collection
  Future<void> addToFavourite(FavouriteModel model) async {
    return favourite
        .doc()
        .set(model.toJson(), SetOptions(merge: true))
        .then((value) => Logger().i("Added to favorites"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }

  // Remove a product from the favourites collection
  Future<void> removeFromFavourite(FavouriteModel model) async {
    try {
      QuerySnapshot snapshot = await favourite
          .where('uid', isEqualTo: model.uid)
          .where('productId', isEqualTo: model.productId)
          .get();

      await favourite.doc(snapshot.docs[0].id).delete();
      Logger().i("Deleted from favorites");
    } catch (e) {
      Logger().e("Failed to delete data: $e");
    }
  }

  // Fetch all favourite products for the current user
  Future<List<FavouriteModel>> getFavoriteProducts() async {
    try {
      QuerySnapshot snapshot = await favourite
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      List<FavouriteModel> list = snapshot.docs.map((doc) {
        return FavouriteModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
