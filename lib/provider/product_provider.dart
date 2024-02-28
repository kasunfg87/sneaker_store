import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/controller/product_controller.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/favourite_provider.dart';

class ProductProvider extends ChangeNotifier {
  // ----- a list to store the all products list

  List<ProductModel> _allProduct = [];

  // ----- getter for porduct list

  List<ProductModel> get allProduct => _allProduct;

  // ----- a list to store the search products list

  List<ProductModel> _searchProduct = [];

  // ----- getter for search porduct list

  List<ProductModel> get searchProduct => _searchProduct;

  // ------ setter for search product list

  set searchProduct(List<ProductModel> value) {
    _searchProduct = value;
    notifyListeners();
  }

  // ----- a list to store the filtered products list

  List<ProductModel> _filteredProduct = [];

  // ----- getter for filtered porduct list

  List<ProductModel> get filteredProduct => _filteredProduct;

  // ----- a list to store the favourite products list

  List<ProductModel> _favouriteProduct = [];

  // ----- getter for favourite porduct list

  List<ProductModel> get favouriteProduct => _favouriteProduct;

  // ----- shoe sizes and colors

  List<SizeModel> _shoeSize = [];

  // ----- getter for porduct list

  List<SizeModel> get shoeSize => _shoeSize;

  // ----- category

  String? _category;

  // ----- getter for category

  String? get category => _category;

  // ----- setter for category

  set category(String? selectedCategory) {
    _category = selectedCategory;
    notifyListeners();
  }

  //----------------Text Editing  Controllers -------------------

  // ----- product name controller

  final _productNameController = TextEditingController();

  // ----- getter for  product name controller

  TextEditingController get productNameController => _productNameController;

  // ----- product description controller

  final _descriptionController = TextEditingController();

  // ----- getter for product description controller

  TextEditingController get descriptionController => _descriptionController;

  // ----- product price controller

  final _priceController = TextEditingController();

  // ----- getter for product price controller

  TextEditingController get priceController => _priceController;

  // -----search product  controller

  final _searchController = TextEditingController();

  // ----- getter for search product controller

  TextEditingController get searchController => _searchController;

  // ----- loading state

  bool _isLoading = false;

  // ----- get loading state

  bool get isLoading => _isLoading;

  // -----setter for loading state

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // ----- product model for to store selected product data

  late ProductModel _productModel;

  // ----- getter for product model

  ProductModel get productModel => _productModel;

  // -----setter for porduct model

  void setProductModel(ProductModel model) {
    _productModel = model;
    notifyListeners();
  }

  // ------- variable to store current index

  int _selectedIndex = 0;

  // ----- getter for selected index

  int get selectedIndex => _selectedIndex;

  // ------ setter for selected index

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // ------- variable to store size index

  int _sizeIndex = 0;

  // ----- getter for selected index

  int get sizeIndex => _sizeIndex;

  // ------ setter for selected index

  void setSizeIndex(int index) {
    _sizeIndex = index;
    notifyListeners();
  }

  //------------------pick, upload and update user profile image
  //---------pick an image

  //image picker instance
  final ImagePicker _picker = ImagePicker();

  //-----file object
  File _image = File("");

  //-----getter for image file
  File get getImage => _image;

