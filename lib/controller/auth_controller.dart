// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/screens/home/home.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import '../models/objects.dart';
import 'file_upload_controller.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance; // Firebase auth instance
  final CollectionReference users = FirebaseFirestore.instance
      .collection('users'); // Firestore users collection reference

  // Register a new user
  Future<void> registerUser(BuildContext context, String email, String password,
      String fullName) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          await saveUserData(UserModel(value.user!.uid, fullName, email, '', '',
              AssetConstants.avatar, DateTime.now().toString(), true, ''));
          AlertHelper.showSanckBar(
              context,
              'Your account has been successfully created!',
              AnimatedSnackBarType.success);
        }
      });
    } on FirebaseAuthException catch (e) {
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.error);
    } catch (e) {
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.error);
    }
  }

  // Save user data in Firestore
  Future<void> saveUserData(UserModel model) async {
    return users
        .doc(model.uid)
        .set(model.toJson(), SetOptions(merge: true))
        .then((value) => Logger().i("User data saved"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }

  // Fetch user data from Firestore
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await users.doc(uid).get();
      UserModel model =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      Logger().w(model.toJson());
      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  // Sign in an existing user
  Future<void> signInUser(
      BuildContext context, String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          CustomNavigator.navigateTo(context, const Home());
        } else {
          // Handle case when the user does not exist
        }
      });
    } on FirebaseAuthException catch (e) {
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.error);
    } catch (e) {
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.error);
    }
  }

  // Sign out the current user
  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  // Send password reset email
  Future<void> sendPassResetEmail(BuildContext context, String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      AlertHelper.showAlert(context, DialogType.success, "Email Sent!",
          "Please check your inbox!");
    });
  }

  // Upload and update user profile image
  Future<String> uploadAndUpdateProfileImage(String uid, File image) async {
    try {
      UploadTask? task =
          FileUploadController.uploadFile(image, "profileImages");
      final snapshot = await task!.whenComplete(() {});
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await users.doc(uid).update({'img': downloadUrl});
      return downloadUrl;
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  // Update user's online status
  Future<void> updateOnlineStatus(String uid, bool isOnline) async {
    await users
        .doc(uid)
        .update({"isOnline": isOnline, "lastSeen": DateTime.now().toString()})
        .then((value) => Logger().i("Online status updated"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }

  // Update user information
  Future<void> updateUserInfo(
      String uid, String location, int mobileNumber) async {
    await users
        .doc(uid)
        .update({"location": location, "mobileNo": mobileNumber})
        .then((value) => Logger().i("User info updated"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }
}
