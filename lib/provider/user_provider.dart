// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/controller/auth_controller.dart';
import 'package:sneaker_store/provider/favourite_provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/screens/drawer_screen/drawer_screen.dart';
import 'package:sneaker_store/screens/sign_in/sign_in.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/firebase_helper.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import '../models/objects.dart';

class UserProvider extends ChangeNotifier {
  //---------------- controllers

  final AuthController _authController = AuthController();

  // ----- store firebase user

  User? _firebaseUser;

  // ----- getter for firebase user

  User? get firebaseUser => _firebaseUser;

  //----- user model

  UserModel? _userModel;

  //-------get user model

  UserModel? get userModel => _userModel;

  // ----- first name controller

  final _fullNameController = TextEditingController();

  // ----- get full name controller

  TextEditingController get fullNameController => _fullNameController;

  // ----- email controller

  final _emailController = TextEditingController();

  // ----- get email controller

  TextEditingController get emailController => _emailController;

  // ----- password controller

  final _passwordController = TextEditingController();

  // ----- get password controller

  TextEditingController get passwordController => _passwordController;

  // ----- confirm password controller

  final _confirmPasswordController = TextEditingController();

  // ----- get confirm password controller

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

// ----- location controller

  final _locationController = TextEditingController();

  // ----- get location controller

  TextEditingController get locationController => _locationController;

  // ------ mobile number controller

  final _mobileController = TextEditingController();

  // ----- get location controller

  TextEditingController get mobileController => _mobileController;

  //---- loading state

  bool _isLoading = false;

  // ----- get loading state

  bool get isLoading => _isLoading;

  // -----chage loading state

  void setLoading(bool val) {
    _isLoading = val;

    notifyListeners();
  }

  void clearTextController() {
    _fullNameController.clear();

    _emailController.clear();

    _passwordController.clear();

    _confirmPasswordController.clear;

    notifyListeners();
  }

  // --- signup details validation

  bool signUpFieldsValidate(BuildContext context) {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);

      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Plese enter valid email !', AnimatedSnackBarType.error);

      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showSanckBar(
          context,
          'Password must have more then 6 digits !',
          AnimatedSnackBarType.error);

      return false;
    } else {
      return true;
    }
  }

  // --- login details validation

  bool signInFieldsValidate(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);

      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Plese enter valid email !', AnimatedSnackBarType.error);

      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showSanckBar(
          context,
          'Password must have more then 6 digits !',
          AnimatedSnackBarType.error);

      return false;
    } else {
      return true;
    }
  }

  // --- forgot password details validation

  bool forgotPasswordFieldsValidate(BuildContext context) {
    if (_emailController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);

      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Plese enter valid email !', AnimatedSnackBarType.error);

      return false;
    } else {
      return true;
    }
  }

  // ----- start signup process

  Future<void> startSignUp(BuildContext context) async {
    try {
      setLoading(true);

      await AuthController().registerUser(
        context,
        _emailController.text,
        _passwordController.text,
        _fullNameController.text,
      );

      clearTextController();

      setLoading(false);
    } catch (e) {
      setLoading(false);

      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.success);
    }
  }

  // ----- start sign in process

  Future<void> startLogin(BuildContext context) async {
    try {
      if (signInFieldsValidate(context)) {
        showDialog(
            context: context,
            builder: (contex) {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: AppColors.kDarkBlue,
              ));
            });

        setLoading(true);

        await AuthController().signInUser(
            context, _emailController.text, _passwordController.text);

        clearTextController();

        setLoading(false);
      } else {}
    } catch (e) {
      setLoading(false);

      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.success);
    }
  }

  // ----- fetch user data process

  Future<void> fetchUser(String id) async {
    try {
      //--start the loader

      setLoading(true);

      await AuthController().fetchUserData(id).then((value) {
        if (value != null) {
          Logger().w(value.fullName);

          _userModel = value;

          //---callling this to notify that usermodel has been set

          notifyListeners();

          //--start the loader

          setLoading(false);
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //------initialize and check whether the user is signed in or not

  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Logger().i('User is currently signed out!');
      } else {
        Logger().i('User is signed in!');

        Logger().i(user.uid);

        await fetchUser(user.uid).then((value) {
          // updating

          updateUserOnline(true);

          //----- fetch products and sizes
          Provider.of<ProductProvider>(context, listen: false).fetchProducts();
          Provider.of<ProductProvider>(context, listen: false)
              .fetchSizedAndColors();

          // ------ fetch fevourite products

          Provider.of<FavouriteProvider>(context, listen: false)
              .fetchFavouriteProducts()
              .whenComplete(() =>
                  Provider.of<ProductProvider>(context, listen: false)
                      .filterProdutsWithID(context));

          //

          Navigator.pushNamed(context, DrawerScreen.routeName);
        });
      }
    });
  }

  //----- send password rest link

  Future<void> sendPasswordResetLink(BuildContext context) async {
    if (forgotPasswordFieldsValidate(context)) {
      setLoading(true);

      await AuthController()
          .sendPassResetEmail(context, _emailController.text)
          .whenComplete(
            () => NavigationFunction.navigateTo(
                BuildContext, context, Widget, const SignIn()),
          );

      clearTextController();

      setLoading(false);
    }
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

  Future<void> selectImageAndUpload() async {
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

        updateProfileImage(_image);

        notifyListeners();
      } else {
        Logger().e("No image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //upload and update profile image

  Future<void> updateProfileImage(File image) async {
    try {
      //--start the loader

      setLoading(true);

      //--start uploading the image

      String imgUrl = await AuthController()
          .uploadAndUpdateProfileImage(_userModel!.uid, image);

      if (imgUrl != "") {
        //---update the usermodel img filed with returned download url

        _userModel!.img = imgUrl;

        notifyListeners();

        //--stop the loader

        setLoading(false);
      }
    } catch (e) {
      Logger().e(e);

      //--stop the loader

      setLoading(false);
    }
  }

  void updateUserOnline(bool val) {
    try {
      _authController.updateOnlineStatus(
          FirebaseHelper.auth.currentUser!.uid, val);
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> updateUserDetails() async {
    try {
      //--start the loader

      setLoading(true);

      //--start uploading user mobile number and location

      AuthController()
          .updateUserInfo(userModel!.uid, locationController.text,
              int.parse(mobileController.text))
          .whenComplete(() {
        locationController.clear();
        mobileController.clear();
        fetchUser(userModel!.uid);
      });

      notifyListeners();

      //--stop the loader

      setLoading(false);
    } catch (e) {
      Logger().e(e);

      //--stop the loader

      setLoading(false);
    }
  }
}
