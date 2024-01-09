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

  // Creates the user collection reference in Firestore

  CollectionReference produts =
      FirebaseFirestore.instance.collection('products');

  // Creates the favourite product collection reference in Firestore

  CollectionReference favourite =
      FirebaseFirestore.instance.collection('favourite');

  CollectionReference shoesizes =
      FirebaseFirestore.instance.collection('shoesizes');

  //-------- Product upload function

  Future<void> saveProdctData(ProductModel model) async {
    return produts
        .doc()
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("product data saved"))
        .catchError(
            (error) => Logger().e("Failed to save product data: $error"));
  }

  // ----- Fetch all products

  Future<List<ProductModel>> getProducts() async {
    try {
      // ----- Query for fetching all the courses list

      QuerySnapshot snapshot = await produts.get();

      // ----- List to store the courses

      List<ProductModel> list = [];

      // ----- Mapping fetched data to CourseModel and storing them in the courses list

      for (var element in snapshot.docs) {
        // ----- Mapping to a single CourseModel

        ProductModel model =
            ProductModel.fromJson(element.data() as Map<String, dynamic>);

        // ----- Adding to the list

        list.add(model);
      }

      // ----- Return the courses list

      return list;
    } catch (e) {
      // ----- Error handling

      // ignore: avoid_print

      Logger().e(e);

      return [];
    }
  }

  // ----- Fetch all shoe sizes and colors

  Future<List<SizeModel>> getSizeAndColor() async {
    try {
      // ----- Query for fetching all the courses list

      QuerySnapshot snapshot = await shoesizes.get();

      // ----- List to store the courses

      List<SizeModel> list = [];

      // ----- Mapping fetched data to CourseModel and storing them in the courses list

      for (var element in snapshot.docs) {
        // ----- Mapping to a single CourseModel

        SizeModel model =
            SizeModel.fromJson(element.data() as Map<String, dynamic>);

        // ----- Adding to the list

        list.add(model);
      }

      // ----- Return the courses list

      return list;
    } catch (e) {
      // ----- Error handling

      // ignore: avoid_print

      Logger().e(e);

      return [];
    }
  }

  //-------upload and update user profile and return the image URL

  Future<String> uploadProductImage(
    File image,
  ) async {
    try {
      //---uploading the image file to profile images

      UploadTask? task =
          FileUploadController.uplaodFile(image, "productImages");

      final snapshot = await task!.whenComplete(() {});

      //---getting the download URL

      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      Logger().e(e);

      return "";

      // AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  // ----- Stream to get favourite product for a specific prodcut

  Stream<QuerySnapshot> getFavouriteProductStream(int productId) => favourite
      .where('uid', isEqualTo: FirebaseHelper.auth.currentUser!.uid)
      .where("productId", isEqualTo: productId)
      .snapshots();

  // ----- Stream to get favourite product with uid

  Stream<QuerySnapshot> getFavouriteProductWithUID() => favourite
      .where('uid', isEqualTo: FirebaseHelper.auth.currentUser!.uid)
      .snapshots();

// ----- Stream to get  product with product id

  Stream<QuerySnapshot> getProductWithID(int productid) =>
      produts.where('productId', isEqualTo: productid).snapshots();

  // ----- Add to favoutire

  Future<void> addToFavourite(FavouriteModel model) async {
    return favourite
        .doc()
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("Added to favorites"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }

  // ----- Remove from favourite

  Future<void> removeFromFavourite(FavouriteModel model) async {
    return await favourite
        .where('uid', isEqualTo: model.uid)
        .where('productId', isEqualTo: model.productId)
        .get()
        .then((value) => favourite.doc(value.docs[0].id).delete())
        .then((value) => Logger().i("Deleted from favorites"))
        .catchError((error) => Logger().e("Failed to delete data: $error"));
  }

  // ----- Fetch favorite courses

  Future<List<FavouriteModel>> getFavoriteProducts() async {
    try {
      // ----- Query for fetching bookmarks that belong to the current user

      QuerySnapshot snapshot = await favourite
          .where('uid', isEqualTo: FirebaseHelper.auth.currentUser!.uid)
          .get();

      // ----- List to store the bookmarks

      List<FavouriteModel> list = [];

      // ----- Mapping fetched data to BookmarkModel and storing them in the bookmarks list

      for (var element in snapshot.docs) {
        // ----- Mapping to a single BookmarkModel

        FavouriteModel model =
            FavouriteModel.fromJson(element.data() as Map<String, dynamic>);

        // ----- Adding to the list

        list.add(model);
      }

      // ----- Return the bookmarks list

      return list;
    } catch (e) {
      // ----- Error handling

      // ignore: avoid_print

      Logger().e(e);

      return [];
    }
  }
}
