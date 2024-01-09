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
  // Firebase auth instance

  final FirebaseAuth auth = FirebaseAuth.instance;

  // Creates the user collection reference in Firestore

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //-------- Signup function

  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
    String fullName,
  ) async {
    try {
      //----send email and password to Firebase and create a user

      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        // Check if the userCredential object is not null

        if (value.user != null) {
          //---save other user data in Cloud Firestore

          await saveUserData(UserModel(
            value.user!.uid,
            fullName,
            email,
            '',
            '',
            AssetConstants.avatar,
            DateTime.now().toString(),
            true,
            '',
          ));

          // If user created successfully, show an alert

          AlertHelper.showSanckBar(
            context,
            'Your account has been successfully created!',
            AnimatedSnackBarType.success,
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      //---show error dialog

      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.success);
    } catch (e) {
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.success);
    }
  }

  Future<void> saveUserData(UserModel model) async {
    return users
        .doc(model.uid)
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("user data saved"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }

  //------------fetch user data saved in Cloud Firestore

  Future<UserModel?> fetchUserData(String uid) async {
    try {
      // Firebase query that fetches user data

      DocumentSnapshot snapshot = await users.doc(uid).get();

      // Mapping fetched data to UserModel

      UserModel model =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);

      Logger().w(model.toJson());

      return model;
    } catch (e) {
      Logger().e(e);

      return null;
    }
  }

  //------sign in user function

  Future<void> signInUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      //----send email and password to Firebase and check if the user exists or not

      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          // If the user exists, navigate to the Home widget

          NavigationFunction.navigateTo(
              BuildContext, context, Widget, const Home());
        } else {
          // Handle case when the user does not exist
        }
      });

      // await fetchUserData(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      //---show error dialog

      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.error);
    } catch (e) {
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.error);
    }
  }

  //----sign out function

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  //----send password reset email

  Future<void> sendPassResetEmail(BuildContext context, String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      //--show a dialog when the email is sent

      AlertHelper.showAlert(context, DialogType.SUCCES, "Email Sent !",
          "Please check your inbox !");
    });
  }

  //-------upload and update user profile and return the image URL

  Future<String> uploadAndUpdateProfileImage(
    String uid,
    File image,
  ) async {
    try {
      //---uploading the image file to profile images

      UploadTask? task =
          FileUploadController.uplaodFile(image, "profileImages");

      final snapshot = await task!.whenComplete(() {});

      //---getting the download URL

      final String downloadUrl = await snapshot.ref.getDownloadURL();

      //---saving the user data in Cloud Firestore

      await users.doc(uid).update({
        'img': downloadUrl,
      });

      return downloadUrl;
    } catch (e) {
      Logger().e(e);

      return "";

      // AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  Future<void> updateOnlineStatus(String uid, bool isOnline) async {
    await users
        .doc(uid)
        .update({"isOnline": isOnline, "lastSeen": DateTime.now().toString()})
        .then((value) => Logger().i("Online status updated"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }

  Future<void> updateUserInfo(
      String uid, String location, int mobileNumber) async {
    await users
        .doc(uid)
        .update({"location": location, "mobileNo": mobileNumber})
        .then((value) => Logger().i("User info updated"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }
}
