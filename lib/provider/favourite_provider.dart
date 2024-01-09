// ignore_for_file: avoid_print, unnecessary_null_comparison


import 'package:animated_snack_bar/animated_snack_bar.dart';


import 'package:flutter/material.dart';


import 'package:logger/logger.dart';


import 'package:provider/provider.dart';


import 'package:sneaker_store/controller/product_controller.dart';


import 'package:sneaker_store/models/objects.dart';


import 'package:sneaker_store/provider/product_provider.dart';


import 'package:sneaker_store/utilities/alert_helper.dart';


class FavouriteProvider extends ChangeNotifier {

  // ----- a list to store the favourites list


  List<FavouriteModel> _favCourses = [];


  // ----- getter for favourites  list


  List<FavouriteModel> get favCourses => _favCourses;


  bool _isLoading = false;


  // ----- get loading state


  bool get isLoading => _isLoading;


  // -----chage loading state


  void setLoading(bool val) {

    _isLoading = val;

  }


  final ProductController _productController = ProductController();


  // ----- fetch products function


  Future<void> fetchFavouriteProducts() async {

    try {

      // ----- start the loader


      setLoading(true);


      // ----- start fetching products


      _favCourses = await _productController.getFavoriteProducts();


      Logger().e(favCourses.length);


      notifyListeners();


      // ----- stop the loader


      setLoading(false);

    } catch (e) {

      print(e);


      // ----- stop the loader


      setLoading(false);

    }

  }


  // ----- adding clicked fav courses to the firebase


  void initAddToFav(FavouriteModel model, BuildContext context) {

    if (_favCourses.map((e) => e.productId).contains(model.productId)) {

      _productController

          .removeFromFavourite(model)

          .whenComplete(() => fetchFavouriteProducts())

          .whenComplete(() =>

              Provider.of<ProductProvider>(context, listen: false)

                  .filterProdutsWithID(context));


      AlertHelper.showSanckBar(

          context, 'Removed from Favourite !', AnimatedSnackBarType.error);


      notifyListeners();

    } else {

      _productController

          .addToFavourite(model)

          .whenComplete(() => fetchFavouriteProducts())

          .whenComplete(() =>

              Provider.of<ProductProvider>(context, listen: false)

                  .filterProdutsWithID(context));


      AlertHelper.showSanckBar(

          context, 'Added to Favourite !', AnimatedSnackBarType.success);


      notifyListeners();

    }

  }

}

