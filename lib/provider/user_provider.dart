// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/controller/auth_controller.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/drawer_screen/drawer_screen.dart';
import 'package:sneaker_store/screens/sign_in/sign_in.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/firebase_helper.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import '../models/objects.dart';

class UserProvider extends ChangeNotifier {
  // Controllers for various user inputs
  final AuthController _authController = AuthController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  // Firebase user and user model
  User? _firebaseUser;
  UserModel? _userModel;

  // Loading state
  bool _isLoading = false;

  // Image picker instance and file
  final ImagePicker _picker = ImagePicker();
  File _image = File("");

  // Getters
  User? get firebaseUser => _firebaseUser;
  UserModel? get userModel => _userModel;
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get locationController => _locationController;
  TextEditingController get mobileController => _mobileController;
  bool get isLoading => _isLoading;
  File get getImage => _image;

// Function to initialize and set values
  void setTextControllers() {
    _fullNameController.text = userModel!.fullName;
    _emailController.text = userModel!.email;
    _locationController.text = userModel!.location;
    _mobileController.text = userModel!.mobileNo;
  }

  // Set loading state and notify listeners
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // Clear text controllers
  void clearTextController() {
    _fullNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    notifyListeners();
  }

  // Validate signup fields
  bool signUpFieldsValidate(BuildContext context) {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      AlertHelper.showSanckBar(
          context, 'Empty fields are not allowed!', AnimatedSnackBarType.error);
      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Please enter a valid email!', AnimatedSnackBarType.error);
      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showSanckBar(
          context,
          'Password must have more than 6 characters!',
          AnimatedSnackBarType.error);
      return false;
    } else {
      return true;
    }
  }

  // Validate login fields
  bool signInFieldsValidate(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      AlertHelper.showSanckBar(
          context, 'Empty fields are not allowed!', AnimatedSnackBarType.error);
      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Please enter a valid email!', AnimatedSnackBarType.error);
      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showSanckBar(
          context,
          'Password must have more than 6 characters!',
          AnimatedSnackBarType.error);
      return false;
    } else {
      return true;
    }
  }

  // Validate forgot password fields
  bool forgotPasswordFieldsValidate(BuildContext context) {
    if (_emailController.text.isEmpty) {
      AlertHelper.showSanckBar(
          context, 'Empty fields are not allowed!', AnimatedSnackBarType.error);
      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Please enter a valid email!', AnimatedSnackBarType.error);
      return false;
    } else {
      return true;
    }
  }

  // Start signup process
  Future<void> startSignUp(BuildContext context) async {
    try {
      setLoading(true);
      await _authController.registerUser(
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
          context, e.toString(), AnimatedSnackBarType.error);
    }
  }

  // Start login process
  Future<void> startLogin(BuildContext context) async {
    try {
      if (signInFieldsValidate(context)) {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: AppColors.kDarkBlue,
              ),
            );
          },
        );
        setLoading(true);
        await _authController.signInUser(
            context, _emailController.text, _passwordController.text);
        clearTextController();
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.error);
    }
  }

  // Fetch user data
  Future<void> fetchUser(String id) async {
    try {
      setLoading(true);
      await _authController.fetchUserData(id).then((value) {
        if (value != null) {
          Logger().w(value.fullName);
          _userModel = value;
          notifyListeners();
          setLoading(false);
        }
      });
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  // Initialize user and check sign-in status
  Future<void> initializeUser(BuildContext context, WidgetRef ref) async {
    final productProvider = ref.read(productRiverPod);
    final favouriteProvider = ref.read(favouriteRiverPod);
    final orderProvider = ref.read(orderRiverPod);
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Logger().i('User is currently signed out!');
      } else {
        Logger().i('User is signed in!');
        Logger().i(user.uid);
        await fetchUser(user.uid).then((value) {
          updateUserOnline(true);

          productProvider.fetchProducts();
          productProvider.fetchSizedAndColors();
          favouriteProvider.fetchFavouriteProducts();
          productProvider.filterProductsWithID(ref);
          orderProvider.fetchOrders(user.uid);
          setTextControllers();

          Navigator.pushNamed(context, DrawerScreen.routeName);
        });
      }
    });
  }

  // Send password reset link
  Future<void> sendPasswordResetLink(BuildContext context) async {
    if (forgotPasswordFieldsValidate(context)) {
      setLoading(true);
      await _authController
          .sendPassResetEmail(context, _emailController.text)
          .whenComplete(() {
        CustomNavigator.navigateTo(context, const SignIn());
      });
      clearTextController();
      setLoading(false);
    }
  }

  // Select image and upload
  Future<void> selectImageAndUpload() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        updateProfileImage(_image);
        notifyListeners();
      } else {
        Logger().e("No image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  // Update profile image
  Future<void> updateProfileImage(File image) async {
    try {
      setLoading(true);
      String imgUrl = await _authController.uploadAndUpdateProfileImage(
          _userModel!.uid, image);
      if (imgUrl.isNotEmpty) {
        _userModel!.img = imgUrl;
        notifyListeners();
        setLoading(false);
      }
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  // Update user online status
  void updateUserOnline(bool val) {
    try {
      _authController.updateOnlineStatus(
          FirebaseHelper.auth.currentUser!.uid, val);
    } catch (e) {
      Logger().e(e);
    }
  }

  // Update user details
  Future<void> updateUserDetails() async {
    try {
      setLoading(true);
      _authController
          .updateUserInfo(userModel!.uid, locationController.text,
              int.parse(mobileController.text))
          .whenComplete(() {
        locationController.clear();
        mobileController.clear();
        fetchUser(userModel!.uid);
      });
      notifyListeners();
      setLoading(false);
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }
}