  //---a function to pick a file from gallery
  Future<File> selectImageAndUpload() async {
    try {
      // Pick an image
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      //---check if the user has picked a file or not
      if (pickedFile != null) {
        // Logger().i(pickedFile.path);
        //--assigning to the file object
        _image = File(pickedFile.path);

        //start uploading the image after picking
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

  //----- insert product data to firesotre db

  Future<void> insertToProductDB() async {
    try {
      setLoading(true);
      //--start uploading the image
      String imgUrl = await ProductController().uploadProductImage(getImage);

      if (imgUrl != "") {
        ProductController().saveProdctData(ProductModel(
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
      //--stop the loader
    }
  }

  // ---- fetch all product and store in all product list

  Future<void> fetchProducts() async {
    try {
      setLoading(true);
      // ----- start fetching product
      _allProduct = await ProductController().getProducts();

      setLoading(false);

      notifyListeners();
    } catch (e) {
      setLoading(false);
      Logger().e(e);
    }
  }

  // ---- fetch all product and store in all product list

  Future<void> fetchSizedAndColors() async {
    try {
      // ----- start fetching products

      _shoeSize = await ProductController().getSizeAndColor();

      Logger().e(_shoeSize.length);

      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  // ----- get releted products

  List<ProductModel> get relatedProducts {
    List<ProductModel> temp = [];
    // ----- filtering the porduct list
    // ----- removing the already selceted porduct
    for (var i = 0; i < _allProduct.length; i++) {
      if (_allProduct[i].productId != _productModel.productId) {
        temp.add(_allProduct[i]);
      }
    }
    return temp;
  }

  // ----- get shoe size and color using product id

  List<SizeModel> get shoeSizeAndColor {
    List<SizeModel> temp = [];
    // ----- filtering the porduct list
    // ----- removing the already selceted porduct
    for (var i = 0; i < _shoeSize.length; i++) {
      if (_shoeSize[i].productId == _productModel.productId) {
        temp.add(_shoeSize[i]);
      }
    }
    return temp;
  }

  List<String> get shoeSizeOnly {
    List<String> temp = [];

    for (var i = 0; i < _shoeSize.length; i++) {
      if (_shoeSize[i].productId == _productModel.productId) {
        temp.addAll(_shoeSize[i].size);
      }
    }

    return temp;
  }

  //  ------- clear product master

  void clearProductMaster() {
    _productNameController.clear();
    _descriptionController.clear();
    priceController.clear();
    fetchProducts();
    _image = File("");
    notifyListeners();
  }

  // ----- search products with title

  void updateSearchResults(String searchText) {
    searchProduct.clear();

    searchProduct = allProduct
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  // ----- filter product with category

  Future<void> filterProdutsWithCategory(String category) async {
    // create an empty list to store filtered courses
    List<ProductModel> filteredList = [];

    // if search text is empty or equal to 0, show all courses
    // ignore: unrelated_type_equality_checks
    if (allProduct.isEmpty || allProduct == '0') {
      filteredList = _allProduct;
    } else {
      // loop through each course and check if its title contains the search text
      for (var item in _allProduct) {
        if (item.category.toLowerCase().contains(category.toLowerCase())) {
          // if the course title contains the search text, add it to the filtered list
          filteredList.add(item);
        }
      }
    }
    Logger().e(filteredList.length);
    // update the state of the filtered courses list
    _filteredProduct = filteredList;
    notifyListeners();
  }

  Future<void> filterFavouriteProducts(int productid) async {
    // create an empty list to store filtered courses
    List<ProductModel> filteredList = [];

    // if search text is empty or equal to 0, show all courses
    // ignore: unrelated_type_equality_checks
    if (allProduct.isEmpty || allProduct == '0') {
      filteredList = _allProduct;
    } else {
      // loop through each course and check if its title contains the search text
      for (var item in _allProduct) {
        if (item.productId == productid) {
          // if the course title contains the search text, add it to the filtered list
          filteredList.add(item);
        }
      }
    }
    Logger().e(filteredList.length);
    // update the state of the filtered courses list
    _filteredProduct = filteredList;
    notifyListeners();
  }

  // ----- filter product with category

  Future<void> filterProdutsWithID(BuildContext context) async {
    setLoading(true);
    // create an empty list to store filtered courses
    List<ProductModel> filteredList = _allProduct
        .where((product) =>
            Provider.of<FavouriteProvider>(context, listen: false)
                .favCourses
                .any((favProduct) => favProduct.productId == product.productId))
        .toList();
    Logger().e(filteredList.length);
    // update the state of the filtered courses list
    _favouriteProduct = filteredList;
    setLoading(false);
    notifyListeners();
  }
}
