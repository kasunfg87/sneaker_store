import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/controller/product_controller.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/riverpod.dart';

class ProductProvider extends ChangeNotifier {
  // List to store all products
  List<ProductModel> _allProduct = [];

  // Getter for the product list
  List<ProductModel> get allProduct => _allProduct;

  // List to store the search results
  List<ProductModel> _searchProduct = [];

  // Getter for the search product list
  List<ProductModel> get searchProduct => _searchProduct;

  // Setter for the search product list
  set searchProduct(List<ProductModel> value) {
    _searchProduct = value;
    notifyListeners();
  }

  // List to store the filtered products
  List<ProductModel> _filteredProduct = [];

  // Getter for the filtered product list
  List<ProductModel> get filteredProduct => _filteredProduct;

  // List to store the favourite products
  List<ProductModel> _favouriteProduct = [];

  // Getter for the favourite product list
  List<ProductModel> get favouriteProduct => _favouriteProduct;

  // List to store shoe sizes and colors
  List<SizeModel> _shoeSize = [];

  // Getter for the shoe size list
  List<SizeModel> get shoeSize => _shoeSize;

  // Category selection
  String? _category;

  // Getter for the category
  String? get category => _category;

  // Setter for the category
  set category(String? selectedCategory) {
    _category = selectedCategory;
    notifyListeners();
  }

  // Text Editing Controllers
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _searchController = TextEditingController();

  // Getters for the text controllers
  TextEditingController get productNameController => _productNameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get priceController => _priceController;
  TextEditingController get searchController => _searchController;

  // Loading state
  bool _isLoading = false;

  // Getter for the loading state
  bool get isLoading => _isLoading;

  // Setter for the loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // Product model to store selected product data
  late ProductModel _productModel;

  // Getter for the product model
  ProductModel get productModel => _productModel;

  // Setter for the product model
  void setProductModel(ProductModel model) {
    _productModel = model;
    notifyListeners();
  }

  // Variable to store the current index
  int _selectedIndex = 0;

  // Getter for the selected index
  int get selectedIndex => _selectedIndex;

  // Setter for the selected index
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Variable to store the size index
  int _sizeIndex = 0;

  // Getter for the size index
  int get sizeIndex => _sizeIndex;

  // Setter for the size index
  void setSizeIndex(int index) {
    _sizeIndex = index;
    notifyListeners();
  }

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // File object to store selected image
  File _image = File("");

  // Getter for the image file
  File get getImage => _image;

  // Function to pick an image from the gallery and upload it
  Future<File> selectImageAndUpload() async {
    try {
      // Pick an image
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      // Check if the user has picked a file
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        notifyListeners();
        return _image;
      } else {
        Logger().e("No image selected");
        return _image;
      }
    } catch (e) {
      Logger().e(e);
      return _image;
    }
  }

  // Insert product data to Firestore
  Future<void> insertToProductDB() async {
    try {
      setLoading(true);
      // Upload the product image
      String imgUrl = await ProductController().uploadProductImage(getImage);

      if (imgUrl != "") {
        // Save the product data
        await ProductController().saveProductData(ProductModel(
          category: category.toString(),
          productId: allProduct.length + 1,
          description: descriptionController.text,
          img: imgUrl,
          title: productNameController.text,
          price: double.parse(priceController.text),
        ));
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      Logger().e(e);
    }
  }

  // Fetch all products and store in the allProduct list
  Future<void> fetchProducts() async {
    try {
      setLoading(true);
      _allProduct = await ProductController().getProducts();
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
      Logger().e(e);
    }
  }

  // Fetch all shoe sizes and colors and store in the shoeSize list
  Future<void> fetchSizedAndColors() async {
    try {
      _shoeSize = await ProductController().getSizeAndColor();
      Logger().e(_shoeSize.length);
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  // Get related products excluding the selected product
  List<ProductModel> get relatedProducts {
    return _allProduct
        .where((product) => product.productId != _productModel.productId)
        .toList();
  }

  // Get shoe size and color for the selected product
  List<SizeModel> get shoeSizeAndColor {
    return _shoeSize
        .where((size) => size.productId == _productModel.productId)
        .toList();
  }

  // Get only the shoe sizes for the selected product
  List<String> get shoeSizeOnly {
    return _shoeSize
        .where((size) => size.productId == _productModel.productId)
        .expand((size) => size.size)
        .toList();
  }

  // Clear product master data
  void clearProductMaster() {
    _productNameController.clear();
    _descriptionController.clear();
    priceController.clear();
    fetchProducts();
    _image = File("");
    notifyListeners();
  }

  // Update search results based on the search text
  void updateSearchResults(String searchText) {
    searchProduct = allProduct
        .where((product) =>
            product.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  // Filter products based on the selected category
  Future<void> filterProdutsWithCategory(String category) async {
    List<ProductModel> filteredList = _allProduct
        .where((product) =>
            product.category.toLowerCase().contains(category.toLowerCase()))
        .toList();
    Logger().e(filteredList.length);
    _filteredProduct = filteredList;
    notifyListeners();
  }

  // Filter favourite products based on product ID
  Future<void> filterFavouriteProducts(int productId) async {
    List<ProductModel> filteredList =
        _allProduct.where((product) => product.productId == productId).toList();
    Logger().e(filteredList.length);
    _filteredProduct = filteredList;
    notifyListeners();
  }

  // Filter products with favourite IDs
  Future<void> filterProdutsWithID(BuildContext context, WidgetRef ref) async {
    final favoRiver = ref.read(favouriteRiverPod);
    setLoading(true);
    List<ProductModel> filteredList = _allProduct
        .where((product) => favoRiver.favCourses
            .any((favProduct) => favProduct.productId == product.productId))
        .toList();
    Logger().e(filteredList.length);
    _favouriteProduct = filteredList;
    setLoading(false);
    notifyListeners();
  }
}
