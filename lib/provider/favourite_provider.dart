import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/controller/product_controller.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';

class FavouriteProvider extends ChangeNotifier {
  // List to store the favourite products
  List<FavouriteModel> _favProducts = [];

  // Getter for the favourite products list
  List<FavouriteModel> get favProducts => _favProducts;

  bool _isLoading = false;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  final ProductController _productController = ProductController();

  // Fetch favourite products from Firestore
  Future<void> fetchFavouriteProducts() async {
    try {
      // Start the loader
      setLoading(true);

      // Fetch favourite products
      _favProducts = await _productController.getFavoriteProducts();
      notifyListeners();

      Logger().e(favProducts[0].productId);

      // Stop the loader
      setLoading(false);
    } catch (e) {
      // Log the error and stop the loader
      Logger().e(e);
      setLoading(false);
    }
  }
  // ignore: prefer_function_declarations_over_variables

  // Add or remove product from favourites
  void initAddToFav(FavouriteModel model, BuildContext context, WidgetRef ref) {
    final productRiver = ref.read(productRiverPod);
    if (_favProducts.map((e) => e.productId).contains(model.productId)) {
      // Remove from favourites if already present
      _productController
          .removeFromFavourite(model)
          .whenComplete(() => fetchFavouriteProducts())
          .whenComplete(() => productRiver.filterProductsWithID(ref));

      AlertHelper.showSanckBar(
          context, 'Removed from Favourite!', AnimatedSnackBarType.error);
    } else {
      // Add to favourites if not already present
      _productController
          .addToFavourite(model)
          .whenComplete(() => fetchFavouriteProducts())
          .whenComplete(() => productRiver.filterProductsWithID(ref));

      AlertHelper.showSanckBar(
          context, 'Added to Favourite!', AnimatedSnackBarType.success);
    }

    notifyListeners();
  }
}
